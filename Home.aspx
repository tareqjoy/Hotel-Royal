<%@ Page Title="" Language="C#" MasterPageFile="~/common.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Hotel_Royale.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titel" runat="server">
    Hotel Royal | Home
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/css/home/home.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="uncommon" runat="server">

    <div>
        <div class="container" id="hotelpic_container">

            <div style="position: relative; top: 90%; transform: translateY(-50%)">
                <p id="discHotelPic">Hotel Royal Front View</p>
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
        <asp:UpdatePanel ID="lginPanel" runat="server">
            <ContentTemplate>
                <div class="lgin" runat="server" id="login_layout" href="#pool">

                    <div class="lgin_right_div">
                        <img src="/images/home/profile_icon.png" class="ico_inp" />
                        <asp:TextBox placeholder="email or username" runat="server" ID="lgin_username" />

                        <br />
                        <img src="/images/home/key_icon.png" class="ico_inp" />
                        <asp:TextBox class="ico_pass" TextMode="Password" placeholder="password" runat="server" ID="lgin_pass" />
                        <br />
                        <p id="loginErr" runat="server" style="color: red; font-size: 14px; font-weight: bolder; margin-top: 3px;">&nbsp;</p>
                        <br />
                        <asp:Button ID="login_btn" runat="server" Text="Sign In" OnClick="login_btn_Click" />
                        <br />
                        <p>or</p>
                        <br />
                        <input type="button" id="sign_up" value="Register Now" onclick="open_modal()" style="margin-left: -3px; margin-top: 3px;" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="modal_container" id="modal">
            <div class="modal">
                <img src="/images/home/close.png" class="close" id="cancel_modal" onclick="cancel_dlg()" />
                <span class="modal_heading">Registration
                </span>

                <asp:UpdatePanel ID="regUpdtPnl" runat="server">
                    <ContentTemplate>
                        <div>
                            <img src="/images/home/ico_email.png" class="ico_reg" />
                            <input placeholder="Email" id="newEmail" runat="server" onblur="email_validate(this.value)" onkeyup="email_validate(this.value)" maxlength="50" /><br />
                            <p id="newEmailErr">&nbsp;</p>
                            <img src="/images/home/ico_userReg.png" class="ico_reg" />
                            <input placeholder="Username" id="newUserName" runat="server" onblur="username_validate(this.value)" onkeyup="username_validate(this.value)" maxlength="12" autocomplete="off" /><br />
                            <p id="newUserNameErr">&nbsp;</p>
                            <img src="/images/home/ico_phn.png" class="ico_reg" />
                            <input placeholder="Phone No" id="newPhone" runat="server" onblur="phone_validate(this.value)" onkeyup="phone_validate(this.value)" maxlength="11" /><br />

                            <p id="newPhoneErr">&nbsp;</p>

                            <img src="/images/home/ico_passwReg.png" class="ico_reg" />
                            <input type="password" placeholder="Password" id="newPassword" maxlength="50" runat="server" onblur="pass_validate(this.value)" onkeyup="pass_validate(this.value)" autocomplete="off" /><br />
                            <p id="newPasswordErr">&nbsp;</p>
                            <img src="/images/home/ico_passwReg.png" class="ico_reg" />
                            <input type="password" placeholder="Confirm Password" id="newConfirmPassword" runat="server" maxlength="50" onblur="confpass_validate(this.value)" onkeyup="confpass_validate(this.value)" autocomplete="off" /><br />
                            <p id="newConfirmPasswordErr">&nbsp;</p>

                            <asp:Button ID="create_account_btn" runat="server" OnClick="create_account" OnClientClick="return showLoad();" Text="Register" class="CreateAccnt" />

                            <img src="/images/home/lding.gif" id="regLoading" class="load_reg" />
                        </div>

                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>
        </div>

        <div class="heading">
            <p>Make an option</p>
        </div>
        <div class="activity" runat="server" id="actv">
            <table>
                <tr>
                    <td>
                        <div style="background-image: url(/images/home/actv_back1.jpg); background-size: cover;">
                            <a href="/rooms/rooms.aspx?to=br" />
                            <div>
                                <p>Book a room</p>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div style="background-image: url(/images/home/actv_back2.jpg); background-size: cover;">
                            <a href="/rooms/rooms.aspx?to=mr" />
                            <div>
                                <p>Book Meeting room</p>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div style="background-image: url(/images/home/actv_back3.jpg); background-size: cover;">
                            <a href="/restaurant/restaurant.aspx?to=br" />
                            <div>
                                <p>Book Resturant</p>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div style="background-image: url(/images/home/actv_back4.jpg); background-size: cover;">
                            <a href="/restaurant/restaurant.aspx?to=of" />
                            <div>
                                <p>Order Food</p>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div style="background-image: url(/images/home/actv_back5.jpg); background-size: cover;">
                            <a href="/events/events.aspx?to=cr" />
                            <div>
                                <p>Join Upcoming Events</p>
                            </div>
                        </div>
                    </td>
                    <td>
                        <div style="background-image: url(/images/home/actv_back6.jpg); background-size: cover;">
                            <a href="/membership/membership.aspx" />
                            <div>
                                <p>User Profile</p>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>

        <div class="heading">
            <p>Our Facilities</p>
        </div>
        <table class="faci_table">
            <tr>
                <td style="padding: 0; margin: 0px; background-image: url('/images/home/faci1.jpg'); background-size: 100% 100%;">
                    <div>
                        <p class="faci_big_font">Free Internet</p>
                        <p class="faci_small_font">Enjoy 25MB/s wireless internet through the whole hotel. Download, Browse & stay connected all time.</p>
                        <input type="button" value="Get Internet Settings" onclick="location.href = '/services/services.aspx?to=fi'" />
                    </div>
                </td>
                <td style="padding: 0; margin: 0px; background-image: url('/images/home/faci2.jpg'); background-size: 100% 100%;">
                    <div>
                        <p class="faci_big_font">Buffet</p>
                        <p class="faci_small_font">Free buffet dinner on every Friday. Upto 17 items available including exotic items & drinks.</p>
                        <input type="button" value="View Upcoming Menu" onclick="location.href = '/services/services.aspx?to=fb'" />
                    </div>
                </td>

                <td style="padding: 0; margin: 0px; background-image: url('/images/home/faci4.jpg'); background-size: 100% 100%;">
                    <div>
                        <p class="faci_big_font">Swimming Pool</p>
                        <p class="faci_small_font">You will be glad to know that we have an attached swimming pool. Free for all day! Cheers!</p>
                        <input type="button" value="Find Schedule" onclick="location.href = '/services/services.aspx?to=sp'" />
                    </div>
                </td>
            </tr>
        </table>


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

            var reg1 = false, reg2 = false, reg3 = false, reg4 = false, reg5 = false;
            function findPos(obj) {
                var c = 0;
                if (obj.offsetParent) {
                    do {
                        c += obj.offsetTop;

                    } while (obj = obj.offsetParent);
                    return [c];
                }
            }
            if (getParameterByName('focus') == 'lgin') {
                document.getElementById('<%=login_layout.ClientID%>').scrollIntoView();

            }

            function showLoad() {
                if (reg1 && reg2 && reg3 && reg4 && reg5) {
                    document.getElementById("regLoading").style.opacity = "1";
                    document.getElementById("regLoading").style.zIndex = "500";
                    return true;
                } else {
                    return false;
                }


            }
            function focusLgin() {
                document.getElementById("login_layout").scrollIntoView();
                document.getElementById('<%=lgin_username.ClientID%>').focus();
            }
            function open_modal() {
                document.getElementById("modal").style.opacity = "1";
                document.getElementById("modal").style.pointerEvents = "auto";
            }
            function cancel_dlg() {
                document.getElementById("modal").style.opacity = "0";
                document.getElementById("modal").style.pointerEvents = "none";
                document.getElementById("newEmailErr").innerHTML = '&nbsp;';
                document.getElementById("newPhoneErr").innerHTML = '&nbsp;';
                document.getElementById("newConfirmPasswordErr").innerHTML = '&nbsp;';
                document.getElementById("newPasswordErr").innerHTML = '&nbsp;';
                document.getElementById("newUserNameErr").innerHTML = '&nbsp;';
                document.getElementById("<%=newEmail.ClientID%>").value = "";
                document.getElementById("<%=newPhone.ClientID%>").value = "";
                document.getElementById("<%=newUserName.ClientID%>").value = "";
                document.getElementById("<%=newPassword.ClientID%>").value = "";
                document.getElementById("<%=newConfirmPassword.ClientID%>").value = "";

                document.getElementById("<%=newPhone.ClientID%>").style.borderColor = "#f2f2f2";
                document.getElementById("<%=newEmail.ClientID%>").style.borderColor = "#f2f2f2";
                document.getElementById("<%=newUserName.ClientID%>").style.borderColor = "#f2f2f2";
                document.getElementById("<%=newPassword.ClientID%>").style.borderColor = "#f2f2f2";
                document.getElementById("<%=newConfirmPassword.ClientID%>").style.borderColor = "#f2f2f2";
            }

            document.getElementById("hotelpic_container").style.backgroundImage = "url('/images/home/hotelpic1.jpg')";
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
                    imgSrc = "/images/home/hotelpic2.jpg";
                    discription = "First class Room";
                }
                else if (c == 2) {
                    imgSrc = "/images/home/hotelpic3.jpg";
                    discription = "Luxury Room";
                }
                else if (c == 3) {
                    imgSrc = "/images/home/hotelpic4.jpg";
                    discription = "Waiting Room";
                }
                else if (c == 4) {
                    imgSrc = "/images/home/hotelpic1.jpg";
                    discription = "Hotel Royal Front View";
                }
                document.getElementById("hotelpic_container").style.backgroundImage = "url('" + imgSrc + "')";
                document.getElementById("discHotelPic").innerHTML = discription;
            }
            setInterval(nextHotelPic, 3500);


            function email_validate(str) {

                if (str.length == 0) {
                    document.getElementById("newEmailErr").innerHTML = "&nbsp;";
                    reg1 = false;
                    return;
                } else {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            if (this.responseText == "&nbsp;") {
                                document.getElementById("<%=newEmail.ClientID%>").style.borderColor = "green";
                                reg1 = true;
                            } else {
                                document.getElementById("<%=newEmail.ClientID%>").style.borderColor = "red";
                                reg1 = false;
                            }
                            document.getElementById("newEmailErr").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("GET", "/functions.aspx?func=emailavail&data=" + str, true);
                    xmlhttp.send();
                }
            }

            function username_validate(str) {

                if (str.length == 0) {
                    document.getElementById("newUserNameErr").innerHTML = "&nbsp;";
                    reg2 = false;
                    return;
                } else {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            if (this.responseText == "&nbsp;") {
                                document.getElementById("<%=newUserName.ClientID%>").style.borderColor = "green";
                                reg2 = true;
                            } else {
                                document.getElementById("<%=newUserName.ClientID%>").style.borderColor = "red";
                                reg2 = false;
                            }
                            document.getElementById("newUserNameErr").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("GET", "/functions.aspx?func=usernameavail&data=" + str, true);
                    xmlhttp.send();
                }
            }

            function phone_validate(str) {

                if (str.length == 0) {
                    document.getElementById("newPhoneErr").innerHTML = "&nbsp;";
                    reg3 = false;
                    return;
                } else {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            if (this.responseText == "&nbsp;") {
                                document.getElementById("<%=newPhone.ClientID%>").style.borderColor = "green";
                                reg3 = true;
                            } else {
                                document.getElementById("<%=newPhone.ClientID%>").style.borderColor = "red";
                                reg3 = false;
                            }
                            document.getElementById("newPhoneErr").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("GET", "/functions.aspx?func=phnavail&data=" + str, true);
                    xmlhttp.send();
                }
            }

            function pass_validate(str) {

                if (str.length == 0) {
                    document.getElementById("newPasswordErr").innerHTML = "&nbsp;";
                    reg4 = false;
                    return;
                } else {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            if (this.responseText == "&nbsp;") {
                                document.getElementById("<%=newPassword.ClientID%>").style.borderColor = "green";
                                reg4 = true;
                            } else {
                                document.getElementById("<%=newPassword.ClientID%>").style.borderColor = "red";
                                reg4 = false;
                            }
                            document.getElementById("newPasswordErr").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("GET", "/functions.aspx?func=passavail&data=" + str, true);
                    xmlhttp.send();
                }
            }

            function confpass_validate(str) {

                if (str.length == 0) {
                    document.getElementById("newConfirmPasswordErr").innerHTML = "&nbsp;";
                    reg5 = false;
                    return;
                } else {
                    var xmlhttp = new XMLHttpRequest();
                    xmlhttp.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            if (this.responseText == "&nbsp;") {
                                document.getElementById("<%=newConfirmPassword.ClientID%>").style.borderColor = "green";
                                reg5 = true;
                            } else {
                                document.getElementById("<%=newConfirmPassword.ClientID%>").style.borderColor = "red";
                                reg5 = false;
                            }
                            document.getElementById("newConfirmPasswordErr").innerHTML = this.responseText;
                        }
                    };
                    xmlhttp.open("GET", "/functions.aspx?func=confpassavail&data=" + str + "&data2=" + document.getElementById("<%=newPassword.ClientID%>").value, true);
                    xmlhttp.send();
                }
            }


        </script>
    </div>
</asp:Content>
