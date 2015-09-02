<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reviewflight.aspx.cs" Inherits="reviewflight2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Skyscanner.com -- Review Your Flight</title>
    <meta name="keywords" content="Cheap Flights, Airline Tickets, Last Minute Flights, Airfare Comparison, Skyscanner"/>
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="top">
<div style="float:left;margin-left:15px"><a href="index.aspx"><img src="images/skyscanner_logo_plain.png" alt="Skyscanner Logo"/></a><br />Search: Flights | <a href="#">Hotels</a> | <a href="#">Car Rental</a></div>
<div style="float:right;margin-right:15px">Welcome - Already a member? [ <a href="login.aspx">Sign In</a> ] <a href="#">My Itineraries</a> | <a href="#">My Account</a> | <a href="#">Customer Support</a> | <a href="#">Feedback</a></div>
</div>
    <form id="form1" runat="server">
    <div id="content3">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
        <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="MainPanel" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
        <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="525" Height="700">
        <div style="margin:10px 0px 10px 10px">        
        <h2 style="text-align:center;color:Blue">Review the flight details</h2>
        <asp:DetailsView ID="DetailsView1" DataKeyNames="FlightNumber" HorizontalAlign="Center"  
            DefaultMode="Edit" runat="server" AutoGenerateRows="False" Height="50px" 
            Width="400px" CellPadding="3" Font-Size="Smaller" BackColor="White" 
            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
            <EditRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <Fields>
                <asp:BoundField ReadOnly="true" HeaderText="Flight Number:" DataField="FlightNumber" SortExpression="FlightNumber" />
                <asp:BoundField ReadOnly="true" HeaderText="Airline:" DataField="Airline" SortExpression="Airline" />
                <asp:BoundField ReadOnly="true" HeaderText="Depart From:" DataField="DepartureLocation" SortExpression="DepartureLocation" />
                <asp:BoundField ReadOnly="true" HeaderText="Departure:" DataField="Departure" SortExpression="Departure" />
                <asp:BoundField ReadOnly="true" HeaderText="Departure Date:" DataField="DepartDate" SortExpression="DepartDate" />       
                <asp:BoundField ReadOnly="true" HeaderText="Departure Time:" DataField="DepartTime" SortExpression="DepartTime" />
                <asp:BoundField ReadOnly="true" HeaderText="Arrive At:" DataField="DestinationLocation" SortExpression="DepartureLocation" />
                <asp:BoundField ReadOnly="true" HeaderText="Destination:" DataField="Destination" SortExpression="Destination" />
                <asp:BoundField ReadOnly="true" HeaderText="Arrival Time:" DataField="ArrivalTime" SortExpression="ArrivalTime" />
                <asp:BoundField ReadOnly="true" HeaderText="Stops:" DataField="Stops" SortExpression="Stops" />                              <asp:BoundField ReadOnly="true" HeaderText="Duration:" DataField="Duration" SortExpression="Duration" /> 
                <asp:BoundField ReadOnly="true" HeaderText="Distance:" DataField="Distance" SortExpression="Distance" />                     <asp:BoundField ReadOnly="true" HeaderText="Return Date:" DataField="ReturnDate" SortExpression="ReturnDate" />
                <asp:BoundField ReadOnly="true" HeaderText="Return Time:" DataField="ReturnTime" SortExpression="ReturnTime" />
                <asp:BoundField ReadOnly="true" HeaderText="Cabin:" DataField="Cabin" SortExpression="Cabin" />         
                <asp:BoundField ReadOnly="true" HeaderText="Price:" DataField="Price" SortExpression="Price" />                          </Fields>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
        </asp:DetailsView>

        <h2 style="color:Blue">Review the rules and restrictions</h2>
        Tickets are nonrefundable.<br />
    Tickets are nontransferable and name changes are not allowed.<br />
    Please read important information regarding <a href="#">airline liability limitations</a>.<br />
    Prices do not include <a href="#">baggage fees or other fees</a> charged directly by the airline.<br />
    Read an overview of all the <a href=#">rules and restrictions</a> applicable to this fare.<br />
    Read the complete <a href="#">penalty rules for changes and cancellations</a> applicable to this fare.<br />
        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/btn_checkout.gif" OnClick="btnCheckout_Click" ImageAlign="Right" /><br />
        <a href="javascript: history.go(-1)">Back to your flight search results</a>
        </div>
    </asp:Panel>
    </div>
    </form>
</body>
</html>
