<?php
class EasyAES {
	private $iv;
	private $key;
	private $bit; //Only can use 128, 256
	
	function __construct($key, $bit = 128, $iv = "") {
		// gen key
		if($bit == 256){
			$this->key = hash('SHA256', $key, true);
		}else{
			$this->key = hash('MD5', $key, true);
		}

		// gen iv
		if($iv != ""){
			$this->iv = hash('MD5', $iv, true);
		}else{
			$this->iv = chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0); //IV is not set. It doesn't recommend.
		}
	}

	function encrypt($str) {
		if(version_compare(PHP_VERSION, '7.0.0', 'ge')) {
			return $this->opensslEncrypt($str);
		} else {
			return $this->mcryptEncrypt($str);
		}
	}

	function decrypt($str) {
		if(version_compare(PHP_VERSION, '7.0.0', 'ge')) {
			return $this->opensslDecrypt($str);
		} else {
			return $this->mcryptDecrypt($str);
		}
	}

	private function opensslEncrypt($str) {
		$data = openssl_encrypt($str, 'AES-128-CBC', $this->key, OPENSSL_RAW_DATA, $this->iv);
		return base64_encode($data);
	}

	private function opensslDecrypt($str) {
		$decrypted = openssl_decrypt(base64_decode($str), 'AES-128-CBC', $this->key, OPENSSL_RAW_DATA, $this->iv);
		return $decrypted;
	}

	private function mcryptEncrypt($str) {
		//Open
		$module = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '');
		mcrypt_generic_init($module, $this->key, $this->iv);

		//Padding
		$block = mcrypt_get_block_size(MCRYPT_RIJNDAEL_128, MCRYPT_MODE_CBC); //Get Block Size
		$pad = $block - (strlen($str) % $block); //Compute how many characters need to pad
		$str .= str_repeat(chr($pad), $pad); // After pad, the str length must be equal to block or its integer multiples

		//Encrypt
		$encrypted = mcrypt_generic($module, $str);

		//Close
		mcrypt_generic_deinit($module);
		mcrypt_module_close($module);

		//Return
		return base64_encode($encrypted);
	}

	private function mcryptDecrypt($str) {
		//Open
		$module = mcrypt_module_open(MCRYPT_RIJNDAEL_128, '', MCRYPT_MODE_CBC, '');
		mcrypt_generic_init($module, $this->key, $this->iv);

		//Decrypt
		$str = mdecrypt_generic($module, base64_decode($str)); //Get original str

		//Close
		mcrypt_generic_deinit($module);
		mcrypt_module_close($module);

		//Depadding
		$slast = ord(substr($str, -1)); //pad value and pad count
		$str = substr($str, 0, strlen($str) - $slast);

		//Return
		return $str;
	}

	static function encryptString($content) {
		//Set password and iv string here, note that they are both 16-bit characters
		$aes = new EasyAES('****************', 128, '################');
		return $aes->encrypt($content);
	}

	static function decryptString($content) {
		//Set password and iv string here, note that they are both 16-bit characters
		$aes = new EasyAES('****************', 128, '################');
		return $aes->decrypt($content);
	}
}
