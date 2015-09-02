<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skyscanner.com Login Page</title>
    <meta name="keywords" content="Cheap Flights, Airline Tickets, Last Minute Flights, Airfare Comparison, Skyscanner" />
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="top">
<div style="float:left;margin-left:15px"><a href="index.aspx"><img src="images/skyscanner_logo_plain.png" alt="Skyscanner Logo"/></a><br />Search: Flights | <a href="#">Hotels</a> | <a href="#">Car Rental</a></div>
<div style="float:right;margin-right:15px">Welcome - Already a member? [ <a href="login.aspx">Sign In</a> ] <a href="#">My Itineraries</a> | <a href="#">My Account</a> | <a href="#">Customer Support</a> | <a href="#">Feedback</a></div>
</div>
    <form id="form1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" />
    <div id="content3">
    <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="MainPanel" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
    <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="450">
    <div style="margin:10px 0px 10px 10px"></div>
    <h2 style="color:blue;text-align:center">Login</h2>
    <table style="width: 400px; height: 96px">
            <tr>
                <td style="width: 120px">
                    <asp:Label ID="lblUsername" runat="server" Text="Username:" Font-Names="Tahoma" Font-Bold="true"></asp:Label></td>
                <td style="width: 230px">
                    <asp:TextBox ID="txtUsername" runat="server" Width="200"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 120px">
                    <asp:Label ID="lblPassword" runat="server" Text="Password:" Font-Names="Tahoma" Font-Bold="true"></asp:Label></td>
                <td style="width: 230px">
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="200"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 120px"></td>
                <td style="width: 230px">
                    <asp:ImageButton ID="btnLogin" runat="server" ImageUrl="images/login_button.png" AlternateText="Login Button" onclick="btnLogin_Click"/></td>
            </tr>
            <tr>
                <td style="width: 120px">
                </td>
                <td style="width: 230px">Not a member? <a href="registration.aspx">Join now</a>.</td>
            </tr>
        </table>
        </div>
    </asp:Panel>
    </div>
    <asp:Label ID="lblReturn" runat="server" Width="400px"></asp:Label>
    </form>
<div id="footer">
<a href="#">Cities</a> | <a href="#">Airports</a> | <a href="#">Countries</a> | <a href="#">Airlines</a> | <a href="#">About Skyscanner</a> | <a href="#">FAQ</a> | <a href="#">News</a> | <a href="#">Mobile</a> | <a href="#">Jobs</a> | <a href="#">Contact Us</a> | <a href="#">Add Skyscanner to your site</a> | <a href="#">Privacy Policy</a>
<br />Cheap flights, Compare Airline Tickets with Skyscanner USA<br />
&copy; Skyscanner 2011. All rights reserved.</div>
</body>
</html>
