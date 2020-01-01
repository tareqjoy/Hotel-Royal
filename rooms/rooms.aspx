<%@ Page Title="" Language="C#" MasterPageFile="~/common.Master" AutoEventWireup="true" CodeBehind="rooms.aspx.cs" Inherits="Hotel_Royale.room.room" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titel" runat="server">
    Hotel Royal | Rooms
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/css/rooms/rooms.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="uncommon" runat="server">
    <div class="totDiv">
        <div class="tab">
            <table>
                <tr>
                    <td id="defaultBtn" class="tablink" onclick="openTab(event, 'room')">
                        <img src="../images/rooms/room_icon.png" />
                        <p>Book Room</p>
                    </td>
                    <td id="meetingRoomBtn" class="tablink" onclick="openTab(event, 'meeting_room')">
                        <img src="../images/rooms/meeting_icon.png" />
                        <p>Meeting Room</p>
                    </td>
                </tr>
            </table>
        </div>
        <table>
            <tr>
                <td style="width: 100%; height: 100%;">
                    <div class="tabcontent" id="room">

                        <input id="room_type_id" runat="server" style="display: none;" autopostback="true" />
                        <input id="total_customer_no" runat="server" style="display: none;" autopostback="true" />
                        <div class="room_type_div">
                            <div id="room_type">
                                <p>Room Type</p>
                                <table>
                                    <tr>
                                        <td>
                                            <div class="opt1" onclick="selectOpt1(event, 0)">
                                                <img src="../images/rooms/luxury_room.jpg" />
                                                <p>Luxury Room</p>
                                            </div>

                                        </td>
                                        <td>
                                            <div class="opt1" id="deaultOpt1" onclick="selectOpt1(event, 1)">
                                                <img src="../images/rooms/1st_class_room.jpg" />
                                                <p>1st Class Room</p>
                                            </div>

                                        </td>
                                        <td>
                                            <div class="opt1" onclick="selectOpt1(event, 2)">
                                                <img src="../images/rooms/elegant_room.jpg" />
                                                <p>Elegant Room</p>
                                            </div>

                                        </td>
                                        <td>
                                            <div class="opt1" onclick="selectOpt1(event, 3)">
                                                <img src="../images/rooms/accessible_room.jpg" />
                                                <p>Accessible Room</p>
                                            </div>

                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="room_total_customer">
                                <p>Total customers</p>
                                <table>
                                    <tr>
                                        <td style="width: 16%;">
                                            <div class="opt2" onclick="selectOpt2(event, 1)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">1</p>
                                            </div>
                                        </td>
                                        <td style="width: 17%;">
                                            <div class="opt2" onclick="selectOpt2(event, 2)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">2</p>
                                            </div>
                                        </td>
                                        <td style="width: 17%;">
                                            <div class="opt2" onclick="selectOpt2(event, 3)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">3</p>
                                            </div>
                                        </td>
                                        <td style="width: 17%;">
                                            <div class="opt2" id="deaultOpt2" onclick="selectOpt2(event, 4)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">4</p>
                                            </div>
                                        </td>
                                        <td style="width: 16%;">
                                            <div class="opt2" onclick="selectOpt2(event, 6)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">6</p>
                                            </div>
                                        </td>
                                        <td style="width: 17%;">
                                            <div class="opt2" onclick="selectOpt2(event, 8)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">8</p>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="meeting_total_customer">
                                <p>Capacity</p>
                                <table>
                                    <tr>
                                        <td style="width: 33%;">
                                            <div class="opt3" onclick="selectOpt3(event, 50)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">50</p>
                                            </div>
                                        </td>
                                        <td style="width: 34%;">
                                            <div class="opt3" id="deaultOpt3" onclick="selectOpt3(event, 100)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">100</p>
                                            </div>
                                        </td>
                                        <td style="width: 33%;">
                                            <div class="opt3" onclick="selectOpt3(event, 200)">
                                                <p style="padding-top: 10px; padding-bottom: 10px;">200</p>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <p>Pre-book From</p>
                            <asp:UpdatePanel ID="editInfo" runat="server">
                                <ContentTemplate>
                                    <div>
                                        <div style="display: table; margin-left: auto; margin-right: auto;">
                                            <asp:DropDownList OnSelectedIndexChanged="date_select_order_SelectedIndexChanged" ID="date_select_order" runat="server" AutoPostBack="true" Style="display: inline; width: 90px; margin: 0; border-right: 0;"></asp:DropDownList>
                                            <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="month_select_order_SelectedIndexChanged" ID="month_select_order" runat="server" Style="display: inline; width: 110px; margin: 0; border-right: 0;"></asp:DropDownList>
                                            <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="year_select_order_SelectedIndexChanged" ID="year_select_order" runat="server" Style="display: inline; width: 130px; margin: 0;"></asp:DropDownList>
                                        </div>

                                        <p style="margin-top: 10px;">For</p>
                                        <div style="display: table; margin-left: auto; margin-right: auto;">
                                            <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="day_select_order_SelectedIndexChanged" ID="day_select_order" runat="server" Style="display: inline; width: 282px; margin: 0;"></asp:DropDownList>
                                            <p style="display: inline; margin-top: 0;">Days</p>
                                        </div>
                                        <br />
                                        <asp:Label ID="room_msg" runat="server" Text="&nbsp;" Style="display: block; margin-left: auto; margin-right: auto; margin-top: 0;"></asp:Label>
                                        <asp:Label ID="taka" runat="server" Text="&nbsp;" Style="display: block; margin-left: auto; margin-right: auto; margin-top: 0; color: green; font-weight: bold;"></asp:Label>
                                        <asp:Button ID="pay_book" runat="server" Text="Check Room" OnClick="pay_book_Click" OnClientClick="showLoad();" />
                                        <div class="loading_div" id="loadingDIV">
                                            <img src="/images/home/lding.gif" id="regLoading" class="load_reg" />
                                        </div>
                                        
                                    </div>
                                </ContentTemplate>
                                
                            </asp:UpdatePanel>
                        </div>

                    </div>


                </td>
            </tr>
        </table>


    </div>



    <script>

         function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        function openTab(evt, cityName) {
            if (cityName == "room") {
                document.getElementById("<%=pay_book.ClientID%>").value = "Check Room";
                document.getElementById("<%=room_msg.ClientID%>").innerHTML = "&nbsp;";
                document.getElementById("<%=taka.ClientID%>").innerHTML = "&nbsp;";
                document.getElementById("<%=room_type_id.ClientID%>").value = "1";
                document.getElementById("<%=total_customer_no.ClientID%>").value = "4";
                document.getElementById("deaultOpt1").click();
                document.getElementById("deaultOpt2").click();
                document.getElementById("room_type").style.display = "block";
                document.getElementById("room_total_customer").style.display = "block";
                document.getElementById("meeting_total_customer").style.display = "none";
                document.getElementById("room").style.height = "800px";
            }
            else {
                document.getElementById("<%=pay_book.ClientID%>").value = "Check Room";
                document.getElementById("<%=room_msg.ClientID%>").innerHTML = "&nbsp;";
                document.getElementById("<%=taka.ClientID%>").innerHTML = "&nbsp;";
                document.getElementById("<%=room_type_id.ClientID%>").value = "4";
                document.getElementById("<%=total_customer_no.ClientID%>").value = "100";
                document.getElementById("deaultOpt3").click();
                document.getElementById("meeting_total_customer").style.display = "block";
                document.getElementById("room_type").style.display = "none";
                document.getElementById("room_total_customer").style.display = "none";
                document.getElementById("room").style.height = "500px";
            }
            tablinks = document.getElementsByClassName("tablink");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].style.backgroundColor = "#ddd";
                tablinks[i].style.borderTop = "3px solid #ddd";
            }
            evt.currentTarget.style.backgroundColor = "#EEEEEE";
            evt.currentTarget.style.borderTop = "3px solid #D35400";
        }


        // Get the element with id="defaultOpen" and click on it


        if (getParameterByName('to') == 'mr') {
            document.getElementById("meetingRoomBtn").click();
        } else {
             document.getElementById("defaultBtn").click();
        }

        function selectOpt1(evt, ind) {
            document.getElementById("<%=room_type_id.ClientID%>").value = ind;
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("opt1");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].className = tabcontent[i].className.replace(" active", "");
            }
            evt.currentTarget.className += " active";
            document.getElementById("<%=pay_book.ClientID%>").value = "Check Room";
            document.getElementById("<%=room_msg.ClientID%>").innerHTML = "&nbsp;";
            document.getElementById("<%=taka.ClientID%>").innerHTML = "&nbsp;";
        }
        document.getElementById("deaultOpt1").click();

        function selectOpt2(evt, ind) {
            document.getElementById("<%=total_customer_no.ClientID%>").value = ind;
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("opt2");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].className = tabcontent[i].className.replace(" active", "");
            }
            evt.currentTarget.className += " active";
            document.getElementById("<%=pay_book.ClientID%>").value = "Check Room";
            document.getElementById("<%=room_msg.ClientID%>").innerHTML = "&nbsp;";
            document.getElementById("<%=taka.ClientID%>").innerHTML = "&nbsp;";
        }


        document.getElementById("deaultOpt2").click();

        function selectOpt3(evt, ind) {
            document.getElementById("<%=total_customer_no.ClientID%>").value = ind;
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("opt3");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].className = tabcontent[i].className.replace(" active", "");
            }
            evt.currentTarget.className += " active";
            document.getElementById("<%=pay_book.ClientID%>").value = "Check Room";
            document.getElementById("<%=room_msg.ClientID%>").innerHTML = "&nbsp;";
            document.getElementById("<%=taka.ClientID%>").innerHTML = "&nbsp;";
        }



        function showLoad() {
            document.getElementById("loadingDIV").style.opacity = "1";
            document.getElementById("loadingDIV").style.zIndex = "600";
        }
    </script>
</asp:Content>
