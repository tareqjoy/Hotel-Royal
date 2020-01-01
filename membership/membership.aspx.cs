using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Hotel_Royale.membership
{
    public partial class membership : System.Web.UI.Page
    {
        string usr;
        protected void Page_Load(object sender, EventArgs e)
        {
            ((common)this.Master).curr = "membership";
            curr_password_settings.Attributes["value"] = curr_password_settings.Text;
            new_password_settings.Attributes["value"] = new_password_settings.Text;
            confirm_password_settings.Attributes["value"] = confirm_password_settings.Text;
            if (Request.Cookies["userRem"] != null)
            {
                usr = Request.Cookies["userRem"].Value;
                if (usr == "")
                {
                    Response.Redirect("/Home.aspx?focus=lgin");
                }
                else
                {
                    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                    conn.Open();
                    if (!IsPostBack)
                    {
                        
                        SqlCommand cmd;

                        string getQuery = "select * from user_data where username='" + usr + "'";
                        cmd = new SqlCommand(getQuery, conn);

                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.HasRows)
                            {
                                rdr.Read();
                                try
                                {
                                    funn_name_info.Text = rdr.GetString(rdr.GetOrdinal("full_name"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    hometown_info.Text = rdr.GetString(rdr.GetOrdinal("hometown"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    working_city_info.Text = rdr.GetString(rdr.GetOrdinal("working_city"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    gender_info.SelectedIndex = rdr.GetInt32(rdr.GetOrdinal("gender"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    String str = rdr.GetString(rdr.GetOrdinal("birth")), temp="";
                                    int c = 0;
                                    for(int i=0; i<str.Length; i++)
                                    {
                                        
                                        if(str[i]=='-' && c==0)
                                        {
                                            birth_date_info.Text = temp;
                                            temp = "";
                                            c++;
                                            continue;
                                        }
                                        else if(str[i] == '-' && c == 1)
                                        {
                                            birth_month_info.SelectedIndex = Int32.Parse(temp);
                                            temp = "";
                                            c++;
                                            continue;
                                        }
                                        temp += str[i];
                                    }
                                    birth_year_info.Text = temp;
                                }
                                catch
                                {

                                }
                                try
                                {
                                    email_settings.Text = rdr.GetString(rdr.GetOrdinal("email"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    username_settings.Text = rdr.GetString(rdr.GetOrdinal("username"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    card_number_payment.Text = rdr.GetInt64(rdr.GetOrdinal("card_number")).ToString();
                                }
                                catch
                                {

                                }
                                try
                                {
                                    expiration_date_month_payment.SelectedIndex = rdr.GetInt32(rdr.GetOrdinal("card_expiration_month"));
                                }
                                catch
                                {

                                }
                                try
                                {
                                    expiration_date_year_payment.Text = rdr.GetInt32(rdr.GetOrdinal("card_expiration_year")).ToString();
                                }
                                catch
                                {

                                }
                                try
                                {
                                    cvc_payment.Text = rdr.GetInt32(rdr.GetOrdinal("card_cvc")).ToString();
                                }
                                catch
                                {

                                }
                            }
                        }
                       
                         
                    }

                    string readData = "select * from user_placement where user_id='" + usr + "' order by apply_date_time desc";
                    SqlCommand cmd2 = new SqlCommand(readData, conn);
                    using (SqlDataReader rdr = cmd2.ExecuteReader())
                    {

                        while (rdr.Read())
                        {




                            Panel timeline__box = new Panel();
                            timeline__box.CssClass = "timeline__box";

                            Panel timeline__date = new Panel();
                            timeline__date.CssClass = "timeline__date";

                            HtmlGenericControl timeline__day = new HtmlGenericControl("span");
                            timeline__day.InnerHtml = rdr.GetDateTime(rdr.GetOrdinal("apply_date_time")).Day.ToString();
                            timeline__day.Attributes["class"] = "timeline__day";
                            timeline__date.Controls.Add(timeline__day);

                            HtmlGenericControl timeline__month = new HtmlGenericControl("span");
                            timeline__month.InnerHtml = rdr.GetDateTime(rdr.GetOrdinal("apply_date_time")).ToString("MMM", CultureInfo.InvariantCulture);
                            timeline__month.Attributes["class"] = "timeline__month";
                            timeline__date.Controls.Add(timeline__month);

                            timeline__month = new HtmlGenericControl("span");
                            timeline__month.InnerHtml = rdr.GetDateTime(rdr.GetOrdinal("apply_date_time")).ToShortTimeString();
                            timeline__month.Attributes["class"] = "timeline__month";
                            timeline__date.Controls.Add(timeline__month);


                            timeline__box.Controls.Add(timeline__date);

                            Panel timeline__post = new Panel();
                            timeline__post.CssClass = "timeline__post";

                            Panel timeline__content = new Panel();
                            timeline__content.CssClass = "timeline__contentt";

                            HtmlGenericControl table = new HtmlGenericControl("table");
                            table.Attributes["class"] = "timeline__content_table";

                            HtmlGenericControl tr = new HtmlGenericControl("tr");
                            HtmlGenericControl td = new HtmlGenericControl("td");


                            HtmlGenericControl p1 = new HtmlGenericControl("p");
                            p1.InnerHtml = "Token id: " + rdr.GetDecimal(rdr.GetOrdinal("token")).ToString("000 000 000 000 000");
                            p1.Attributes["class"] = "timeline__content_p";
                            td.Controls.Add(p1);


                            HtmlGenericControl p2 = new HtmlGenericControl("p");
                            p2.InnerHtml = "Room No: " + rdr.GetString(rdr.GetOrdinal("room_id"));
                            p2.Attributes["class"] = "timeline__content_p";
                            td.Controls.Add(p2);

                            HtmlGenericControl p3 = new HtmlGenericControl("p");
                            p3.InnerHtml = "Placement: From " + rdr.GetDateTime(rdr.GetOrdinal("placement_date")).ToShortDateString() + " 12:00 PM to " + rdr.GetDateTime(rdr.GetOrdinal("expiration_date")).AddDays(-1).ToShortDateString() + " 11:59 AM";
                            p3.Attributes["class"] = "timeline__content_p";
                            td.Controls.Add(p3);

                            HtmlGenericControl p4 = new HtmlGenericControl("p");
                            p4.InnerHtml = "Paid: " + rdr.GetDecimal(rdr.GetOrdinal("paid_amount")) + "/- Tk";
                            p4.Attributes["class"] = "timeline__content_p";
                            td.Controls.Add(p4);

                            tr.Controls.Add(td);

                            td = new HtmlGenericControl("td");

                            Button input = new Button();
                            input.ID = rdr.GetDecimal(rdr.GetOrdinal("token")).ToString("000000000000000");
                            input.Click += new EventHandler(this.btn_click);
                            input.OnClientClick = "return true;";
                            //   input.Attributes["tag"] = rdr.GetDecimal(rdr.GetOrdinal("token")).ToString("000000000000000");
                            input.Text = "Download & Print Form";
                            input.CssClass = "timeline__content_input";

                            td.Controls.Add(input);

                            tr.Controls.Add(td);

                            table.Controls.Add(tr);

                            timeline__content.Controls.Add(table);

                            timeline__post.Controls.Add(timeline__content);

                            timeline__box.Controls.Add(timeline__post);

                            records.Controls.Add(timeline__box);

                            /*
                            Label l = new Label();
                            l.Text = "[" + rdr.GetDateTime(rdr.GetOrdinal("apply_date_time")).ToString()+"] Room-"+ rdr.GetString(rdr.GetOrdinal("room_id"))+" was booked from "+ rdr.GetDateTime(rdr.GetOrdinal("placement_date")).ToShortDateString()+" to "+ rdr.GetDateTime(rdr.GetOrdinal("expiration_date")).AddDays(-1).ToShortDateString()+" and paid "+ rdr.GetDecimal(rdr.GetOrdinal("paid_amount")) + "/- Taka";
                            records.Controls.Add(l);*/
                        }

                    }
                    conn.Close();
                }
            }
            else
            {
                Response.Redirect("/Home.aspx?focus=lgin");
            }

        }

        void btn_click(object sender, EventArgs e)
        {
            
            
            Button curr = (Button)sender;
            string id = curr.ID;
            string encoded = Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(id));
            Response.Write("<script> window.open('"+ "/functions.aspx?func=down_form&data2=" + encoded+"','_blank'); </script>");
           



        }
        private void setErr(System.Web.UI.HtmlControls.HtmlGenericControl obj, TextBox obj2, string err)
        {
            obj.InnerHtml = err;
            obj2.Style.Add("border-color", "red");
        }
        private void unSetErr(System.Web.UI.HtmlControls.HtmlGenericControl obj, TextBox obj2)
        {
            obj.InnerHtml = "&nbsp;";
            obj2.Style.Add("border-color", "green");
        }

        private void setErr(System.Web.UI.HtmlControls.HtmlGenericControl obj, System.Web.UI.HtmlControls.HtmlSelect obj2, string err)
        {
            obj.InnerHtml = err;
            obj2.Style.Add("border-color", "red");
        }
        private void unSetErr(System.Web.UI.HtmlControls.HtmlGenericControl obj, System.Web.UI.HtmlControls.HtmlSelect obj2)
        {
            obj.InnerHtml = "&nbsp;";
            obj2.Style.Add("border-color", "green");
        }



        protected void save_basic_info_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                SqlCommand cmd;

                string insertQuery = "update user_data set full_name=@fname, hometown=@home, working_city=@work, gender=@gen, birth=@birth where username='" + usr + "'";
                cmd = new SqlCommand(insertQuery, conn);

                cmd.Parameters.AddWithValue("@fname", funn_name_info.Text);
                cmd.Parameters.AddWithValue("@home", hometown_info.Text);
                cmd.Parameters.AddWithValue("@work", working_city_info.Text);
                cmd.Parameters.AddWithValue("@gen", gender_info.SelectedIndex);
                cmd.Parameters.AddWithValue("@birth", birth_date_info.Text+"-"+birth_month_info.SelectedIndex+"-"+birth_year_info.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                save_basic_msg.Text = "Info updated successfully.";
            }
            catch
            {
                save_basic_msg.Text = "Failed to update!";
            }
            webTimer.Enabled = true;
        }

        private void hideContent(object sender, System.Timers.ElapsedEventArgs e)
        {
            save_basic_msg.Text = "&nbsp;";
        }
        protected void save_settings_Click(object sender, EventArgs e)
        {
            string str1 = curr_password_settings.Text, str2 = new_password_settings.Text, str3 = confirm_password_settings.Text;
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            string checkUser = "select password from user_data where username='" + usr + "'";
            SqlCommand cmd = new SqlCommand(checkUser, conn);
            string countUN = Convert.ToString(cmd.ExecuteScalar());
            bool chk = true;
            if (str1 != countUN)
            {
                setErr(curr_password_err, curr_password_settings, "Current password isn't matched! Try again");
                chk = false;
            }
            if (str2.Length < 6)
            {
                setErr(new_password_err, new_password_settings, "Password must be at least 8 digits");
                chk = false;
            }
            if (str2 != str3 || str2 == "")
            {
                setErr(confirm_password_err, confirm_password_settings, "Password isn't matched. Retry again");
                chk = false;
            }
            if (chk)
            {
                unSetErr(curr_password_err, curr_password_settings);
                unSetErr(new_password_err, new_password_settings);
                unSetErr(confirm_password_err, confirm_password_settings);

                string insertQuery = "update user_data set password=@pass where username='" + usr + "'";
                cmd = new SqlCommand(insertQuery, conn);

                cmd.Parameters.AddWithValue("@pass", new_password_settings.Text);
                cmd.ExecuteNonQuery();
                save_settings_msg.Text = "Updated Successfully!";

            }
            webTimer.Enabled = true;
            conn.Close();
        }
        bool errorFreePaymentInfo = true;
        protected void save_payment_Click(object sender, EventArgs e)
        {
            errorFreePaymentInfo = true;
            card_number_payment_TextChanged(null, e);
            expiration_date_year_payment_TextChanged(null, e);
            cvc_payment_TextChanged(null, e);
            if (expiration_date_month_payment.SelectedIndex == 0)
            {
                errorFreePaymentInfo = false;
                setErr(expiration_date_month_err, expiration_date_month_payment, "Select expiration month.");
            }
            else if (expiration_date_month_payment.SelectedIndex <= DateTime.Now.Month)
            {
                if (expiration_date_year_payment.Text != "")
                {
                    if (Int32.Parse(expiration_date_year_payment.Text) == DateTime.Now.Year)
                    {
                        errorFreePaymentInfo = false;
                        setErr(expiration_date_year_err, expiration_date_month_payment, "Expired card!");
                    }
                }

            }
            else
            {
                unSetErr(expiration_date_month_err, expiration_date_month_payment);
                unSetErr(expiration_date_year_err, expiration_date_month_payment);
            }
            if (errorFreePaymentInfo)
            {
                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();
                SqlCommand cmd;

                string insertQuery = "update user_data set card_number=@cno, card_expiration_month=@expm, card_expiration_year=@expy, card_cvc=@cvc where username='" + usr + "'";
                cmd = new SqlCommand(insertQuery, conn);

                cmd.Parameters.AddWithValue("@cno", card_number_payment.Text);
                cmd.Parameters.AddWithValue("@expm", expiration_date_month_payment.SelectedIndex);
                cmd.Parameters.AddWithValue("@expy", expiration_date_year_payment.Text);
                cmd.Parameters.AddWithValue("@cvc", cvc_payment.Text);
                cmd.ExecuteNonQuery();
                save_payment_msg.Text = "Updated Successfully!";
                conn.Close();
            }
            webTimer.Enabled = true;
        }


        protected void webTimer_Tick(object sender, EventArgs e)
        {
            save_basic_msg.Text = "&nbsp;";
            save_payment_msg.Text = "&nbsp;";
            save_settings_msg.Text = "&nbsp;";
            webTimer.Enabled = false;
        }

        protected void card_number_payment_TextChanged(object sender, EventArgs e)
        {
            string str = card_number_payment.Text;

            for (int i = 0; i < str.Length; i++)
            {
                if (!(str[i] >= '0' && str[i] <= '9'))
                {
                    errorFreePaymentInfo = false;
                    setErr(card_number_err, card_number_payment, "Invalid card number. Card number must be numeric.");
                    return;
                }
            }
            if (str.Length < 12)
            {
                errorFreePaymentInfo = false;
                setErr(card_number_err, card_number_payment, "Card number must be 12 digits.");
                return;
            }
            unSetErr(card_number_err, card_number_payment);
        }

        protected void expiration_date_year_payment_TextChanged(object sender, EventArgs e)
        {
            string str = expiration_date_year_payment.Text;

            for (int i = 0; i < str.Length; i++)
            {
                if (!(str[i] >= '0' && str[i] <= '9'))
                {
                    errorFreePaymentInfo = false;
                    setErr(expiration_date_year_err, expiration_date_year_payment, "Must be numeric value.");
                    return;
                }
            }
            if (str.Length < 4)
            {
                errorFreePaymentInfo = false;
                setErr(expiration_date_year_err, expiration_date_year_payment, "Must be 4 digits.");
                return;
            }
            if (Int32.Parse(str) < DateTime.Now.Year)
            {
                errorFreePaymentInfo = false;
                setErr(expiration_date_year_err, expiration_date_year_payment, "Expired card!");
                return;
            }
            unSetErr(expiration_date_year_err, expiration_date_year_payment);
        }

        protected void cvc_payment_TextChanged(object sender, EventArgs e)
        {
            string str = cvc_payment.Text;

            for (int i = 0; i < str.Length; i++)
            {
                if (!(str[i] >= '0' && str[i] <= '9'))
                {
                    errorFreePaymentInfo = false;
                    setErr(cvc_err, cvc_payment, "Must be numeric value.");
                    return;
                }
            }
            if (str.Length < 3)
            {
                errorFreePaymentInfo = false;
                setErr(cvc_err, cvc_payment, "Must be 3 digits.");
                return;
            }
            unSetErr(cvc_err, cvc_payment);
        }

    }
}