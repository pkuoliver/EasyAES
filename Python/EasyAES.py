from Crypto.Cipher import AES
import base64
import hashlib

class EasyAES(object):

	def __init__(self, key, iv):
		self.key = hashlib.md5(key.encode('utf-8')).digest()
		self.iv  = hashlib.md5(iv.encode('utf-8')).digest()

		self.mode = AES.MODE_CBC
		self.bs   = AES.block_size

		# AES/CBC/PKCS5PADDING
		self.pad   = lambda s: s + (self.bs - len(s) % self.bs) * chr(self.bs - len(s) % self.bs)
		self.unpad = lambda s: s[:-ord(s[len(s) - 1:])]

	def encrypt(self, text):
		cryptor = AES.new(self.key, self.mode, self.iv)
		ciphertext = cryptor.encrypt(self.pad(text).encode('utf-8'))
		return base64.b64encode(ciphertext).decode()

	def decrypt(self, text):
		text = base64.b64decode(text)
		cryptor = AES.new(self.key, self.mode, self.iv)
		return self.unpad(cryptor.decrypt(text)).decode()
