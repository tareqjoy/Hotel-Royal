<%@ Page Title="" Language="C#" MasterPageFile="~/common.Master" AutoEventWireup="true" CodeBehind="location.aspx.cs" Inherits="Hotel_Royale.location.location" %>

<asp:Content ID="Content1" ContentPlaceHolderID="titel" runat="server">
    Hotel Royal | Location
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="location.css" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="uncommon" runat="server">
    <div  id="map">
    </div>
    <script>
        function initMap() {
            var uluru = { lat: 22.8456, lng: 89.5403 };
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 15,
                center: uluru
            });
            var marker = new google.maps.Marker({
                position: uluru,
                map: map
            });
        }
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaNCr7ucpmw5h6Jq4Yy70hVeegkS6yUaU&callback=initMap">
    </script>
</asp:Content>
