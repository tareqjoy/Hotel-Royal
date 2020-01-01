<%@ Page Title="" Language="C#" MasterPageFile="~/common.Master" AutoEventWireup="true" CodeBehind="membership.aspx.cs" Inherits="Hotel_Royale.membership.membership" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titel" runat="server">
    Hotel Royal | Membership
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/css/membership/membership.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="uncommon" runat="server">
    <div class="totDiv">

        <div class="tab">
            <table>
                <tr>
                    <td id="defaultBtn" class="tablink" onclick="openTab(event, 'basicInf')">
                        <img src="../images/membership/basic_info_ico.png" />
                        <p>Basic Info</p>

                    </td>
                    <td id="historyBtn" class="tablink" onclick="openTab(event, 'history')">
                        <img src="../images/membership/history_ico.png" />
                        <p>History & Tokens</p>

                    </td>
                    <td id="settingsBtn" class="tablink" onclick="openTab(event, 'settings')">
                        <img src="../images/membership/setting_ico.png" />
                        <p>Settings</p>

                    </td>
                    <td id="paymentBtn" class="tablink" onclick="openTab(event, 'payment')">
                        <img src="../images/membership/payment_ico.png" />
                        <p>Payment</p>

                    </td>
                </tr>
            </table>



        </div>
        <table>
            <tr>

                <td style="width: 100%; height: 100%;">
                    <div class="tabcontent" id="basicInf">
                        <asp:UpdatePanel ID="editInfo" runat="server">
                            <ContentTemplate>
                                <asp:Timer ID="webTimer" Enabled="false" OnTick="webTimer_Tick" Interval="5000" runat="server"></asp:Timer>

                                <div class="basic_info">
                                    <table>

                                        <tr>
                                            <td>
                                                <p>Full Name</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="funn_name_info" Placeholder="not set" runat="server" MaxLength="50" AutoCompleteType="DisplayName" />
                                                <p id="funn_name_err" runat="server">&nbsp;</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Hometown</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="hometown_info" Placeholder="not set" runat="server" MaxLength="50" AutoCompleteType="HomeCity" />
                                                <p id="hometown_err" runat="server">&nbsp;</p>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Working City</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="working_city_info" Placeholder="not set" runat="server" MaxLength="50" AutoCompleteType="BusinessCity" />
                                                <p id="working_city_err" runat="server">&nbsp;</p>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Gender</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <select id="gender_info" runat="server" style="cursor: pointer;">
                                                    <option value="0">--Select Gender--</option>
                                                    <option value="1">Male</option>
                                                    <option value="2">Female</option>
                                                </select>
                                                <p id="gender_err" runat="server">&nbsp;</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Birth date</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="birth_date_info" placeholder="date" runat="server" Style="width: 60px; display: inline;"></asp:TextBox>
                                                <select id="birth_month_info" runat="server" style="cursor: pointer; width: 150px; display: inline;">
                                                    <option value="0">Select Month</option>
                                                    <option value="1">Jan</option>
                                                    <option value="2">Feb</option>
                                                    <option value="3">Mar</option>
                                                    <option value="4">Apr</option>
                                                    <option value="5">May</option>
                                                    <option value="6">Jun</option>
                                                    <option value="7">Jul</option>
                                                    <option value="8">Aug</option>
                                                    <option value="9">Sep</option>
                                                    <option value="10">Oct</option>
                                                    <option value="11">Nov</option>
                                                    <option value="12">Dec</option>
                                                </select>
                                                <asp:TextBox ID="birth_year_info" placeholder="year" runat="server" Style="width: 80px; display: inline;"></asp:TextBox>
                                                <br />
                                                <p id="birth_err" runat="server">&nbsp;</p>
                                            </td>
                                        </tr>

                                    </table>
                                    <asp:Label ID="save_basic_msg" runat="server" Text="&nbsp;" CssClass="basic_info_save_msg"></asp:Label>
                                    <asp:Button ID="save_basic_info" OnClick="save_basic_info_Click" runat="server" Text="Save" CssClass="basic_info_save_data" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="tabcontent" id="history">
                  
                                <asp:Panel ID="records" runat="server" ScrollBars="Vertical"  CssClass="timeline">
                                  
                                      


                                </asp:Panel>
                          
                    </div>
                    <div class="tabcontent" id="settings">
                        <asp:UpdatePanel ID="editSettingsUpdtPanel" runat="server">
                            <ContentTemplate>
                                <div class="basic_info">
                                    <table>
                                        <tr>
                                            <td>
                                                <p>Username</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="username_settings" runat="server" ReadOnly="true" MaxLength="50" />
                                                <p id="username_err" runat="server">&nbsp;</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Email</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="email_settings" runat="server" ReadOnly="true" MaxLength="50" />
                                                <p id="email_err" runat="server">&nbsp;</p>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Change Password</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="curr_password_settings" runat="server" Placeholder="Current Password" MaxLength="50" AutoCompleteType="None" TextMode="Password" />
                                                <p id="curr_password_err" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;" runat="server">&nbsp;</p>
                                                <asp:TextBox ID="new_password_settings" runat="server" Placeholder="New Password" MaxLength="50" AutoCompleteType="None" TextMode="Password" />
                                                <p id="new_password_err" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;" runat="server">&nbsp;</p>
                                                <asp:TextBox ID="confirm_password_settings" runat="server" Placeholder="Confirm Password" MaxLength="50" AutoCompleteType="None" TextMode="Password" />
                                                <p id="confirm_password_err" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;" runat="server">&nbsp;</p>
                                            </td>

                                        </tr>


                                    </table>
                                    <asp:Label ID="save_settings_msg" runat="server" Text="&nbsp;" CssClass="basic_info_save_msg"></asp:Label>

                                    <asp:Button ID="save_settings" OnClick="save_settings_Click" runat="server" Text="Save" CssClass="basic_info_save_data" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="tabcontent" id="payment">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>

                                <div class="basic_info">
                                    <img src="../images/membership/visa_logo.png" class="info_visa_logo" />
                                    <table>
                                        <tr>
                                            <td>
                                                <p>Card Number</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="card_number_payment" runat="server" OnTextChanged="card_number_payment_TextChanged" Placeholder="not set" AutoPostBack="true" MaxLength="12" AutoCompleteType="None" />
                                                <p id="card_number_err" runat="server" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;">&nbsp;</p>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <p class="upOfTable">Expiration Date</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <select id="expiration_date_month_payment" runat="server" style="cursor: pointer;">
                                                    <option value="0">--Select Month--</option>
                                                    <option value="1">Jan</option>
                                                    <option value="2">Feb</option>
                                                    <option value="3">Mar</option>
                                                    <option value="4">Apr</option>
                                                    <option value="5">May</option>
                                                    <option value="6">Jun</option>
                                                    <option value="7">Jul</option>
                                                    <option value="8">Aug</option>
                                                    <option value="9">Sep</option>
                                                    <option value="10">Oct</option>
                                                    <option value="11">Nov</option>
                                                    <option value="12">Dec</option>
                                                </select>
                                                <p id="expiration_date_month_err" runat="server" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;">&nbsp;</p>
                                                <asp:TextBox ID="expiration_date_year_payment" runat="server" OnTextChanged="expiration_date_year_payment_TextChanged" Placeholder="Expiration Year" AutoPostBack="true" MaxLength="4" AutoCompleteType="None" />
                                                <p id="expiration_date_year_err" runat="server" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;">&nbsp;</p>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td>
                                                <p>CVC</p>
                                                <p>&nbsp;</p>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="cvc_payment" OnTextChanged="cvc_payment_TextChanged" runat="server" Placeholder="not set" AutoPostBack="true" MaxLength="3" AutoCompleteType="None" />
                                                <p id="cvc_err" runat="server" style="text-align: left; color: red; font-size: 14px; margin-left: 18px;">&nbsp;</p>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="save_payment_msg" runat="server" Text="&nbsp;" CssClass="basic_info_save_msg"></asp:Label>

                                    <asp:Button ID="save_payment" OnClick="save_payment_Click" runat="server" Text="Save" CssClass="basic_info_save_data" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
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
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablink");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].style.backgroundColor = "#E0E0E0";
                tablinks[i].style.borderTop = "3px solid #E0E0E0";
            }
            document.getElementById(cityName).style.display = "block";
            evt.currentTarget.style.backgroundColor = "#F5F5F5";
            evt.currentTarget.style.borderTop = "3px solid #D35400";
        }
        if (getParameterByName('ref') == 'token') {
            document.getElementById("historyBtn").click();
        } else {
            document.getElementById("defaultBtn").click();
        }

    </script>
</asp:Content>
