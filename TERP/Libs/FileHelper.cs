using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace TERP.Libs
{
    public class FileHelper
    {
        FileUpload myFileUpload=null;

        public FileHelper(FileUpload fu)
        {
            this.myFileUpload = fu;
        }

        public List<string> readFile()
        {
            if (myFileUpload!=null)
            {
                List<string> ret = new List<string>();
                StreamReader reader = new StreamReader(myFileUpload.FileContent);
                do
                {
                    ret.Add(reader.ReadLine());
                } while (reader.Peek() != -1);
                reader.Close();
                return ret;
            }

            return null;
        }
    }
}