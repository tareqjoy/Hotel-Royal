using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Hotel_Royale.events
{
    public partial class events : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ((common)this.Master).curr = "events";
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            string checkUser = "select * from event_list where event_date>'"+DateTime.Now.Date+"' order by event_date";
            SqlCommand cmd = new SqlCommand(checkUser, conn);
            int i = 0;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read() && i<5)
                {
                    Label lDate = new Label();
                    lDate.Text = (rdr.GetDateTime(rdr.GetOrdinal("event_date"))).ToShortDateString();
                    lDate.CssClass = "upcming_event_date";
                    lDate.ID = "ldate" + i;
                    events_list.Controls.Add(lDate);
                    Label lInfo = new Label();
                    lInfo.Text = rdr.GetString(rdr.GetOrdinal("event_name"));
                    lInfo.CssClass = "upcming_event_info";
                    lInfo.ID = "lInfo" + i;
                    events_list.Controls.Add(lInfo);
                    events_list.Controls.Add(new LiteralControl("<br />"));
                    i++;
                }
            }

            checkUser = "select * from event_list where event_date='" + DateTime.Now.Date + "'";
            cmd = new SqlCommand(checkUser, conn);
            i = 0;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read())
                {
                    Label lDate = new Label();
                    lDate.Text = (rdr.GetDateTime(rdr.GetOrdinal("event_date"))).ToShortDateString();
                    lDate.CssClass = "upcming_event_date";
                    lDate.ID = "ldate" + i;
                    curr_event_list.Controls.Add(lDate);
                    Label lInfo = new Label();
                    lInfo.Text = rdr.GetString(rdr.GetOrdinal("event_name"));
                    lInfo.CssClass = "upcming_event_info";
                    lInfo.ID = "lInfo" + i;
                    curr_event_list.Controls.Add(lInfo);
                    curr_event_list.Controls.Add(new LiteralControl("<br />"));
                    i++;
                }
            }
            checkUser = "select * from event_list where event_date<'" + DateTime.Now.Date + "' order by event_date desc";
            cmd = new SqlCommand(checkUser, conn);
            i = 0;
            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                while (rdr.Read() && i<5)
                {
                    Label lDate = new Label();
                    lDate.Text = (rdr.GetDateTime(rdr.GetOrdinal("event_date"))).ToShortDateString();
                    lDate.CssClass = "upcming_event_date";
                    lDate.ID = "ldate" + i;
                    past_events.Controls.Add(lDate);
                    Label lInfo = new Label();
                    lInfo.Text = rdr.GetString(rdr.GetOrdinal("event_name"));
                    lInfo.CssClass = "upcming_event_info";
                    lInfo.ID = "lInfo" + i;
                    past_events.Controls.Add(lInfo);
                    past_events.Controls.Add(new LiteralControl("<br />"));
                    i++;
                }
            }
            conn.Close();
        }
    }
}