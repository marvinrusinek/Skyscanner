<%@ Page Language="C#" AutoEventWireup="true" CodeFile="order_complete.aspx.cs" Inherits="order_complete" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skyscanner.com -- Order Complete!</title>
    <meta name="keywords" content="Cheap Flights, Airline Tickets, Last Minute Flights, Airfare Comparison, Skyscanner" />
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div id="top">
<div style="float:left;margin-left:15px"><a href="index.aspx"><img src="images/skyscanner_logo_plain.png" alt="Skyscanner Logo"/></a><br />Search: Flights | <a href="#">Hotels</a> | <a href="#">Car Rental</a></div>
<div style="float:right;margin-right:15px">Welcome - Already a member? [ <a href="login.aspx">Sign In</a> ] <a href="#">My Itineraries</a> | <a href="#">My Account</a> | <a href="#">Customer Support</a> | <a href="#">Feedback</a></div>
</div>

    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:Label ID="lblConnect" runat="server"></asp:Label>

    <div id="centerconf">
    <h2 style="color:blue">Skyscanner Purchase Confirmation</h2>
    Thank you for using skyscanner.com to purchase your ticket.<br /> We appreciate your patronage.</div>    
    <div style="margin-left:30%;margin-top:50px">
    <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="MainPanel" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
    <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="680" Height="650">
    <div style="margin:10px 0px 10px 10px">

    <asp:GridView ID="gvConfNum" runat="server" AutoGenerateColumns="false" GridLines="None" HeaderStyle-Font-Bold="true" DataSourceID="conDataSource" Width="640">
    <Columns>                
        <asp:BoundField DataField="lname" HeaderText="Last Name" ReadOnly="True" SortExpression="lname" />            
        <asp:BoundField DataField="fname" HeaderText="First Name" ReadOnly="True" SortExpression="fname" />            
        <asp:BoundField DataField="confnum" ControlStyle-Font-Bold="true" HeaderText="Confirmation Number" ReadOnly="True" SortExpression="confnum" />
        <asp:BoundField DataField="meal" HeaderText="Meal" ReadOnly="True" SortExpression="meal" />        
        <asp:BoundField DataField="assistance" HeaderText="Disability Assistance" ReadOnly="True" SortExpression="assistance" />
    </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="conDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString %>" SelectCommand="SELECT flightpreferences.lname, flightpreferences.fname, flightconfirmation.confnum, flightpreferences.meal, flightpreferences.assistance FROM flightpreferences FULL JOIN flightconfirmation ON flightpreferences.id=flightconfirmation.id ORDER BY flightpreferences.lname"> 
    </asp:SqlDataSource>
    
    <h2>Air Itinerary</h2>
    <asp:GridView ID="gvItineraryDepart" runat="server" DataSourceID="conDataSource2" GridLines="None" AutoGenerateColumns="false" Width="640">
    <Columns>
        <asp:BoundField DataField="flightnum" HeaderText="Flight Number" ReadOnly="True" SortExpression="flightnum" />
        <asp:BoundField DataField="airline" HeaderText="Airline" ReadOnly="True" SortExpression="airline" />
        <asp:BoundField DataField="departdate" HeaderText="Depart Date" ReadOnly="True" SortExpression="departdate" />             <asp:BoundField DataField="departtime" HeaderText="Depart Time" ReadOnly="True" SortExpression="departtime" />
        <asp:BoundField DataField="returndate" HeaderText="Return Date" ReadOnly="True" SortExpression="returndate" />     
        <asp:BoundField DataField="returntime" HeaderText="Return Time" ReadOnly="True" SortExpression="returntime" />
        <asp:BoundField DataField="cabintype" HeaderText="Cabin" ReadOnly="True" SortExpression="cabintype" />
        <asp:BoundField DataField="price" HeaderText="Total" ReadOnly="True" SortExpression="price" />   
    </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="conDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString %>" SelectCommand="SELECT flightnum, airline, departdate, departtime, returndate, returntime, cabintype, price FROM flightinfo"></asp:SqlDataSource>
    
    <h2>Billing Information</h2>
    <asp:Label ID="lblCCHolderName" runat="server" Text="Credit Card Holder Name:" Font-Names="Tahoma" Font-Bold="true" />
    <asp:GridView ID="gvCCHolder" runat="server" DataSourceID="conDataSource3" GridLines="None" ShowHeader="false"></asp:GridView>
    <asp:SqlDataSource ID="conDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString %>" SelectCommand="SELECT ccholdername FROM flightorder"></asp:SqlDataSource><br />
    
    <asp:Label ID="lblBillingAddr" runat="server" Text="Billing Address:" Font-Names="Tahoma" Font-Bold="true" />
    <asp:GridView ID="gvStreetAddr" runat="server" DataSourceID="conDataSource4" GridLines="None" ShowHeader="false"></asp:GridView>
    <asp:SqlDataSource ID="conDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString 
%>" SelectCommand="SELECT streetaddr, city, state, zipcode, country FROM flightorder"></asp:SqlDataSource><br />
    
    <asp:Label ID="lblConfirmationNumber" runat="server" Text="Confirmation Number:" Font-Names="Tahoma" Font-Bold="true" />
    <asp:GridView ID="gvConfirmationNumber" runat="server" DataSourceID="conDataSource5" GridLines="None" ShowHeader="false"></asp:GridView>
    <asp:SqlDataSource ID="conDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString 
%>" SelectCommand="SELECT confnum FROM flightconfirmation"></asp:SqlDataSource><br />

    <asp:Label ID="lblPayment" runat="server" Text="Form of Payment:" Font-Names="Tahoma" Font-Bold="true" />
    <asp:GridView ID="gvPayment" runat="server" DataSourceID="conDataSource6" GridLines="None" ShowHeader="false"></asp:GridView>
    <asp:SqlDataSource ID="conDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString 
%>" SelectCommand="SELECT cctype, ccnumber FROM flightorder"></asp:SqlDataSource><br />

    <asp:Label ID="lblPrice" runat="server" Text="Total Price:" Font-Names="Tahoma" Font-Bold="true" />
    <asp:GridView ID="gvPrice" runat="server" DataSourceID="conDataSource7" GridLines="None" ShowHeader="false"></asp:GridView>
    <asp:SqlDataSource ID="conDataSource7" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString 
%>" SelectCommand="SELECT totalprice FROM flightorder"></asp:SqlDataSource><br />

    <asp:ImageButton ID="bookanotherflight" runat="server" ImageUrl="images/book_another_flight_btn.png" AlternateText="Book Another Flight" OnClick="bookAnotherFlightBtn_Click" />
    <asp:ImageButton ID="reservecar" runat="server" ImageUrl="images/reserve_car_btn.png" AlternateText="Reserve a Car" />
    <asp:ImageButton ID="reservehotel" runat="server" ImageUrl="images/reserve_hotel_btn.png" AlternateText="Reserve a Hotel" />
    </div>
    </asp:Panel>
    </div>
    </form>
</body>
</html>