<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Skyscanner: Cheap Flights -- Compare Ticket Prices with Skyscanner.com</title>
    <meta name="keywords" content="Cheap Flights, Airline Tickets, Last Minute Flights, Airfare Comparison, Skyscanner"/>
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui-1.8.12.custom.min.js" type="text/javascript"></script>
    <script src="Scripts/flight.js" type="text/javascript"></script>
</head>

<body>
<div id="top">
<div style="float:left;margin-left:15px">Search: Flights | <a href="#">Hotels</a> | <a href="#">Car Rental</a></div>
<div style="float:right;margin-right:15px">Welcome - Already a member? [ <a href="login.aspx">Sign In</a> ] <a href="#">My Itineraries</a> | <a href="#">My Account</a> | <a href="#">Customer Support</a> | <a href="#">Feedback</a></div><br />
<div style="float:right;margin-right:150px;margin-top:20px">
<asp:Label ID="lblLoggedIn" runat="server"></asp:Label>
<a href="https://www.facebook.com/pages/Skyscanner/103791046326456"><img src="images/facebook.png" alt="Skyscanner on Facebook" /></a>&nbsp;&nbsp;
<a href="http://twitter.com/#!/skyscanner"><img src="images/twitter.png" alt="Skyscanner on Twitter" /></a>&nbsp;&nbsp;
<a href="#"><img src="images/flickr.png" alt="Skyscanner on Flickr" /></a>&nbsp;&nbsp;
<a href="#"><img src="images/rss.png" alt="Skyscanner RSS" /></a>
</div>
</div>

