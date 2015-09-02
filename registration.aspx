<%@ Page Language="C#" AutoEventWireup="true" CodeFile="registration.aspx.cs" Inherits="regtest" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CustomCaptcha" Namespace="CustomCaptcha" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Skyscanner.com Registration Form</title>
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
    <div style="margin-left:30%;margin-top:40px;">
    <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="MainPanel" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
    <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="525" Height="635">
        <div style="margin-left:10px;margin-top:10px">
        <h2 style="color:Blue;text-align:center">Registration</h2>
        <table width="500" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="150"><asp:Label ID="lblFirstname" runat="server" Font-Names="Tahoma" Text="First name:"></asp:Label></td>
            <td width="350"><asp:TextBox ID="txtFirstname" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFirstname" runat="server" ControlToValidate="txtFirstname" ErrorMessage="First name is required." ToolTip="First name is required." CssClass="ValidationError"></asp:RequiredFieldValidator>
            </td>
          </tr>
          <tr>
            <td width="150"><asp:Label ID="lblMiddlename" runat="server" Font-Names="Tahoma" Text="Middle name:"></asp:Label></td>
            <td width="350"><asp:TextBox ID="txtMiddlename" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvMiddlename" runat="server" ControlToValidate="txtMiddlename" ErrorMessage="Middle name is required." ToolTip="Middle name is required." CssClass="ValidationError"></asp:RequiredFieldValidator>
            </td>
          </tr>
          <tr>
            <td width="150"><asp:Label ID="lblLastname" runat="server" Font-Names="Tahoma" Text="Last name:"></asp:Label></td>
            <td width="350"><asp:TextBox ID="txtLastname" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLastname" runat="server" ControlToValidate="txtLastname" ErrorMessage="Last name is required." ToolTip="Last name is required." CssClass="ValidationError"></asp:RequiredFieldValidator>
            </td>
          </tr>
          <tr>
          <td width="150"></td>
          <td width="350" class="smtxt">Tip: Make sure the names match the traveler's passport or driver's license to avoid travel delays.</td></tr>
        </table>        
        <hr align="left" width="500" />
        <table width="500" border="0" cellpadding="0" cellspacing="0">
        <tr>
        <td width="150"><asp:Label ID="lblUsername" runat="server" Font-Names="Tahoma" Text="Username:"></asp:Label></td>
        <td width="350"><asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="ValidationError"></asp:RequiredFieldValidator>
        </td>
        </tr>
        <tr>
        <td width="150"><asp:Label ID="lblEmailAddress" runat="server" Font-Names="Tahoma" Text="Email address:"></asp:Label></td>
        <td width="350"><asp:TextBox ID="txtEmailAddr" runat="server"></asp:TextBox>
        <asp:RegularExpressionValidator ID="regEmail" ControlToValidate="txtEmailAddr" Text="Invalid email"
        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server" />         
        </td>
        </tr>
        <tr>
        <td width="150"></td>
        <td width="350"><asp:CheckBox ID="specialdeals" runat="server" /><div class="smtxt">Please send me Skyscanner emails with travel deals, special offers, and other information.</div></td>
        </tr>
        </table>
        <hr align="left" width="500" />
        <table width="500" border="0" cellpadding="0" cellspacing="0">
        <tr>
        <td width="150"></td>
        <td width="350" class="smtxt">Strong passwords are important protections to help you have safer online transactions. Wherever possible use letters, punctuation, symbols, and numbers to create strong passwords!</td>
        </tr>
        <tr>
        <td width="150"><asp:Label ID="lblPassword" runat="server" Font-Names="Tahoma" Text="Password:"></asp:Label></td>
        <td width="350"><asp:TextBox ID="txtPassword" TextMode="Password" MaxLength="30" runat="server"></asp:TextBox>
        <asp:PasswordStrength ID="PasswordStrength1" runat="server" TargetControlID="txtPassword" PrefixText="Password Strength: "></asp:PasswordStrength>
        <asp:RegularExpressionValidator ID="regPassword" runat="server" ControlToValidate="txtPassword" Text="Minimum password length is 6" ErrorMessage="Minimum password length is 6" ValidationExpression=".{6}.*" CssClass="ValidationError" />
        </td>
        </tr>
        <tr>
        <td width="150"></td>
        <td width="350" class="smtxt">(6-30 characters, no spaces)</td>
        </tr>
        <tr>
        <td width="150"><asp:Label ID="lblConfirmPassword" runat="server" Font-Names="Tahoma" Text="Re-type password:"></asp:Label></td>
        <td width="350"><asp:TextBox ID="txtConfirmPassword" TextMode="Password" MaxLength="30" runat="server"></asp:TextBox>
        <asp:RegularExpressionValidator ID="regConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" Text="Minimum password length is 6" ErrorMessage="Minimum password length is 6" ValidationExpression=".{6}.*" CssClass="ValidationError" />
        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match!" Text="Passwords do not match!" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword"></asp:CompareValidator>        
        </td>
        </tr>
        </table>
        <hr align="left" width="500" />
        <table width="500" border="0" cellpadding="0" cellspacing="0">
        <tr>
        <td width="150"></td>        
        <td width="350"><cc1:CaptchaControl ID="CaptchaControl1" runat="server" CaptchaLineNoise="Low" ToolTip="Captcha verification" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        </td>
        </tr> 
        <tr>
        <td width="50"></td>
        <td width="450"><asp:CheckBox ID="agree" runat="server" />I have read and agree to the <a href="#">Terms of Use</a> and the <a href="#">Privacy Policy</a>.</td>
        </tr>
        <tr>
        <td width="50"></td>
        <td width="450"><asp:ImageButton ID="ibRegister" runat="server" imageurl="images/register.png" borderwidth="0" OnClick="btnreg_Click" />
        <asp:Label ID="lblcaptcha" runat="server"></asp:Label>
        </td>
        </tr>
        </table>
        </div>
        </asp:Panel>
    </div>
    <asp:Label ID="lblConnect" runat="server"></asp:Label>
    </form>
</body>
</html>