using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;


namespace Hotel_Royale
{
    
    public partial class Home : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            ((common)this.Master).curr = "home";
            if(Request.Cookies["userRem"]!=null)
            {
                
                string usr = Request.Cookies["userRem"].Value;
                if (usr != "")
                {
                    login_layout.Visible = false;
                }
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["focus"] == "lgin")
                {
                    
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "exp", "alert('You must login first!')", true);
                }
                else if(Request.QueryString["focus"] == "deny")
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "exp", "alert('Sorry! You are not eligible to view this page!')", true);
                }

            }
            

        }
   

       

       
       
       
    
       
        protected void create_account(object sender, EventArgs e)
        {


         
         
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            SqlCommand cmd;

          
           
            
                string insertQuery = "insert into user_data(username, email, password, type_id, phone) values(@uname, @emailid, @pass, @type, @phn)";
                cmd = new SqlCommand(insertQuery, conn);

                cmd.Parameters.AddWithValue("@uname", newUserName.Value);
                cmd.Parameters.AddWithValue("@emailid", newEmail.Value);
                cmd.Parameters.AddWithValue("@pass", newPassword.Value);
                cmd.Parameters.AddWithValue("@type", 1);
                cmd.Parameters.AddWithValue("@phn", newPhone.Value);
                cmd.ExecuteNonQuery();
                lgin_username.Text = newUserName.Value;
                lgin_pass.Text = newPassword.Value;
                login_btn_Click(null, e);
                Response.Redirect(Request.RawUrl);
                conn.Close();
            

        }
        
        protected void login_btn_Click(object sender, EventArgs e)
        {
            
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            string userStr = lgin_username.Text;
            string pass = lgin_pass.Text;
            string checkUser = "select password, type_id from user_data where username='" + userStr + "' or email='" + userStr + "'";
            SqlCommand cmd = new SqlCommand(checkUser, conn);

            using (SqlDataReader rdr = cmd.ExecuteReader())
            {
                if (rdr.HasRows)
                {
                    rdr.Read();

                    string countUN= rdr.GetString(rdr.GetOrdinal("password"));
                    int typeid = rdr.GetInt32(rdr.GetOrdinal("type_id"));

                    if (countUN == pass && pass != "")
                    {
                        HttpCookie userC = new HttpCookie("userRem");
                        userC.Value = userStr;
                        userC.Expires = DateTime.Now.AddYears(50);
                        Response.Cookies.Add(userC);

                        HttpCookie userT = new HttpCookie("userTyp");
                        userT.Value = typeid.ToString();
                        userT.Expires = DateTime.Now.AddYears(50);
                        Response.Cookies.Add(userT);


                        Response.Redirect("/Home.aspx");

                       

                    }
                    else
                    {
                        loginErr.InnerText = "Invalid Username/Email or Password";
                    }

                }
            }

                      
        }
    }
}