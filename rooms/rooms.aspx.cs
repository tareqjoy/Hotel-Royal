using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using iTextSharp.text.pdf;

using System.Web.UI.WebControls;
using System.Net;
using System.IO;

namespace Hotel_Royale.room
{
    public partial class room : System.Web.UI.Page
    {
        string usr;
        protected void Page_Load(object sender, EventArgs e)
        {

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
                day_select_order.Items.Add("1");
                day_select_order.Items.Add("2");
                day_select_order.Items.Add("3");
                day_select_order.Items.Add("4");
                day_select_order.Items.Add("5");
                day_select_order.Items.Add("6");
                day_select_order.Items.Add("7");
                day_select_order.Items.Add("8");
                day_select_order.Items.Add("9");
                day_select_order.Items.Add("10");


                date_select_order.SelectedIndex = DateTime.Now.Date.Day - 1;
                month_select_order.SelectedIndex = DateTime.Now.Date.Month - 1;

            }
            ((common)this.Master).curr = "rooms";
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


        }

        protected void date_select_order_SelectedIndexChanged(object sender, EventArgs e)
        {
            pay_book.Text = "Check Room";
            room_msg.Text = "&nbsp;";
            taka.Text = "&nbsp;";
        }

        protected void month_select_order_SelectedIndexChanged(object sender, EventArgs e)
        {
            pay_book.Text = "Check Room";
            room_msg.Text = "&nbsp;";
            taka.Text = "&nbsp;";
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

        protected void pay_book_Click(object sender, EventArgs e)
        {
            room_msg.Text = "&nbsp;";
            DateTime placmentDate = Convert.ToDateTime(year_select_order.Text + "-" + (month_select_order.SelectedIndex + 1) + "-" + date_select_order.Text);
            if (placmentDate < DateTime.Now.Date)
            {
                room_msg.Text = "You have selected older date! Check again.";
                return;
            }
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            SqlCommand cmd, cmd2, cmd3, cmd4, cmd5, cmd6;
            DateTime expirationDate = placmentDate.AddDays(Double.Parse(day_select_order.Text));
            string getRoom = "select room_id from room_data where type=" + room_type_id.Value + " and capacity=" + total_customer_no.Value, getAvail, getPrice, getPaymentInfo;
            if (pay_book.Text == "Check Room")
            {
                taka.Text = "&nbsp;";
                cmd = new SqlCommand(getRoom, conn);
                List<string> allRoom = new List<string>();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.HasRows)
                    {
                        rdr.Read();
                        allRoom.Add(rdr.GetString(rdr.GetOrdinal("room_id")));
                    }
                }
                bool b = false;
                foreach (string str in allRoom)
                {
                    getAvail = "select count(*) from user_placement where room_id='" + str + "' and (((placement_date<='" + placmentDate + "' and expiration_date>'" + placmentDate + "') or (placement_date<'" + expirationDate + "' and expiration_date>='" + expirationDate + "')) or ((placement_date>='" + placmentDate + "' and placement_date<'" + expirationDate + "') or (expiration_date>'" + placmentDate + "' and expiration_date<='" + expirationDate + "')))";
                    cmd2 = new SqlCommand(getAvail, conn);
                    int countUN = Convert.ToInt32(cmd2.ExecuteScalar());
                    if (countUN == 0)
                    {
                        double countP;
                        b = true;
                        getPrice = "select price from room_data where room_id='" + str + "'";
                        cmd3 = new SqlCommand(getPrice, conn);
                        countP = Convert.ToDouble(cmd3.ExecuteScalar());
                        ViewState["selectedRoom"] = str;
                        ViewState["countP"] = countP;
                        room_msg.Text = "Room-" + str + " available for you. Grab it now!";
                        taka.Text = "Only " + String.Format("{0:n}", (countP * Int32.Parse(day_select_order.Text))) + "/- Taka!";
                        pay_book.Text = "Pay & Book Now!";
                        break;
                    }
                }
                if (!b)
                {
                    room_msg.Text = "No room left for this type! You can change choice & try again.";
                }
            }
            else if(pay_book.Text == "Pay & Book Now!")
            {
                getPaymentInfo = "select card_number from user_data where username='" + usr + "'";
                cmd4 = new SqlCommand(getPaymentInfo, conn);
                if (cmd4.ExecuteScalar() != null)
                {

                    string insertQuery = "insert into user_placement(user_id, room_id, placement_date, expiration_date, paid_amount, apply_date_time) values(@uid, @rid, @pd, @ed, @pa, @adt)";
                    cmd5 = new SqlCommand(insertQuery, conn);
                    cmd5.Parameters.AddWithValue("@uid", usr);
                    cmd5.Parameters.AddWithValue("@rid", (string)ViewState["selectedRoom"]);
                    cmd5.Parameters.AddWithValue("@pd", placmentDate);
                    cmd5.Parameters.AddWithValue("@ed", expirationDate);
                    cmd5.Parameters.AddWithValue("@pa", (double)ViewState["countP"]);
                    cmd5.Parameters.AddWithValue("@adt", DateTime.Now);
                    cmd5.ExecuteNonQuery();
                    room_msg.Text = "Room-" + (string)ViewState["selectedRoom"] + " is booked for you! Thanks!";
                    taka.Text = "Payment successful! Don't forget your username is: " + usr + ".";
                    pay_book.Text = "Check Room";
                    Response.Redirect("/membership/membership.aspx?ref=token");
                }
                else
                {
                    room_msg.Text = "No payment information! Fill up payment form in Membership tab.";
                }

            }
            else
            {
                string getval = "select * from user_placement where user_id='"+usr+"' order by apply_date_time desc";
                cmd6 = new SqlCommand(getval, conn);
                decimal token_id;
                string room_id;
                DateTime placement, expiration, apply;
                using (SqlDataReader rdr = cmd6.ExecuteReader())
                {
                    if (rdr.HasRows)
                    {

                        Response.Clear();
                        Response.ClearContent();
                        Response.ClearHeaders();
                        rdr.Read();
                        room_id = rdr.GetString(rdr.GetOrdinal("room_id"));
                        token_id = rdr.GetDecimal(rdr.GetOrdinal("token"));
                        placement = rdr.GetDateTime(rdr.GetOrdinal("placement_date"));
                        expiration = rdr.GetDateTime(rdr.GetOrdinal("expiration_date"));
                        apply = rdr.GetDateTime(rdr.GetOrdinal("apply_date_time"));

                        FileStream fs = new FileStream(Server.MapPath("/Data/")+ "hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf",FileMode.Create);

                        iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(iTextSharp.text.PageSize.A5, 25, 10, 25, 10);
                        PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDoc, fs);
                        pdfDoc.Open();

                        iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance("http://localhost:55055/images/master/logo.png");
                        logo.ScaleAbsolute(120f, 120f);
                        logo.Alignment = iTextSharp.text.Element.ALIGN_MIDDLE;
                        logo.SpacingBefore = 15;
                        pdfDoc.Add(logo);


                        iTextSharp.text.Font fnt1 = iTextSharp.text.FontFactory.GetFont("Segoe UI", 13, new iTextSharp.text.BaseColor(System.Drawing.ColorTranslator.FromHtml("#01579B")));
                        iTextSharp.text.Font fnt2 = iTextSharp.text.FontFactory.GetFont("Segoe UI", 13, iTextSharp.text.Font.BOLD, new iTextSharp.text.BaseColor(System.Drawing.ColorTranslator.FromHtml("#000000")));
                        iTextSharp.text.Font fnt3 = iTextSharp.text.FontFactory.GetFont("Segoe UI", 15, iTextSharp.text.Font.BOLD, new iTextSharp.text.BaseColor(System.Drawing.ColorTranslator.FromHtml("#01579B")));
                        iTextSharp.text.Font fnt4 = iTextSharp.text.FontFactory.GetFont("Segoe UI", 10, iTextSharp.text.Font.ITALIC, new iTextSharp.text.BaseColor(System.Drawing.ColorTranslator.FromHtml("#C70039")));

                        PdfPTable tokTable = new PdfPTable(2);
                        tokTable.WidthPercentage = 100;
                        tokTable.SpacingAfter = 20;
                        tokTable.SpacingBefore = 10;

                        PdfPCell hdrCell1 = new PdfPCell(new iTextSharp.text.Paragraph("ROOM BOOKING", fnt3));
                        hdrCell1.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                        hdrCell1.BorderWidth = 0;
                        hdrCell1.PaddingBottom = 40;
                        hdrCell1.Colspan = 2;
                        tokTable.AddCell(hdrCell1);


                        PdfPCell tokCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Token ID:", fnt1));
                        tokCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        tokCell1.BorderWidth = 0;
                        tokCell1.PaddingBottom = 20;
                        tokTable.AddCell(tokCell1);

                        PdfPCell tokCell2 = new PdfPCell(new iTextSharp.text.Paragraph(token_id.ToString("000 000 000 000 000"), fnt2));
                        tokCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        tokCell2.BorderWidth = 0;
                        tokCell2.PaddingBottom = 10;
                        tokTable.AddCell(tokCell2);



                        PdfPCell usrCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Username:", fnt1));
                        usrCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        usrCell1.BorderWidth = 0;
                        usrCell1.PaddingBottom = 10;
                        tokTable.AddCell(usrCell1);

                        PdfPCell usrCell2 = new PdfPCell(new iTextSharp.text.Paragraph(usr, fnt2));
                        usrCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        usrCell2.BorderWidth = 0;
                        usrCell2.PaddingBottom = 10;
                        tokTable.AddCell(usrCell2);


                        PdfPCell roomCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Booked Room No:", fnt1));
                        roomCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        roomCell1.BorderWidth = 0;
                        roomCell1.PaddingBottom = 10;
                        tokTable.AddCell(roomCell1);

                        PdfPCell roomCell2 = new PdfPCell(new iTextSharp.text.Paragraph(room_id, fnt2));
                        roomCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        roomCell2.BorderWidth = 0;
                        roomCell2.PaddingBottom = 10;
                        tokTable.AddCell(roomCell2);


                        PdfPCell bokCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Booking Date:", fnt1));
                        bokCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        bokCell1.BorderWidth = 0;
                        bokCell1.PaddingBottom = 10;
                        tokTable.AddCell(bokCell1);

                        PdfPCell bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph(apply.ToShortDateString() + " at " + apply.ToShortTimeString(), fnt2));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 25;
                        tokTable.AddCell(bokCell2);

                        bokCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Room Migration----", fnt1));
                        bokCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        bokCell1.BorderWidth = 0;
                        bokCell1.PaddingBottom = 10;
                        tokTable.AddCell(bokCell1);

                        bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph("", fnt2));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 10;
                        tokTable.AddCell(bokCell2);


