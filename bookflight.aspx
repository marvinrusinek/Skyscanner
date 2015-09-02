<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bookflight.aspx.cs" Inherits="bookflight" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skyscanner.com - Book Flight</title>
    <meta name="keywords" content="Cheap Flights, Airline Tickets, Last Minute Flights, Airfare Comparison, Skyscanner"/>
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
        <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="525" Height="585">        
        <div style="margin:10px 0px 10px 10px">
        <h2 style="text-align:center;color:Blue">Edit traveler information</h2>
        <table><tr>
        <td width="160"><asp:Label ID="lblFirstname" runat="server" Text="First Name:"></asp:Label></td>
        <td><asp:TextBox ID="txtFirstname" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvFirstname" runat="server" ControlToValidate="txtFirstname" ErrorMessage="First name is required." ToolTip="First name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr>       
        <tr><td width="160"><asp:Label ID="lblMiddlename" runat="server" Text="Middle Name:"></asp:Label></td>
        <td><asp:TextBox ID="txtMiddlename" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvMiddlename" runat="server" ControlToValidate="txtMiddlename" ErrorMessage="Middle name is required." ToolTip="Middle name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr>
        <tr><td width="160"><asp:Label ID="lblLastname" runat="server" Text="Last Name:"></asp:Label></td>
        <td><asp:TextBox ID="txtLastname" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvLastname" runat="server" ControlToValidate="txtLastname" ErrorMessage="Last name is required." ToolTip="Last name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr>
        <tr><td width="160"><asp:Label ID="lblPhoneNumber" runat="server" Text="Contact Phone Number:"></asp:Label></td>
        <td><asp:TextBox ID="txtPhoneNumber" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number is required." ForeColor="Red">*</asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Invalid phone number" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" ForeColor="Red"></asp:RegularExpressionValidator>
        </td></tr>
        </table>
        <hr class="hrwidth" />        
        <strong>U.S. government required travel information for travel</strong><br />
        <table>
        <tr><td><asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>
        <asp:RadioButtonList ID="gender" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem runat="server">Male</asp:ListItem>
            <asp:ListItem runat="server">Female</asp:ListItem>
        </asp:RadioButtonList></td></tr>
        <tr><td><asp:Label ID="lblDOB" runat="server" Text="Date of Birth:"></asp:Label>
        <asp:DropDownList ID="ddlDOBMonth" runat="server"></asp:DropDownList>
        <asp:DropDownList ID="ddlDOBDay" runat="server"></asp:DropDownList>
        <asp:DropDownList ID="ddlDOBYear" runat="server"></asp:DropDownList></td>
        <td><img src="images/tip_icon.gif" alt="Tip icon" />&nbsp;<a href="#">Secure Flight FAQs</a>
        </td></tr></table>
        <hr class="hrwidth" />
        <strong>Preferences and Requests:</strong> (optional)<br />
        <asp:Label ID="lblSeat" runat="server" Text="Seat:"></asp:Label>
        <asp:RadioButtonList ID="rblSeat" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem runat="server">No preference</asp:ListItem>
            <asp:ListItem runat="server">Aisle</asp:ListItem>
            <asp:ListItem runat="server">Window</asp:ListItem>        
        </asp:RadioButtonList>
        <asp:Label ID="lblMeal" runat="server" Text="Meal:"></asp:Label>
        <asp:DropDownList ID="ddlMeals" runat="server"></asp:DropDownList><br />
        Free and special meals are not available on many flights.<br />
        <asp:Label ID="lblAssistance" runat="server" Text="Special Assistance:"></asp:Label>
        <asp:DropDownList ID="ddlAssistance" runat="server"></asp:DropDownList><br />
        Passengers that need special assistance should contact the airline directly.<br /><hr class="hrwidth" />
        <strong>Emergency Contact:</strong> (optional)<br />
        <table>
        <tr><td><asp:Label ID="lblEmergencyFirstname" runat="server" Text="First Name:"></asp:Label></td>
        <td><asp:TextBox ID="txtEmergencyFirstname" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEmergencyFirstname" runat="server" ControlToValidate="txtEmergencyFirstname" ErrorMessage="First name is required." ToolTip="First name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr>
        <tr><td><asp:Label ID="lblEmergencyLastname" runat="server" Text="Last Name:"></asp:Label></td>
        <td><asp:TextBox ID="txtEmergencyLastname" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEmergencyLastname" runat="server" ControlToValidate="txtEmergencyLastname" ErrorMessage="Last name is required." ToolTip="Last name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr>
        <tr><td><asp:Label ID="lblEmergencyPhoneNumber" runat="server" Text="Phone Number:"></asp:Label></td>
        <td><asp:TextBox ID="txtEmergencyPhoneNumber" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvEmergencyPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number is required." ForeColor="Red">*</asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="revEmergencyPhoneNumber" runat="server" ControlToValidate="txtEmergencyPhoneNumber" ErrorMessage="Invalid phone number" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" ForeColor="Red"></asp:RegularExpressionValidator>
        </td></tr>
        </table>
        <asp:ImageButton ID="checkoutbtn" runat="server" ImageUrl="images/btn_continue_checkout.png" AlternateText="Continue Checkout" OnClick="btnCheckout_Click" ImageAlign="Right" /><br />
        <a href="#">Cancel</a>
        </div>
        </asp:Panel>
    </div>
    </form>
    <asp:Label ID="lblConnect" runat="server"></asp:Label>
</body>
</html>