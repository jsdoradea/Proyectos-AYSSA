using System;
using System.IO;
using System.Text;
using System.Security.Cryptography;

namespace SIS.Framework.Common
{
    public class CEncriptacion
    {
        byte[] _key = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24};
        byte[] _iv = {65, 110, 68, 26, 69, 178, 200, 219};
 
        public byte[] Encrypt(string plainText) {
 
            // Declare a UTF8Encoding object so we may use the GetByte
            // method to transform the plainText into a Byte array.
            UTF8Encoding utf8encoder = new UTF8Encoding();
            byte[] inputInBytes = utf8encoder.GetBytes(plainText);
 
            // Create a new TripleDES service provider
            TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider();
 
            // The ICryptTransform interface uses the TripleDES
            // crypt provider along with encryption key and init vector
            // information
            ICryptoTransform cryptoTransform = tdesProvider.CreateEncryptor(_key, _iv);
 
            // All cryptographic functions need a stream to output the
            // encrypted information. Here we declare a memory stream
            // for this purpose.
            MemoryStream encryptedStream = new MemoryStream();
            CryptoStream cryptStream = new CryptoStream(encryptedStream, cryptoTransform, CryptoStreamMode.Write);
 
            // Write the encrypted information to the stream. Flush the information
            // when done to ensure everything is out of the buffer.
            cryptStream.Write(inputInBytes, 0, inputInBytes.Length);
            cryptStream.FlushFinalBlock();
            encryptedStream.Position = 0;
 
            // Read the stream back into a Byte array and return it to the calling
            // method.
            byte [] result = new byte[encryptedStream.Length];
            
            encryptedStream.Read(result, 0, (int) encryptedStream.Length);
            cryptStream.Close();
 
            return result;
 
 
            //            Dim myutf As UTF8Encoding = New UTF8Encoding()
            //           Return myutf.GetString(result)
 
        }  
 
        public string Decrypt(byte []inputInBytes) {
            // UTFEncoding is used to transform the decrypted Byte Array
            // information back into a string.
            //  Dim utf8encoder As UTF8Encoding = New UTF8Encoding()
            //    Dim inputInBytes() As Byte = utf8encoder.GetBytes(Mensaje)
 
            //ReDim inputInBytes(Mensaje.Length + 1)
 
            // inputInBytes = utf8encoder.GetBytes(Mensaje)
 
            TripleDESCryptoServiceProvider tdesProvider = new TripleDESCryptoServiceProvider();
 
            // As before we must provide the encryption/decryption key along with
            // the init vector.
            ICryptoTransform cryptoTransform = tdesProvider.CreateDecryptor(_key, _iv);
 
            // Provide a memory stream to decrypt information into
            MemoryStream decryptedStream = new MemoryStream();
            CryptoStream cryptStream = new CryptoStream(decryptedStream, cryptoTransform, CryptoStreamMode.Write);
            cryptStream.Write(inputInBytes, 0, inputInBytes.Length);
            cryptStream.FlushFinalBlock();
            decryptedStream.Position = 0;
 
            // Read the memory stream and convert it back into a string
            byte[] result = new byte[decryptedStream.Length];
            decryptedStream.Read(result, 0, (int)decryptedStream.Length);
            cryptStream.Close();
 
            //Return result
 
            UTF8Encoding myutf = new UTF8Encoding();
            return myutf.GetString(result);
        }

        public static string ToBase64(byte[] data)
        {
            if( data == null ) throw new ArgumentNullException("data");
            return Convert.ToBase64String(data);
        }  
 
        public static string ToBase64(string Mensaje) {
            UTF8Encoding utf8encoder = new UTF8Encoding();
            byte[] data = utf8encoder.GetBytes(Mensaje);
 
            if( data == null ) throw new ArgumentNullException("data");
 
            return Convert.ToBase64String(data);
        }  
 
        public static byte[] FromBase64(string base64) {
            if( base64 == null ) throw new ArgumentNullException("base64");
            return Convert.FromBase64String(base64);
        }  
 
        public static string FromBase64S(string base64) {
            if( base64 == null ) throw new ArgumentNullException("base64");
 
            UTF8Encoding myutf = new UTF8Encoding();
            return myutf.GetString(Convert.FromBase64String(base64));
 
        }
    }
}