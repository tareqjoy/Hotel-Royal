using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Royale
{
    public partial class common : System.Web.UI.MasterPage
    {
        string usr;
        int typ = -1;
        protected void Page_Load(object sender, EventArgs e)
        {
            string currPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            if (Request.Cookies["userRem"] != null)
            {
                usr = Request.Cookies["userRem"].Value;
                if (usr != "")
                {
                    curr_user_div.Visible = true;
                    curr_user_p.InnerText = usr;
                    try
                    {
                        typ = Int32.Parse(Request.Cookies["userTyp"].Value);
                        if (typ == 0)
                        {
                            apl.Visible = true;
                        }
                        
                    }
                    catch
                    {
                        
                    }
                    
                    
                }
                
            }
        }
        protected void signMeOut(object sender, EventArgs e)
        {
            HttpCookie cook = new HttpCookie("userRem");
            
            cook.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cook);

            HttpCookie cook2 = new HttpCookie("userTyp");

            cook2.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cook2);

            curr_user_div.Visible = false;
            Response.Redirect(Request.RawUrl);
        }
   
        public string curr
        {
            set
            {
                string str = value;
               
                if (str == "home")
                {
                    l1.Style["background-color"] = "#42A5F5";
                    l1.Style["color"] = "white";
                }
                else if(str == "location")
                {
                    l2.Style["background-color"] = "#42A5F5";
                    l2.Style["color"] = "white";
                }
                else if (str == "rooms")
                {
                    l3.Style["background-color"] = "#42A5F5";
                    l3.Style["color"] = "white";
                }
                else if (str == "restaurant")
                {
                    l4.Style["background-color"] = "#42A5F5";
                    l4.Style["color"] = "white";
                }
                else if (str == "services")
                {
                    l5.Style["background-color"] = "#42A5F5";
                    l5.Style["color"] = "white";
                }
                else if (str == "events")
                {
                    l6.Style["background-color"] = "#42A5F5";
                    l6.Style["color"] = "white";
                }
                else if (str == "membership")
                {
                    l7.Style["background-color"] = "#42A5F5";
                    l7.Style["color"] = "white";
                }
                else if(str=="admin")
                {
                    l8.Style["background-color"] = "#42A5F5";
                    l8.Style["color"] = "white";
                }
            }
        }
    }
}