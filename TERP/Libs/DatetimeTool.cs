using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace TERP.Libs
{
    public class DatetimeTool
    {
        public const int TYPE_MMDDYYYY = 0;
        public const int TYPE_YYYYMMDD = 1;
        public const int TYPE_DDMMYYYY = 2;

        public const int ERROR_WRONG_DAY = 0;
        public const int ERROR_WRONG_MONTH = 1;
        public const int ERROR_WRONG_YEAR = 2;

        public static string getDate(string datein, int formatIn, int formatOut, char separateOut)
        {
            return null;
        }

        public static string getDateTime(string datein, int formatIn, int formatOut, char separateOut)
        {
            return null;
        }

        public static bool VerifyDate(string date_in, int format)
        {
            DateTime tempDate;
            try
            {
                return DateTime.TryParseExact(date_in, (format == TYPE_MMDDYYYY) ? "MM/dd/yyyy" : ((format == TYPE_DDMMYYYY) ? "dd/MM/yyyy" : "yyyy/MM/dd"),
                    CultureInfo.InvariantCulture, DateTimeStyles.None, out tempDate);
            } catch
            {
                return false;
            }
        }

        public static bool VerifyDate2(string date_in)
        {
            DateTime tempDate;
            try
            {
                return DateTime.TryParse(date_in, out tempDate);
            }
            catch
            {
                return false;
            }
        }

        public static bool VerifyDate3(string value)
        {
            string[] formats = { "M/d/yyyy", "", "MM/dd/yyyy", "M/dd/yyyy", "MM/d/yyyy" };
            DateTime parsedDate;

            return DateTime.TryParseExact(value, formats, new CultureInfo("en-US"), DateTimeStyles.None, out parsedDate);
        }
    }
}