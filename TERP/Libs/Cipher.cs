using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TERP.Libs
{
    public class Cipher
    {
        private const string passPhrase = "654321";
        private string encPass = "";

        public Cipher()
        {
            encPass = passPhrase;
        }

        public Cipher(string pw)
        {
            encPass = pw;
        }

        public string Encrypt(string plainText)
        {
            return null;
        }

        public string Decrypt(string cipherText)
        {
            return null;
        }

    }
}