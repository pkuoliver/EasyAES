using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;

namespace ConsoleApp
{
	class EasyAES
	{
		private byte[] Key;
		private byte[] Iv;

		public EasyAES(string key, string iv)
		{
			Init(key, 128, iv);
		}

		public EasyAES(string key, int bit, string iv)
		{
			Init(key, bit, iv);
		}

		private void Init(string key, int bit, string iv)
		{
			MD5 md5 = MD5.Create();
			if (bit == 256)
			{
				using (SHA256Managed sha = new SHA256Managed())
				{
					Key = sha.ComputeHash(Encoding.UTF8.GetBytes(key));
				}
			}
			else
			{
				Key = md5.ComputeHash(Encoding.UTF8.GetBytes(key));
			}

			Iv = md5.ComputeHash(Encoding.UTF8.GetBytes(iv));
		}

		public string Encrypt(string text)
		{
			byte[] encrypted;
			using (AesManaged aes = new AesManaged())
			{
				aes.Mode = CipherMode.CBC;
				aes.Padding = PaddingMode.PKCS7;

				ICryptoTransform encryptor = aes.CreateEncryptor(Key, Iv);
				using (MemoryStream ms = new MemoryStream())
				{
					using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
					{
						using (StreamWriter sw = new StreamWriter(cs))
						{
							sw.Write(text);
						}
						encrypted = ms.ToArray();
					}
				}
			}
			return Convert.ToBase64String(encrypted);
		}

		public string Decrypt(string text)
		{
			string plaintext = null;
			using (AesManaged aes = new AesManaged())
			{
				aes.Mode = CipherMode.CBC;
				aes.Padding = PaddingMode.PKCS7;

				ICryptoTransform decryptor = aes.CreateDecryptor(Key, Iv);
				using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(text)))
				{
					using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
					{
						using (StreamReader reader = new StreamReader(cs))
						{
							plaintext = reader.ReadToEnd();
						}
					}
				}
			}
			return plaintext;
		}
	}
}
