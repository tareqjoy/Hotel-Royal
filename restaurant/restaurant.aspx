<%@ Page Title="" Language="C#" MasterPageFile="~/common.Master" AutoEventWireup="true" CodeBehind="restaurant.aspx.cs" Inherits="Hotel_Royale.resturant.resturant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titel" runat="server">
    Hotel Royal | Restaurant
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/css/restaurant/restaurant.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="uncommon" runat="server">
    <div class="container" id="hotelpic_container">

        <div style="position: relative; top: 90%; transform: translateY(-50%)">
            <p id="discHotelPic">Fast Food</p>
        </div>
        <div style="position: relative; top: 50%; transform: translateY(-50%)">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <img src="/images/home/prev.png" class="next_prev" id="prevButton" onclick="prevHotelPic()" />
                    </td>
                    <td style="text-align: right;">
                        <img src="/images/home/next.png" class="next_prev" id="nextButton" onclick="nextHotelPic()" />
                    </td>
                </tr>
            </table>
        </div>

    </div>

    <div class="heading" id="headingDiv">
        <p>Book or Order Now</p>
    </div>

    <asp:TextBox ID="opt1Val" runat="server" Style="display: none;"></asp:TextBox>
    <asp:TextBox ID="opt2Val" runat="server" Style="display: none;"></asp:TextBox>
    <div style="background-color: white; height: 100%; width: 100%; display: inline-block;">
        <div class="option">
            <p id="defaultOpt1" class="opt1" onclick="selectOpt1(event, 0);">Order Now</p>

            <p id="defaultOpt2" class="opt1" onclick="selectOpt1(event, 1);">Book Restaurant</p>
        </div>
        <div class="choose">
            <p>Fast Food</p>
            <asp:Panel runat="server" class="select_option" ID="fast_food_div">
                
               
            </asp:Panel>
            <p>Rice</p>
            <asp:Panel runat="server" class="select_option" ID="rice_div">
                
            </asp:Panel>
            <p>Chicken Dish</p>
            <asp:panel runat="server" id="chicken_dish_div" class="select_option">
               
            </asp:panel>
            <p>Beef Dish</p>
            <asp:Panel class="select_option" runat="server" ID="beef_dish_div">
                
            </asp:Panel>
            <p>Drinks</p>
            <asp:panel runat="server" ID="drinks_div" class="select_option">
               
            </asp:panel>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="choose">
                    <p>At</p>
                    <div class="restaurant_order" style="display: table; margin-left: auto; margin-right: auto;">
                        <asp:DropDownList ID="date_select_order" runat="server" AutoPostBack="true" Style="display: inline; width: 90px; margin: 0; border-right: 0;"></asp:DropDownList>
                        <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="month_select_order_SelectedIndexChanged" ID="month_select_order" runat="server" Style="display: inline; width: 110px; margin: 0; border-right: 0;"></asp:DropDownList>
                        <asp:DropDownList AutoPostBack="true" ID="year_select_order" runat="server" Style="display: inline; width: 130px; margin: 0;"></asp:DropDownList>
                    </div>

                    <p>Time</p>
                    <div class="restaurant_order" style="display: table; margin-left: auto; margin-right: auto;">
                        <asp:DropDownList AutoPostBack="true" ID="day_select_order" runat="server" Style="display: inline; width: 330px; margin: 0;">
                            <asp:ListItem Value="0">Now</asp:ListItem>
                            <asp:ListItem Value="1">Breakfast @9am</asp:ListItem>
                            <asp:ListItem Value="2">Lunch @1pm</asp:ListItem>
                            <asp:ListItem Value="3">After-Lunch @5pm</asp:ListItem>
                            <asp:ListItem Value="4">Dinner @9pm</asp:ListItem>
                        </asp:DropDownList>

                    </div>
                    <p>For</p>
                    <div class="restaurant_order" style="display: table; margin-left: auto; margin-right: auto;">
                        <input type="text" id="people" autopostback="true" onkeyup="peopleTyped()" autocompletetype="None" placeholder="max: 120" value="1" runat="server" style="display: inline; width: 282px; margin: 0; text-align: left; color: black;" maxlength="3" />
                        <p style="display: inline; margin-top: 0; color: #D35400; margin-left: 8px;">Person</p>
                    </div>
                    <input id="hdnLabelState" type="hidden" runat="server" value="0" >
                    <asp:Label ID="restaurant_msg" runat="server" Text="&nbsp;" Style="display: block; text-align: center; margin-top: 10px; color: brown; font-size: 20px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;"></asp:Label>
                   <div style="display: table; margin-left: auto; margin-right: auto;">
                     <asp:Label ID="Label1" runat="server" Text="Total: " Style="display: inline; text-align: center; margin-top: 10px; color: brown; font-size: 20px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;"></asp:Label>
                    <asp:Label ID="taka" runat="server" Text="0"  Style="text-align: center; display: inline; margin-top: 10px; margin-bottom: 10px; color: green; font-weight: bold; font-size: 20px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;"></asp:Label>
                     <asp:Label ID="Label2" runat="server" Text=" /-Tk" Style="display: inline; text-align: center; margin-top: 10px; color: brown; font-size: 20px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;"></asp:Label>
                    </div>
                       <br />
                    <asp:Button ID="pay_book" runat="server" Text="Confirm" OnClick="pay_book_Click" OnClientClick="showLoad();" />
                    <div class="loading_div" id="loadingDIV">
                        <img src="/images/home/lding.gif" id="regLoading" class="load_reg" />
                    </div>
                </div>
            </ContentTemplate>

        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
         function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        var totalCost = 0;
        document.getElementById("hotelpic_container").style.backgroundImage = "url('/images/restaurant/hotelpic1.jpg')";
        var c = 0;
        function nextHotelPic() {
            c++;
            if (c == 5) {
                c = 1;
            }
            changeHotelPic();
        }
        function prevHotelPic() {
            c--;
            if (c == 0) {
                c = 4;
            }
            if (c == -1) {
                c = 3;
            }
            changeHotelPic();
        }
        function changeHotelPic() {
            clearInterval(null);
            var imgSrc, discription;
            if (c == 1) {
                imgSrc = "/images/restaurant/hotelpic2.jpg";
                discription = "Any kinds of drinks";
            }
            else if (c == 2) {
                imgSrc = "/images/restaurant/hotelpic3.jpg";
                discription = "Traditional food";
            }
            else if (c == 3) {
                imgSrc = "/images/restaurant/hotelpic4.jpg";
                discription = "Biriyani";
            }
            else if (c == 4) {
                imgSrc = "/images/restaurant/hotelpic1.jpg";
                discription = "Fast food";
            }
            document.getElementById("hotelpic_container").style.backgroundImage = "url('" + imgSrc + "')";
            document.getElementById("discHotelPic").innerHTML = discription;
        }
        setInterval(nextHotelPic, 3500);

        function showLoad() {
            document.getElementById("loadingDIV").style.opacity = "1";
            document.getElementById("loadingDIV").style.zIndex = "600";
        }

        function selectOpt1(evt, ind) {
            document.getElementById("<%=restaurant_msg.ClientID%>").innerHTML = "&nbsp;";
            document.getElementById("<%=opt1Val.ClientID%>").value = ind;
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("opt1");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].className = tabcontent[i].className.replace(" active", "");
            }
            evt.currentTarget.className += " active";
        }

        if (getParameterByName('to') == 'br') {
            document.getElementById("defaultOpt2").click();
            document.getElementById("headingDiv").scrollIntoView();
        } else if (getParameterByName('to') == 'of') {
            document.getElementById("defaultOpt1").click();
            document.getElementById("headingDiv").scrollIntoView();
        } else {
            document.getElementById("defaultOpt1").click();
        }
       

        function selectOpt2(evt, ind, price) {
            document.getElementById("<%=restaurant_msg.ClientID%>").innerHTML = "&nbsp;";

            if (evt.currentTarget.className.indexOf(" active") >= 0) {
                evt.currentTarget.className = evt.currentTarget.className.replace(" active", "");
                document.getElementById("<%=opt2Val.ClientID%>").value = document.getElementById("<%=opt2Val.ClientID%>").value.replace(" " + ind + " ", "");
                totalCost -= price;
                var k2 = parseInt(document.getElementById("<%=people.ClientID%>").value);
                document.getElementById("<%=taka.ClientID%>").innerHTML = k2 * totalCost;
            }
            else {
                evt.currentTarget.className += " active";
                document.getElementById("<%=opt2Val.ClientID%>").value += " " + ind + " ";
                var k2 = parseInt(document.getElementById("<%=people.ClientID%>").value);
                totalCost += price;

                document.getElementById("<%=taka.ClientID%>").innerHTML = k2 * totalCost;

            }
            if (document.getElementById("<%=taka.ClientID%>").innerHTML == "NaN" || parseInt(document.getElementById("<%=taka.ClientID%>").innerHTML) < 0) {
                document.getElementById("<%=taka.ClientID%>").innerHTML = "Input valid total person!"
            }
            else if (parseInt(document.getElementById("<%=people.ClientID%>").value) > 120) {
                document.getElementById("<%=restaurant_msg.ClientID%>").innerHTML = "Sorry! We have capacity of 120 persons!"
            }
            else {
                 document.getElementById("<%=restaurant_msg.ClientID%>").innerHTML = "&nbsp;"
            }
            document.getElementById('<%= hdnLabelState.ClientID %>').value = document.getElementById("<%=taka.ClientID%>").innerHTML;
        }
        function peopleTyped() {
            document.getElementById("<%=taka.ClientID%>").innerHTML = parseInt(document.getElementById("<%=people.ClientID%>").value) * totalCost;
            if (document.getElementById("<%=taka.ClientID%>").innerHTML == "NaN" || parseInt(document.getElementById("<%=taka.ClientID%>").innerHTML) < 0) {
                document.getElementById("<%=taka.ClientID%>").innerHTML = "Input valid total person!"
            }
            else if (parseInt(document.getElementById("<%=people.ClientID%>").value) > 120) {
                document.getElementById("<%=restaurant_msg.ClientID%>").innerHTML = "Sorry! We have capacity of 120 persons!"
            }
            else {
                 document.getElementById("<%=restaurant_msg.ClientID%>").innerHTML = "&nbsp;"
            }
            document.getElementById('<%= hdnLabelState.ClientID %>').value = document.getElementById("<%=taka.ClientID%>").innerHTML;
        }
    </script>
</asp:Content>
