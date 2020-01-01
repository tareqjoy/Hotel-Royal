using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Royale.admin
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((common)this.Master).curr = "admin";
            string usr;
            int typ;
            if (Request.Cookies["userRem"] != null)
            {
                usr = Request.Cookies["userRem"].Value;
                if (usr == "")
                {
                    Response.Redirect("/Home.aspx?focus=lgin");
                }
            }
            else
            {
                Response.Redirect("/Home.aspx?focus=lgin");
            }
            try
            {
                typ = Int32.Parse(Request.Cookies["userTyp"].Value);
                if (typ != 0)
                {
                    Response.Redirect("/Home.aspx?focus=deny");
                }

            }
            catch
            {
                Response.Redirect("/Home.aspx?focus=deny");
            }
        }
    }
}