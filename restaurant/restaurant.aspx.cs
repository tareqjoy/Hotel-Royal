using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Hotel_Royale.resturant
{
    public partial class resturant : System.Web.UI.Page
    {
        string usr;
        protected void Page_Load(object sender, EventArgs e)
        {


               
            ((common)this.Master).curr = "restaurant";
            if (Request.Cookies["userRem"] != null)
            {
                usr = Request.Cookies["userRem"].Value;
                if (usr == "")
                {
                    Response.Redirect("/Home.aspx?focus=lgin");
                }
                else
                {


                }
            }
            else
            {
                Response.Redirect("/Home.aspx?focus=lgin");
            }
            taka.Text = hdnLabelState.Value;
            if (!IsPostBack)
            {

                
                month_select_order_SelectedIndexChanged(null, e);
                month_select_order.Items.Add("Jan");
                month_select_order.Items.Add("Feb");
                month_select_order.Items.Add("Mar");
                month_select_order.Items.Add("Apr");
                month_select_order.Items.Add("May");
                month_select_order.Items.Add("Jun");
                month_select_order.Items.Add("Jul");
                month_select_order.Items.Add("Aug");
                month_select_order.Items.Add("Sep");
                month_select_order.Items.Add("Oct");
                month_select_order.Items.Add("Nov");
                month_select_order.Items.Add("Dec");
                year_select_order.Items.Add("2018");

                date_select_order.SelectedIndex = DateTime.Now.Date.Day - 1;
                month_select_order.SelectedIndex = DateTime.Now.Date.Month - 1;


                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
                conn.Open();

                SqlCommand cmd;

                string getQuery = "select * from food_info";
                cmd = new SqlCommand(getQuery, conn);

                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.HasRows)
                    {
                        while (rdr.Read())
                        {
                            string foodname, foodtype;
                            decimal price;
                            int id;
                            foodname = rdr.GetString(rdr.GetOrdinal("food_name"));
                            price = rdr.GetDecimal(rdr.GetOrdinal("food_price"));
                            foodtype = rdr.GetString(rdr.GetOrdinal("type"));
                            id = rdr.GetInt32(rdr.GetOrdinal("id"));

                            HtmlGenericControl p = new HtmlGenericControl("p");
                            p.Attributes["class"] = "opt2";
                            p.Attributes["onclick"] = "selectOpt2(event, " + id + ", " + price + ");";
                            p.InnerHtml = foodname + "<br />" + price;
                            if(foodtype=="Fast Food")
                            {
                                fast_food_div.Controls.Add(p);
                            }
                            else if(foodtype=="Rice")
                            {
                                rice_div.Controls.Add(p);
                            }
                            else if(foodtype=="Chicken Dish")
                            {
                                chicken_dish_div.Controls.Add(p);
                            }
                            else if(foodtype=="Beef Dish")
                            {
                                beef_dish_div.Controls.Add(p);
                            }
                            else if(foodtype=="Drinks")
                            {
                                drinks_div.Controls.Add(p);
                            }


                        }
                    }
                }

            }
        }

        protected void pay_book_Click(object sender, EventArgs e)
        {

            restaurant_msg.Text = "";
            DateTime placmentDate = Convert.ToDateTime(year_select_order.Text + "-" + (month_select_order.SelectedIndex + 1) + "-" + date_select_order.Text);
            if (placmentDate < DateTime.Now.Date)
            {
                restaurant_msg.Text = "You have selected older date! Check again.";
                return;
            }
            if(people.Value=="")
            {
                restaurant_msg.Text = "You have left total person empty";
                return;
            }
            else if(opt2Val.Text=="")
            {
                restaurant_msg.Text = "You must choice at least one item from the menu";
                return;
            }

            for(int i=0; i<people.Value.Length; i++)
            {
                if(people.Value[i]<'0'|| people.Value[i] > '9')
                {
                    restaurant_msg.Text = "Invalid value on total person";
                    return;
                }
            }
            if (Int32.Parse(people.Value) <= 0)
            {
                restaurant_msg.Text = "Invalid value on total person";
                return;
            }
            if (Int32.Parse(people.Value) > 120)
            {
                return;
            }
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            
            string getPaymentInfo = "select card_number from user_data where username='" + usr + "'";
            SqlCommand cmd4 = new SqlCommand(getPaymentInfo, conn);
            if (cmd4.ExecuteScalar() != null)
            {

                string[] str = opt2Val.Text.Split(' ');
                if (opt1Val.Text == "0")
                {
                    string checkQ = "select count(*) from user_placement where placement_date<='"+DateTime.Now.Date+"' and expiration_date>'"+DateTime.Now.Date+"'";
                    SqlCommand checkCmd = new SqlCommand(checkQ, conn);
                    int countUN = Convert.ToInt32(checkCmd.ExecuteScalar());
                    if(countUN==0)
                    {
                        restaurant_msg.Text = "To order, you must have to stay at Room!";
                        conn.Close();
                        return;
                    }
                    for (int i = 0; i < str.Length; i++)
                    {
                        if (str[i] != "")
                        {
                            string insertQuery = "insert into food_placement(username, food_id, order_date, order_time, plates) values(@uname, @fid, @od, @ot, @plates)";
                            SqlCommand cmd = new SqlCommand(insertQuery, conn);
                            cmd.Parameters.AddWithValue("@uname", usr);
                            cmd.Parameters.AddWithValue("@fid", str[i]);
                            cmd.Parameters.AddWithValue("@od", placmentDate);
                            if(day_select_order.SelectedIndex==0)
                            {
                                cmd.Parameters.AddWithValue("@ot", Int32.Parse(DateTime.Now.Hour.ToString()+DateTime.Now.Minute.ToString()+DateTime.Now.Second.ToString()));
                            }
                            else
                            { 
                                cmd.Parameters.AddWithValue("@ot", day_select_order.SelectedIndex);
                            }
                            cmd.Parameters.AddWithValue("@plates", people.Value);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                else
                {
                    if(day_select_order.SelectedIndex==0)
                    {
                        restaurant_msg.Text = "Order time 'Now' is not available for Booking Restaurant";
                        conn.Close();
                        return;
                    }
                    string checkAvail = "select plates from restaurant_placement where order_date=@od and order_time=@ot";
                    SqlCommand checkSql = new SqlCommand(checkAvail, conn);
                    checkSql.Parameters.AddWithValue("@od", placmentDate);
                    checkSql.Parameters.AddWithValue("@ot", day_select_order.SelectedIndex);

                    int totalCus = 0;
                    using (SqlDataReader rdr = checkSql.ExecuteReader())
                    {
                        if (rdr.HasRows)
                        {
                            while (rdr.Read())
                            {
                                totalCus += rdr.GetInt32(rdr.GetOrdinal("plates"));
                            }
                        }
                    }
                    totalCus = 120-totalCus;
                    if(totalCus<Int32.Parse(people.Value))
                    {
                        restaurant_msg.Text = "Can't book! Only "+totalCus+" space left for that time!";
                        conn.Close();
                        return;
                    }

                    for (int i = 0; i < str.Length; i++)
                    {
                        if (str[i] != "")
                        {
                            string insertQuery = "insert into restaurant_placement(username, food_id, order_date, order_time, plates) values(@uname, @fid, @od, @ot, @plates)";
                            SqlCommand cmd = new SqlCommand(insertQuery, conn);
                            cmd.Parameters.AddWithValue("@uname", usr);
                            cmd.Parameters.AddWithValue("@fid", str[i]);
                            cmd.Parameters.AddWithValue("@od", placmentDate);
                            cmd.Parameters.AddWithValue("@ot", day_select_order.SelectedIndex);

                            cmd.Parameters.AddWithValue("@plates", people.Value);
                            cmd.ExecuteNonQuery();
                        }
                    }
                }
                restaurant_msg.Text = "Succesfully ordered!";
            }
            else
            {
                restaurant_msg.Text = "Please complete payment info in profile";
            }
            
            conn.Close();
        }
        protected void month_select_order_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            restaurant_msg.Text = "&nbsp;";
            List<ListItem> lstItem = new List<ListItem>();
            int NowSel = date_select_order.SelectedIndex;
            date_select_order.Items.Clear();
            for (int i = 1; i <= 28; i++)
            {
                lstItem.Add(new ListItem(i.ToString(), i.ToString()));
            }
            if (month_select_order.SelectedIndex == 0 || month_select_order.SelectedIndex == 2 || month_select_order.SelectedIndex == 4 || month_select_order.SelectedIndex == 6 || month_select_order.SelectedIndex == 7 || month_select_order.SelectedIndex == 9 || month_select_order.SelectedIndex == 11)
            {
                lstItem.Add(new ListItem("29", "29"));
                lstItem.Add(new ListItem("30", "30"));
                lstItem.Add(new ListItem("31", "31"));

            }
            else if (month_select_order.SelectedIndex == 1)
            {
                if (Int32.Parse(year_select_order.Text) % 4 == 0)
                {
                    lstItem.Add(new ListItem("29", "29"));
                }

            }
            else
            {
                lstItem.Add(new ListItem("29", "29"));
                lstItem.Add(new ListItem("30", "30"));
            }
            foreach (ListItem item in lstItem)
            {
                date_select_order.Items.Add(item);
            }
            try
            {
                date_select_order.SelectedIndex = NowSel;
            }
            catch
            {

            }

        }

        protected void people_TextChanged(object sender, EventArgs e)
        {

        }
    }
}