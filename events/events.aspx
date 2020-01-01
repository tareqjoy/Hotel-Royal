<%@ Page Title="" Language="C#" MasterPageFile="~/common.Master" AutoEventWireup="true" CodeBehind="events.aspx.cs" Inherits="Hotel_Royale.events.events" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titel" runat="server">
    Hotel Royal | Events
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="/css/events/events.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="uncommon" runat="server">
    <div>
        <div class="container" id="hotelpic_container">

            <div style="position: relative; top: 90%; transform: translateY(-50%)">
                <p id="discHotelPic">Meeting held by Pran Group</p>
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
        <div class="heading">
            <p>Running Events</p>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="upcming">
                    <asp:Panel runat="server" ID="curr_event_list">
                    </asp:Panel>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="heading">
            <p>Upcoming Events</p>
        </div>
        <asp:UpdatePanel ID="lginPanel" runat="server">
            <ContentTemplate>
                <div class="upcming">
                    <asp:Panel runat="server" ID="events_list">
                    </asp:Panel>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>

                <div class="heading">
            <p>Recent Held Events</p>
        </div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="upcming">
                    <asp:Panel runat="server" ID="past_events">
                    </asp:Panel>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <script type="text/javascript">
        document.getElementById("hotelpic_container").style.backgroundImage = "url('/images/events/hotelpic1.jpg')";
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
                imgSrc = "/images/events/hotelpic2.jpg";
                discription = "Contest held at 4-Apr-18 cast by Channel I";
            }
            else if (c == 2) {
                imgSrc = "/images/events/hotelpic3.jpg";
                discription = "Consert of ROCK OK @3-Apr-18";
            }
            else if (c == 3) {
                imgSrc = "/images/events/hotelpic4.jpg";
                discription = "Mirrage Event on 27th March 2018";
            }
            else if (c == 4) {
                imgSrc = "/images/events/hotelpic1.jpg";
                discription = "Meeting held by Pran Group";
            }
            document.getElementById("hotelpic_container").style.backgroundImage = "url('" + imgSrc + "')";
            document.getElementById("discHotelPic").innerHTML = discription;
        }
        setInterval(nextHotelPic, 3500);
    </script>
</asp:Content>
