using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TERP.Libs
{
    public class Tools
    {
        public const int U_TYPE_SYSADMIN = 3;
        public const int U_TYPE_GROUPADMIN = 2;
        public const int U_TYPE_USER = 1;
        public const int ERROR = -99999;

        public const int TYPE_INT = 0;
        public const int TYPE_LONG = 1;
        public const int TYPE_DOUBLE = 2;
        public const int TYPE_FLOAT = 3;

        public static void writeLog(string action, string table_name, string action_detail, string emp_id)
        {
            SqlDataSource ds = new SqlDataSource();
            ds.ConnectionString = getConnectionString("STFApp");

            string sql = "INSERT INTO SYS_trace_log ([action],[table_name],[action_detail],[action_date],[action_by]) VALUES (";
            sql = sql + "'" + action + "','" + table_name + "','" + action_detail + "','" + DateTime.Now.ToString() + "','" + emp_id + "')";

            ds.InsertCommand = sql;
            ds.Insert();
        }

        public const string IMG_HEADER = "data:image/png;base64,";

        public static void refreshTreeList(UserControl uc, string tType)
        {
            //STFLibrary.Tools.refreshTreeList(uc, tType);
        }

        public static Bitmap createThumbnail(string lcFilename, int lnWidth, int lnHeight)
        {
            System.Drawing.Bitmap bmpOut = null;
            try
            {
                Bitmap loBMP = new Bitmap(lcFilename);
                System.Drawing.Imaging.ImageFormat loFormat = loBMP.RawFormat;

                decimal lnRatio;
                int lnNewWidth = 0;
                int lnNewHeight = 0;

                if (loBMP.Width < lnWidth && loBMP.Height < lnHeight)
                    return loBMP;

                if (loBMP.Width > loBMP.Height)
                {
                    lnRatio = (decimal)lnWidth / loBMP.Width;
                    lnNewWidth = lnWidth;
                    decimal lnTemp = loBMP.Height * lnRatio;
                    lnNewHeight = (int)lnTemp;
                }
                else
                {
                    lnRatio = (decimal)lnHeight / loBMP.Height;
                    lnNewHeight = lnHeight;
                    decimal lnTemp = loBMP.Width * lnRatio;
                    lnNewWidth = (int)lnTemp;
                }

                bmpOut = new Bitmap(lnNewWidth, lnNewHeight);
                Graphics g = Graphics.FromImage(bmpOut);
                g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                g.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                g.FillRectangle(Brushes.White, 0, 0, lnNewWidth, lnNewHeight);
                g.DrawImage(loBMP, 0, 0, lnNewWidth, lnNewHeight);

                loBMP.Dispose();
            }
            catch
            {
                return null;
            }
            return bmpOut;
        }

        private static byte[] BitmapToByteArray(Bitmap bmp)
        {
            byte[] data;
            using (System.IO.MemoryStream stream = new System.IO.MemoryStream())
            {
                bmp.Save(stream, System.Drawing.Imaging.ImageFormat.Bmp);
                stream.Position = 0;
                data = new byte[stream.Length];
                stream.Read(data, 0, (int)stream.Length);
                stream.Close();
            }

            return data;
        }

        public static byte[] CreateThumbnailByteArray(string lcFilename, int lnWidth, int lnHeight)
        {
            System.Drawing.Bitmap bmpOut = null;
            try
            {
                Bitmap loBMP = new Bitmap(lcFilename);
                System.Drawing.Imaging.ImageFormat loFormat = loBMP.RawFormat;

                decimal lnRatio;
                int lnNewWidth = 0;
                int lnNewHeight = 0;

                if (loBMP.Width < lnWidth && loBMP.Height < lnHeight)
                    return BitmapToByteArray(loBMP);

                if (loBMP.Width > loBMP.Height)
                {
                    lnRatio = (decimal)lnWidth / loBMP.Width;
                    lnNewWidth = lnWidth;
                    decimal lnTemp = loBMP.Height * lnRatio;
                    lnNewHeight = (int)lnTemp;
                }
                else
                {
                    lnRatio = (decimal)lnHeight / loBMP.Height;
                    lnNewHeight = lnHeight;
                    decimal lnTemp = loBMP.Width * lnRatio;
                    lnNewWidth = (int)lnTemp;
                }

                bmpOut = new Bitmap(lnNewWidth, lnNewHeight);
                Graphics g = Graphics.FromImage(bmpOut);
                g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                g.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                g.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                g.FillRectangle(Brushes.White, 0, 0, lnNewWidth, lnNewHeight);
                g.DrawImage(loBMP, 0, 0, lnNewWidth, lnNewHeight);

                loBMP.Dispose();
            }
            catch
            {
                return null;
            }
            return BitmapToByteArray(bmpOut);
        }

        public static bool checkINT(string input)
        {
            try
            {
                int i = int.Parse(input);
                return true;
            }
            catch { return false; }
        }

        public static bool checkDOUBLE(string input)
        {
            try
            {
                double i = double.Parse(input);
                return true;
            }
            catch { return false; }
        }

        public static int convertToINT(string input, string culture_name)
        {
            string separate = (culture_name == "en-US") ? "." : ",";

            if (input.Length > 0)
            {
                int i = input.IndexOf(separate);
                if (i > 0)
                {
                    return int.Parse(input.Substring(0, i));
                }
                else
                {
                    return int.Parse(input);
                }
            }
            return ERROR;
        }

        public static bool checkDate(string input, string formats)
        {
            //string[] formats = { "d/MM/yyyy", "dd/MM/yyyy" };
            DateTime parsedDate;
            return DateTime.TryParseExact(input, formats, new CultureInfo("en-US"), DateTimeStyles.None, out parsedDate);
        }

        public static bool VerifyNumber(string number, int type)
        {
            try
            {
                switch (type)
                {
                    case TYPE_INT:
                        int.Parse(number);
                        break;
                    case TYPE_LONG:
                        long.Parse(number);
                        break;
                    case TYPE_DOUBLE:
                        double.Parse(number);
                        break;
                    case TYPE_FLOAT:
                        float.Parse(number);
                        break;
                }
                return true;
            }
            catch {
                return false;
            }
        }

        public static string getConnectionString(string serverName)
        {
            string retVal = "";

            switch (serverName)
            {
                case "TERP":
                    retVal = System.Configuration.ConfigurationManager.ConnectionStrings["TERPConnectionString"].ConnectionString;
                    break;
            }

            return retVal;
        }

        public static string getPostBackControlName(Page page)
        {
            Control control = null;
            //first we will check the "__EVENTTARGET" because if post back made by       the controls
            //which used "_doPostBack" function also available in Request.Form collection.

            string ctrlname = page.Request.Params["__EVENTTARGET"];
            if (ctrlname != null && ctrlname != String.Empty)
            {
                control = page.FindControl(ctrlname);
            }

            // if __EVENTTARGET is null, the control is a button type and we need to
            // iterate over the form collection to find it
            else
            {
                string ctrlStr = String.Empty;
                Control c = null;
                foreach (string ctl in page.Request.Form)
                {
                    //handle ImageButton they having an additional "quasi-property" in their Id which identifies
                    //mouse x and y coordinates
                    if (ctl.EndsWith(".x") || ctl.EndsWith(".y"))
                    {
                        ctrlStr = ctl.Substring(0, ctl.Length - 2);
                        c = page.FindControl(ctrlStr);
                    }
                    else
                    {
                        c = page.FindControl(ctl);
                    }
                    if (c is System.Web.UI.WebControls.Button ||
                             c is System.Web.UI.WebControls.ImageButton)
                    {
                        control = c;
                        break;
                    }
                }
            }

            if (control != null)
                return control.ID;
            else
                return string.Empty;

        }

        public static bool isValidIP(string ip)
        {
            //return STFLibrary.Tools.isValidIP(ip);
            return false;
        }

        public static string removePrefix(string id)
        {
            int n = 0;

            for (int i = 0; i < id.Trim().Length; i++)
            {
                n = i;
                if (id.Substring(i, i + 1) != "0")
                {
                    break;
                }
            }
            return id.Substring(n);
        }

        public static byte[] imageToByteArray(System.Drawing.Image imageIn)
        {
            var jpegQuality = 50;
            MemoryStream ms = new MemoryStream();
            var jpegEncoder = ImageCodecInfo.GetImageDecoders().First(c => c.FormatID == ImageFormat.Jpeg.Guid);
            var encoderParameters = new EncoderParameters(1);
            encoderParameters.Param[0] = new EncoderParameter(Encoder.Quality, jpegQuality);
            imageIn.Save(ms, jpegEncoder, encoderParameters);
            return ms.ToArray();
        }

        public static System.Drawing.Image byteArrayToImage(byte[] byteArrayIn)
        {
            MemoryStream ms = new MemoryStream(byteArrayIn);
            System.Drawing.Image returnImage = System.Drawing.Image.FromStream(ms);
            return returnImage;
        }


        public static string FindTextBetween(string text, string left, string right)
        {
            // TODO: Validate input arguments

            int beginIndex = text.IndexOf(left); // find occurence of left delimiter
            if (beginIndex == -1)
                return string.Empty; // or throw exception?

            beginIndex += left.Length;

            int endIndex = text.IndexOf(right, beginIndex); // find occurence of right delimiter
            if (endIndex == -1)
                return string.Empty; // or throw exception?

            return text.Substring(beginIndex, endIndex - beginIndex).Trim();
        }

        public static string FindTextBetween(string text, string left, string right, string replaced_char)
        {
            // TODO: Validate input arguments

            int beginIndex = text.IndexOf(left); // find occurence of left delimiter
            if (beginIndex == -1)
                return string.Empty; // or throw exception?

            //beginIndex += left.Length;

            int endIndex = text.IndexOf(right, beginIndex); // find occurence of right delimiter
            if (endIndex == -1)
                return string.Empty; // or throw exception?
            endIndex += right.Length;

            string tmp = text.Substring(beginIndex, endIndex - beginIndex).Replace(",","").Replace("\"","");

            return (text.Substring(0,beginIndex + 1) + tmp + text.Substring(endIndex - 1, text.Length - endIndex + 1)).Replace("%","");
        }
        //string str = "The texts starts here ** Get This String ** Some other text ongoing here.....";
        //string result = FindTextBetween(str, "**", "**");


        public static bool SaveImageToDB(string id_, byte[] image_, byte[] avatar)
        {
            if (image_==null && avatar==null)
            {
                return false;
            }

            SqlConnection con = new SqlConnection();
            con.ConnectionString = getConnectionString("TERP");
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "UPDATE TERP_users SET image=@file1,image_icon=@file2 WHERE user_id=@id"; //I named the column File2 simply because "File" seemed to be a keyword in SQLServer
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;

            SqlParameter id = new SqlParameter("@id", SqlDbType.Char);
            SqlParameter file1 = new SqlParameter("@file1", SqlDbType.Image);
            SqlParameter file2 = new SqlParameter("@file2", SqlDbType.Image);

            id.Value = id_;
            file1.Value = image_;
            file2.Value = avatar;
            cmd.Parameters.Add(id);
            cmd.Parameters.Add(file1);
            cmd.Parameters.Add(file2);

            con.Open();
            int result = cmd.ExecuteNonQuery();
            if (result > 0)
            {
                // SUCCESS!
                con.Close();
                return true;
            }
            else
            {
                //failure
                con.Close();
                return false;
            }

        }
    }
}