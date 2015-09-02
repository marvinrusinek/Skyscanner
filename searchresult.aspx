<%@ Page Language="C#" AutoEventWireup="true" CodeFile="searchresult.aspx.cs" Inherits="searchresult" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cheap Flights, Airline Tickets, Cheap Airfare and Discount Travel Deals - Skyscanner.com</title>
    <meta name="keywords" content="Cheap Flights, Airline Tickets, Last Minute Flights, Airfare Comparison, Skyscanner"/>
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/flight.js" type="text/javascript"></script>
</head>
<body>
<div id="top">
<div style="float:left;margin-left:15px"><a href="index.aspx"><img src="images/skyscanner_logo_plain.png" alt="Skyscanner Logo"/></a><br />Search: Flights | <a href="#">Hotels</a> | <a href="#">Car Rental</a></div>
<div style="float:right;margin-right:15px">Welcome - Already a member? [ <a href="login.aspx">Sign In</a> ] <a href="#">My Itineraries</a> | <a href="#">My Account</a> | <a href="#">Customer Support</a> | <a href="#">Feedback</a></div>
</div>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
    
    <div id="newsearch">
    <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="Panel2" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
    <asp:Panel ID="Panel2" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="170" Height="380">
    <div style="margin-left:10px">
    <h2 style="color:Blue">New Flight Search</h2>
    <a href="index.aspx"><< Start search over</a><br />
        <asp:Label ID="lblDepLoc" runat="server" Text="Leaving from:"></asp:Label><br />
        <asp:Panel ID="pnlFrom" runat="server">            
        <asp:UpdatePanel ID="updpnlFrom" runat="server">
            <ContentTemplate>
                <asp:TextBox ID="txtDepLoc" runat="server"></asp:TextBox><br />
        	    <asp:AutoCompleteExtender ID="AutoCompleteExtender1" ServiceMethod="GetItemsList" ServicePath="Autocomplete.asmx" runat="server" TargetControlID="txtDepLoc" MinimumPrefixLength="2" CompletionSetCount="15" CompletionInterval="50" EnableCaching="false">
                </asp:AutoCompleteExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>        

        <asp:Label ID="lblDestLoc" runat="server" Text="Going to:"></asp:Label><br />
        <asp:Panel ID="pnlTo" runat="server">            
        <asp:UpdatePanel ID="updpnlTo" runat="server">
            <ContentTemplate>
                <asp:TextBox ID="txtDestLoc" runat="server"></asp:TextBox><br />
                <asp:AutoCompleteExtender ID="AutoCompleteExtender2" ServiceMethod="GetItemsList" ServicePath="Autocomplete.asmx" runat="server" TargetControlID="txtDestLoc" MinimumPrefixLength="2" CompletionSetCount="15" CompletionInterval="50" EnableCaching="false">
                </asp:AutoCompleteExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:Panel>        
        
        <asp:Label ID="lblDepartDate" runat="server" Text="Departing:"></asp:Label>
        <asp:TextBox ID="txtDepartDate" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="CalendarExtender1" runat="server" OnClientDateSelectionChanged="checkDate" TargetControlID="txtDepartDate" CssClass="MyCalendar" Format="MM/dd/yyyy"></asp:CalendarExtender>
        <asp:DropDownList ID="ddlDepartTime" runat="server"></asp:DropDownList><br />
        <asp:Label ID="lblReturnDate" runat="server" Text="Returning:"></asp:Label>
        <asp:TextBox ID="txtReturnDate" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="CalendarExtender2" runat="server" OnClientDateSelectionChanged="checkDate" TargetControlID="txtReturnDate" CssClass="MyCalendar" Format="MM/dd/yyyy"></asp:CalendarExtender>
        <asp:DropDownList ID="ddlReturnTime" runat="server"></asp:DropDownList><br />
        Who's going on this trip?<br />
        <asp:Label ID="lblNumberOfTravelers" runat="server" Text="Number of Travelers:"></asp:Label>
        <asp:DropDownList ID="ddlNumTravelers" runat="server"></asp:DropDownList><br />
        
        <a class="xp-l-right" href="javascript:void(0)" id="uw_flight_show_additional_link">Show additional options</a><br /><br />
        <asp:ImageButton ID="searchbtn" runat="server" ImageUrl="images/search_btn.jpg" AlternateText="Search button" OnClick="newsearchbtn_Click" />
    </div>
    </asp:Panel>
    </div>
    
    <!-- middle area of the page -->
    <div style="margin-left:16%;margin-top:60px">
    <asp:Label ID="lblFrom" runat="server" Font-Names="Tahoma" Font-Size="Large"></asp:Label> to <asp:Label ID="lblTo" runat="server" Font-Names="Tahoma" Font-Size="Large"></asp:Label><br />
    <asp:Label ID="lblDepartingDate" runat="server" Font-Names="Times" Font-Size="Medium"></asp:Label> -- <asp:Label ID="lblReturningDate" runat="server" Font-Names="Times" Font-Size="Medium"></asp:Label>, <asp:Label ID="lblNumTravelers" runat="server" Font-Names="Times" Font-Size="Medium"></asp:Label> travelers.
            
        <h2 style="color:Blue">Available Flights</h2>
        Choose your Flight: <asp:Label ID="lblFrom2" runat="server" Font-Names="Times" Font-Size="Small"></asp:Label> to <asp:Label ID="lblTo2" runat="server" Font-Names="Times" Font-Size="Small"></asp:Label><br />
        <asp:Label ID="lblNumResults" runat="server"></asp:Label> results, sort by: <asp:DropDownList ID="ddlSortBy" runat="server">
        <asp:ListItem runat="server" Text="Price per adult" Value="price" />
        <asp:ListItem runat="server" Text="Airline" Value="airline" />
        <asp:ListItem runat="server" Text="Depart: Take off" Value="departtime" />
        <asp:ListItem runat="server" Text="Depart: Landing" Value="arrivaltime" />
        <asp:ListItem runat="server" Text="Return: Landing" Value="returntime" />
        <asp:ListItem runat="server" Text="Total journey time" Value="duration" />
        </asp:DropDownList>
        <asp:GridView ID="gvAvailableFlights" runat="server" RowStyle-Height="50" HeaderStyle-Font-Bold="true" CellPadding="4" ForeColor="#333333"
        GridLines="None" Font-Names="Tahoma" Font-Size="XX-Small" AutoGenerateColumns="false" AllowSorting="true" OnRowCommand="GridView1_RowCommand" Width="500"> 
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
            <EditRowStyle BackColor="#999999" />
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <HeaderStyle Font-Bold="True" BackColor="#5D7B9D" ForeColor="White"></HeaderStyle>
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#E9E7E2" />
            <SortedAscendingHeaderStyle BackColor="#506C8C" />
            <SortedDescendingCellStyle BackColor="#FFFDF8" />
            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            <Columns>                
            <asp:BoundField DataField="ImagePath" Visible="false" />
            <asp:ImageField DataImageUrlField="ImagePath" DataImageUrlFormatString="{0}" AlternateText="Airline Image" />
            <asp:BoundField DataField="FlightNumber"  HeaderText="Flight" ReadOnly="True" SortExpression="FlightNumber" /> 
            <asp:BoundField DataField="Airline" HeaderText="Airline" ReadOnly="True" SortExpression="Airline" />
            <asp:BoundField DataField="Departure" HeaderText="Departure Airport" ReadOnly="True" SortExpression="Departure" />
            <asp:BoundField DataField="DepartureDate" HeaderText="Departure Date" ReadOnly="True" SortExpression="Departure Date" />
            <asp:BoundField DataField="DepartureTime" HeaderText="Departure Time" ReadOnly="True" SortExpression="DepartureTime" />
            <asp:BoundField DataField="Destination" HeaderText="Destination Airport" ReadOnly="True" SortExpression="Destination" />
            <asp:BoundField DataField="ArrivalDate" HeaderText="ArrivalDate" ReadOnly="true" SortExpression="ArrivalDate" />
            <asp:BoundField DataField="ArrivalTime" HeaderText="Arrival Time" ReadOnly="True" SortExpression="ArrivalTime" />
            <asp:BoundField DataField="Stops" HeaderText="Stops" ReadOnly="True" SortExpression="Stops" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" ReadOnly="True" SortExpression="Duration" />
            <asp:BoundField DataField="ReturnDate" HeaderText="Return Date" ReadOnly="True" SortExpression="ReturnDate" />
            <asp:BoundField DataField="ReturnTime" HeaderText="Return Time" ReadOnly="True" SortExpression="ReturnTime" />
            <asp:BoundField DataField="Cabin" HeaderText="Cabin" ReadOnly="True" SortExpression="Cabin" />
            <asp:BoundField DataField="Price" HeaderText="Price" ReadOnly="True" SortExpression="Price" />            
            <asp:ButtonField ButtonType="Image" ImageUrl="images/book_btn.png" runat="server" CommandName="select" />
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
