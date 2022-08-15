using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace TERP.Libs
{
    public class TERPGridView
    {
        public static int TYPE_1 = 0;
        public static int TYPE_2 = 1;

        DataTable dt;
        string id;
        string[] header;
        int type;

        public TERPGridView(DataTable tbl, string id, string[] header, int type)
        {
            this.dt = tbl;
            this.id = id;
            this.header = header;
            this.type = type;
        }

        public string CreateGridView()
        {
            StringBuilder sb = new StringBuilder();

            sb.AppendLine("<table id="+ id + " class='table table-striped table-bordered' style='width:100%'>");

            //header
            sb.AppendLine("<thead>");
            sb.AppendLine("<tr>");
            for (int i=0; i< header.Length; i++)
            {
                sb.AppendLine("<th style='background-color:#1C5E55;color:white;font-weight:bold;'>" + header[i] + "</th>");
            }
            sb.AppendLine("</tr>");
            sb.AppendLine("</thead>");

            sb.AppendLine("<tbody>");
            //content
            if (dt!=null && dt.Rows.Count>0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sb.AppendLine("<tr>");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        sb.AppendLine("<td>" + dt.Rows[i].ItemArray[j].ToString().Trim() + "</td>");
                    }
                    sb.AppendLine("</tr>");
                }
            }
            sb.AppendLine("</tbody>");

            //footer
            //sb.AppendLine("<tfoot>");
            //sb.AppendLine("<tr>");
            //for (int i = 0; i < header.Length; i++)
            //{
            //    sb.AppendLine("<th>" + header[i] + "</th>");
            //}
            //sb.AppendLine("</tr>");
            //sb.AppendLine("</tfoot>");

            sb.AppendLine("</table>");
            return sb.ToString();
        }
    }
}