using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Royale.services
{
    public partial class services : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((common)this.Master).curr = "services";
        }
    }
}