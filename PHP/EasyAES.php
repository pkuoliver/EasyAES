<?php
class EasyAESCrypt {
	private $iv;
	private $key;
	private $bit; //Only can use 128, 256
	function EasyAESCrypt($key, $bit = 128, $iv = "") {
		if($bit == 256){
			$this->key = hash('SHA256', $key, true);
		}else{
			$this->key = hash('MD5', $key, true);
		}
		if($iv != ""){
			$this->iv = hash('MD5', $iv, true);
		}else{
			$this->iv = chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0).chr(0); //IV is not set. It doesn't recommend.
		}
	}

	function encrypt($str) {
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

	function decrypt($str) {   
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
}
