using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TERP.Libs
{
    public class TERPSession
    {
        public const int SYS_LEVEL_1 = 1;
        public const int SYS_LEVEL_2 = 2;
        public const int SYS_LEVEL_3 = 3;
        public const int SYS_LEVEL_4 = 4;
        public const int SYS_LEVEL_5 = 5;
        public const int SYS_LEVEL_6 = 6;

        string user_id;
        string user_name;
        string user_cid;
        string user_full_name;
        string user_email;
        string department_name;
        byte[] logo;
        int sys_level_id;
        string language_code;
        string link_button_css;
        string pr_no;
        string po_no;

        public TERPSession(string user_id, string user_name, string user_cid, string user_full_name, string user_email, string department_name, byte[] logo, int sys_level_id, string language_code)
        {
            this.user_id = user_id;
            this.user_name = user_name;
            this.user_cid = user_cid;
            this.user_full_name = user_full_name;
            this.user_email = user_email;
            this.department_name = department_name;
            this.logo = logo;
            this.sys_level_id = sys_level_id;
            this.language_code = language_code;
        }

        public string User_id { get => user_id; set => user_id = value; }
        public string User_name { get => user_name; set => user_name = value; }
        public string User_cid { get => user_cid; set => user_cid = value; }
        public string User_full_name { get => user_full_name; set => user_full_name = value; }
        public string User_email{ get => user_email; set => user_email = value; }
        public string Department_name { get => department_name; set => department_name = value; }
        public byte[] Logo { get => logo; set => logo = value; }
        public int Sys_level_id { get => sys_level_id; set => sys_level_id = value; }
        public string Language_code { get => language_code; set => language_code = value; }
        public string Link_button_css { get => link_button_css; set => link_button_css = value; }
        public string Pr_no { get => pr_no; set => pr_no = value; }
        public string Po_no { get => po_no; set => po_no = value; }
    }
}