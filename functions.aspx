<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="functions.aspx.cs" Inherits="Hotel_Royale.functions" %>

<html>
    <head>
        <title>
            Hotel Royal | Funtions
        </title>
    </head>
    <body>
        <p style="display:inline;">It is an internal functional page, you can </p>
        <a href="Home.aspx">go to homepage.</a>
    </body>
</html>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="iTextSharp.text.pdf" %>
<% 


    String funct = Request.QueryString["func"];
    String data = Request.QueryString["data"];

    if (funct == "emailavail")
    {
        Boolean b = true;
        try
        {
            var addr = new System.Net.Mail.MailAddress(data);
            b = (addr.Address == data);
        }
        catch
        {
            b = false;
        }
        if (!b)
        {
            Response.Write("> Invalid Email address");
            return;
        }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        conn.Open();
        string checkUser = "select count(*) from user_data where email='" + data + "'";
        SqlCommand cmd = new SqlCommand(checkUser, conn);
        int countUN = Convert.ToInt32(cmd.ExecuteScalar());
        conn.Close();
        if (countUN != 0)
            b = false;

        if (!b)
        {
            Response.Write("> Email already has been registered");
            return;
        }
        else
        {
            Response.Write("&nbsp;");
        }
    }
    else if (funct == "usernameavail")
    {
        bool b = true;
        if (data.Length < 6)
        {
            Response.Write("> Username must be at least 6 latters");
            return;
        }
        for (int i = 0; i < data.Length; i++)
        {
            if (!((data[i] >= 65 && data[i] <= 90) || (data[i] >= 97 && data[i] <= 122) || (data[i] >= 48 && data[i] <= 57) || data[i] == 95 || data[i] == 46))
            {
                Response.Write("> Invalid Username! Accepted characters: A-Z a-z 0-9 _ .");
                return;
            }
        }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        conn.Open();
        string checkUser = "select count(*) from user_data where username='" + data + "'";
        SqlCommand cmd = new SqlCommand(checkUser, conn);
        int countUN = Convert.ToInt32(cmd.ExecuteScalar());

        if (countUN != 0)
            b = false;

        if (!b)
        {
            Response.Write("> Username already has been used! Try something new");
        }
        else
        {
            Response.Write("&nbsp;");
        }

    }
    else if (funct == "phnavail")
    {
        if (data == null || data.Length < 11)
        {
            Response.Write("> Phone number must have 11 digits");
            return;
        }
        for (int i = 0; i < data.Length; i++)
        {
            if (!(data[i] >= 48 && data[i] <= 57))
            {
                Response.Write("> Invalid phone number");
                return;
            }
        }
        Response.Write("&nbsp;");
    }
    else if (funct == "passavail")
    {
        if (data.Length < 6)
        {
            Response.Write("> Password must be at least 6 latters");
        }
        else
        {
            Response.Write("&nbsp;");
        }
    }
    else if (funct == "confpassavail")
    {
        String data2 = Request.QueryString["data2"];

        if (data != data2 || data2 == "")
        {
            Response.Write("> Password don't match");
        }
        else
        {
            Response.Write("&nbsp;");
        }
    }
    else if (funct == "down_form")
    {
        try {
            String data2 = Request.QueryString["data2"];
            data2 = System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(data2));



            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
            conn.Open();
            SqlCommand cmd6;
            string getval = "select * from user_placement where token=" + data2;
            cmd6 = new SqlCommand(getval, conn);
            decimal token_id;
            string room_id, usr;
            DateTime placement, expiration, apply;
            using (SqlDataReader rdr = cmd6.ExecuteReader())
            {
                if (rdr.HasRows)
                {

                    Response.Clear();
                    Response.ClearContent();
                    Response.ClearHeaders();
                    rdr.Read();
                    usr = rdr.GetString(rdr.GetOrdinal("user_id"));
                    room_id = rdr.GetString(rdr.GetOrdinal("room_id"));
                    token_id = rdr.GetDecimal(rdr.GetOrdinal("token"));
                    placement = rdr.GetDateTime(rdr.GetOrdinal("placement_date"));
                    expiration = rdr.GetDateTime(rdr.GetOrdinal("expiration_date"));
                    apply = rdr.GetDateTime(rdr.GetOrdinal("apply_date_time"));


                    iTextSharp.text.Document pdfDoc = new iTextSharp.text.Document(iTextSharp.text.PageSize.A5, 25, 10, 25, 10);
                    PdfWriter pdfWriter = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
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


                    /*
                    Response.ContentType = "Application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + "hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf");
                    Response.TransmitFile(Server.MapPath("/Data/" + "hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf"));
                    Response.End();*/


                    Response.Buffer = true;
                    Response.ContentType = "application/pdf";

                    Response.AddHeader("content-disposition", "attachment;filename=hotel_royal_" + usr + "_" + apply.Day + "_" + apply.Month + "_" + apply.Year + "_" + apply.Hour + "_" + apply.Minute + "_" + apply.Second + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);

                    Response.Write(pdfDoc);
                    Response.Flush();
                    Response.End();
                }
            }
            conn.Close();
        }
        catch (Exception e)
        {
            Response.Write(e.Message);
        }
    }


%>