                        bokCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Starts:", fnt1));
                        bokCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        bokCell1.BorderWidth = 0;
                        bokCell1.PaddingBottom = 10;
                        tokTable.AddCell(bokCell1);

                        bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph(placement.ToShortDateString() + " at 12:00 PM", fnt2));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 10;
                        tokTable.AddCell(bokCell2);


                        bokCell1 = new PdfPCell(new iTextSharp.text.Paragraph("Ends:", fnt1));
                        bokCell1.HorizontalAlignment = PdfPCell.ALIGN_RIGHT;
                        bokCell1.BorderWidth = 0;
                        bokCell1.PaddingBottom = 10;
                        tokTable.AddCell(bokCell1);

                        bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph(expiration.AddDays(-1).ToShortDateString() + " at 11:59 AM", fnt2));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_LEFT;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 60;
                        tokTable.AddCell(bokCell2);



                        bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph("N.B. : > Don't share this page with anybody.", fnt4));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 7;
                        bokCell2.Colspan = 2;
                        tokTable.AddCell(bokCell2);

                        bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph("> Don't forget to bring this page! :)", fnt4));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 7;
                        bokCell2.Colspan = 2;
                        tokTable.AddCell(bokCell2);

                        bokCell2 = new PdfPCell(new iTextSharp.text.Paragraph("> Contact us: 01710001234, 01710001235", fnt4));
                        bokCell2.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                        bokCell2.BorderWidth = 0;
                        bokCell2.PaddingBottom = 7;
                        bokCell2.Colspan = 2;
                        tokTable.AddCell(bokCell2);

                        pdfDoc.Add(tokTable);



                        pdfWriter.CloseStream = false;
                        pdfDoc.Close();
                        fs.Flush();
                        fs.Close();


                        Response.ContentType = "Application/pdf";
                        Response.AppendHeader("Content-Disposition", "attachment; filename="+ "hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf");
                        Response.TransmitFile(Server.MapPath("/Data/"+ "hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf"));
                        Response.End();

                        /*
                        Response.Buffer = true;
                        Response.ContentType = "application/pdf";
                      
                        Response.AddHeader("content-disposition", "attachment;filename=hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf");
                        Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        
                        Response.Write(pdfDoc);
                        Response.Flush();
                        Response.End();*/
                    }
                }
            }
            conn.Close();
        }

        protected void year_select_order_SelectedIndexChanged(object sender, EventArgs e)
        {
            pay_book.Text = "Check Room";
            room_msg.Text = "&nbsp;";
            taka.Text = "&nbsp;";
        }

        protected void day_select_order_SelectedIndexChanged(object sender, EventArgs e)
        {
            pay_book.Text = "Check Room";
            room_msg.Text = "&nbsp;";
            taka.Text = "&nbsp;";
        }
    }

}