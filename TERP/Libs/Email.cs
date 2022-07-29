using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace TERP.Libs
{
    public class Email
    {
        SmtpClient client = null;
        MailMessage msg = null;

        public Email(string to, string subject, string body, Attachment[] att, bool htmlMail)
        {
            client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            client.Host = "smtp.gmail.com";
            client.Port = 587;

            // setup Smtp authentication
            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential("pmsthinknext@gmail.com", "ABCD123@");
            client.UseDefaultCredentials = false;
            client.Credentials = credentials;

            msg = new MailMessage();
            msg.From = new MailAddress("pmsthinknext@gmail.com");

            string[] tos = to.Split(';');

            for (int i=0; i<tos.Length; i++)
            {
                msg.To.Add(new MailAddress(tos[i].Trim()));
            }

            msg.Subject = subject;
            msg.IsBodyHtml = htmlMail;

            if (att != null)
            {
                for (int i = 0; i < att.Length; i++)
                {
                    msg.Attachments.Add(att[i]);
                }
            }

            msg.Body = string.Format("<html><head></head><body><b>" + body + "</b></body>");
        }

        public void send()
        {
            try
            {
                if (client!=null && msg!=null) client.Send(msg);
            }
            catch (Exception ex)
            {
                //error
                string err = ex.Message;
            }
        }
    }
}