<div id="content">
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
    <div id="content2">
    <script src="Scripts/jquery-1.4.1-vsdoc.js" type="text/javascript"></script>
        <script src="Scripts/jquery-1.6.1.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(function () {
                $("#<%=ddlDepartureLocation.ClientID %>").change(function () {
                    $("#<%=From.ClientID %>").val($(this).val());
                });
                $("#<%=From.ClientID %>").focus();
            });
        </script>
        <script type="text/javascript">
            $(function () {
                $("#<%=ddlDestinationLocation.ClientID %>").change(function () {
                    $("#<%=To.ClientID %>").val($(this).val());
                });
                $("#<%=To.ClientID %>").focus();
            });
        </script>
        <table>
        <tr><td><img src="images/skyscanner_logo_plain.png" alt="Skyscanner Logo" /></td>
        <td><h1 style="color:Gray"><em>flight search</em></h1></td></tr></table>
        <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="MainPanel" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
        <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="900">
        <table><tr><td width="450" valign="top">
        <asp:RadioButtonList RepeatDirection="Horizontal" ID="rblTripType" runat="server">
        <asp:ListItem Text="Roundtrip" />
        <asp:ListItem Text="One way" />
        <asp:ListItem Text="Multiple destinations" />
        </asp:RadioButtonList></td>
        <td width="200" valign="top"><asp:Label ID="airlineLbl" runat="server" Text="Airline:" Font-Names="Tahoma" Font-Size="Larger"></asp:Label>
        <asp:DropDownList ID="ddlAirline" runat="server"></asp:DropDownList>
        </td>
        </tr>        
        <tr>
        <td width="450" valign="top">            
            <asp:Label ID="lblFrom" runat="server" Text="From:" Font-Names="Tahoma" Font-Size="Larger"></asp:Label>
            <asp:Label ID="lblDepLoc" runat="server" Text="type or select from list" Font-Size="XX-Small"></asp:Label><br />
            <asp:DropDownList ID="ddlDepartureLocation" runat="server"></asp:DropDownList>
            <br />
            <asp:Panel ID="pnlFrom" runat="server">            
            <asp:UpdatePanel ID="updpnlFrom" runat="server">
            <ContentTemplate>
            <asp:TextBox ID="From" runat="server" Width="260"></asp:TextBox>            
	        <asp:AutoCompleteExtender ID="AutoCompleteExtender1" ServiceMethod="GetItemsList" ServicePath="Autocomplete.asmx" runat="server" TargetControlID="From" MinimumPrefixLength="1" CompletionSetCount="15" CompletionInterval="50" EnableCaching="true">
            </asp:AutoCompleteExtender>
            </ContentTemplate>
            </asp:UpdatePanel>
            </asp:Panel>        
        </td>
        <td width="450" valign="top">
            <asp:Label ID="lblTo" runat="server" Text="To:" Font-Names="Tahoma" Font-Size="Larger"></asp:Label> 
            <asp:HyperLink ID="mapLink" runat="server" NavigateUrl="#" Font-Size="Smaller">map</asp:HyperLink> | <asp:Label ID="lblArrCity" runat="server" Text="type or select from list" Font-Size="XX-Small"></asp:Label>   
            <asp:DropDownList ID="ddlDestinationLocation" runat="server"></asp:DropDownList><br />
            <asp:Panel ID="pnlTo" runat="server">            
            <asp:UpdatePanel ID="updpnlTo" runat="server">
            <ContentTemplate>            
            <asp:TextBox ID="To" runat="server" Width="390"></asp:TextBox>
            <asp:AutoCompleteExtender ID="AutoCompleteExtender2" ServiceMethod="GetItemsList" ServicePath="Autocomplete.asmx" runat="server" TargetControlID="To" MinimumPrefixLength="1" CompletionSetCount="15" CompletionInterval="50" EnableCaching="true">
            </asp:AutoCompleteExtender>
            </ContentTemplate>
            </asp:UpdatePanel>
            </asp:Panel>
        </td>
        </tr>        
        <tr>
        <td>
        <asp:Label ID="DepartureLabel" runat="server" Text="Depart:" Font-Size="Larger" Font-Names="Tahoma" />
        <asp:TextBox ID="DepartureDateTextbox" runat="server" Text="mm/dd/yyyy"></asp:TextBox>
        <asp:ImageButton runat="Server" ID="calImg1" ImageUrl="~/images/Calendar-scheduleHS.png"
         AlternateText="Click to show calendar" />        
        <asp:CalendarExtender ID="CalendarExtender1" runat="server" OnClientDateSelectionChanged="checkDate" TargetControlID="DepartureDateTextbox" CssClass="MyCalendar" Format="MM/dd/yyyy" PopupButtonID="calImg1"></asp:CalendarExtender>
        <asp:DropDownList ID="ddlDepartureTime" runat="server"></asp:DropDownList>
        </td>
        <td>
        <asp:Label ID="Return" runat="server" Text="Return:" Font-Size="Larger" Font-Names="Tahoma" />   
        <asp:TextBox ID="ReturnDateTextbox" runat="server" Text="mm/dd/yyyy"></asp:TextBox>
        <asp:ImageButton runat="Server" ID="calImg2" ImageUrl="~/images/Calendar-scheduleHS.png"
         AlternateText="Click to show calendar" />        
        <asp:CalendarExtender ID="CalendarExtender2" runat="server" OnClientDateSelectionChanged="checkDate" TargetControlID="ReturnDateTextbox" CssClass="MyCalendar" Format="MM/dd/yyyy" PopupButtonID="calImg2"></asp:CalendarExtender>
        <asp:DropDownList ID="ddlReturnTime" runat="server"></asp:DropDownList>
        <asp:CompareValidator ID="dateCompare" runat="server" Type="Date" ControlToValidate="ReturnDateTextbox" ControlToCompare="DepartureDateTextbox" Operator="GreaterThan" ErrorMessage="Return Date must be greater than Departure Date" CssClass="ValidationError"></asp:CompareValidator>
        <asp:ValidatorCalloutExtender runat="server" TargetControlID="dateCompare"></asp:ValidatorCalloutExtender>
        </td>        
        </tr>        
        </table>
        <asp:CheckBox ID="Flexible" Text="<i>My dates are flexible (popular US routes only)</i>" runat="server" /><br />
        <table>
        <tr><td width="100">        
        <asp:Label ID="Travelers" Text="Travelers" runat="server" /><br />
        <asp:DropDownList ID="ddlTravelers" runat="server"></asp:DropDownList>
        </td>
        <td width="150">
            <asp:Label ID="lblCabin" runat="server" Text="Cabin"></asp:Label><br />
            <asp:DropDownList ID="ddlCabin" runat="server">
            <asp:ListItem>Economy</asp:ListItem>
            <asp:ListItem>Premium Economy</asp:ListItem>
            <asp:ListItem>Business</asp:ListItem>
            <asp:ListItem>First Class</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td width="150">
        <asp:CheckBox ID="Nonstop" runat="server" Text="Prefer Nonstop" />
        </td>
        <td style="float:left;margin-right:15%"><asp:ImageButton ID="ibSearch" runat="server" Width="140px" imageurl="~/images/search1.png" borderwidth="0" OnClick="ibSearch_Click" /></td>        
        </tr></table>
        </asp:Panel>
    </div>
    </form>
 </div>
<div id="footer">
<a href="#">Cities</a> | <a href="#">Airports</a> | <a href="#">Countries</a> | <a href="#">Airlines</a> | <a href="#">About Skyscanner</a> | <a href="#">FAQ</a> | <a href="#">News</a> | <a href="#">Mobile</a> | <a href="#">Jobs</a> | <a href="#">Contact Us</a> | <a href="#">Add Skyscanner to your site</a> | <a href="#">Privacy Policy</a>
<br />Cheap flights, Compare Airline Tickets with Skyscanner USA<br />
&copy; Skyscanner 2011. All rights reserved.</div>
</body>
</html>