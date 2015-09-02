<%@ Page Language="C#" AutoEventWireup="true" CodeFile="checkout.aspx.cs" Inherits="checkout" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Skyscanner.com -- Trip Summary and Payment Method</title>
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
    <asp:Label ID="lblConnect" runat="server"></asp:Label>
    <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" TargetControlID="MainPanel" BorderColor="blue" Radius="6" Corners="All"></asp:RoundedCornersExtender>
    <asp:Panel ID="MainPanel" BackColor="Transparent" runat="server" BorderWidth="5" BorderStyle="Solid" BorderColor="blue" Width="625" Height="1650">        
    
    <div style="margin:10px 0px 10px 10px">
    <h2 style="color:Blue">Trip Summary</h2>
    From <asp:Label ID="lblStartDate" runat="server" /> to <asp:Label ID="lblEndDate" runat="server" /><br />
    Flight: <asp:Label ID="lblNumOfTravelers" runat="server" /> <asp:Label ID="lblTripType" runat="server" /> <asp:Label ID="lblTickets" runat="server" /> - 
    <asp:Label ID="lblDepartureLocation" runat="server" /> to <asp:Label ID="lblArrivalLocation" runat="server" /><br />
    Traveler: <asp:Label ID="lblTraveler" runat="server" /><br /> (<a href="#">Change traveler information</a>)<br /><br />
    <table>
    <tr><td width="180">Skyscanner Booking Fee:</td><td>$0.00</td></tr>
    <tr><td width="180">Flight:</td><td><asp:Label ID="lblFlightPrice" runat="server"></asp:Label></td></tr>
    <tr><td width="180">Taxes and Fees:</td><td><asp:Label ID="lblTaxFees" runat="server"></asp:Label></td></tr>        
    </table>
    <hr class="hrwidth3" />
    <table>
    <tr><td width="180">Total Price:</td><td><asp:Label ID="lblTotalPrice" runat="server"></asp:Label></td></tr>
    </table>
    <hr class="hrwidth2" />
    <h2 style="color:Blue">Payment Method</h2>
<img src="images/mastercard.gif" alt="Mastercard" /><img src="images/visa.gif" alt="Visa" /><img src="images/discover.gif" alt="Visa" /><img src="images/amex.gif" alt="Amex" /><img src="images/diners_club.gif" alt="Diners Club" />
        <table>
        <tr><td width="150"><asp:Label ID="lblCCNumber" runat="server" Text="Card Number:"></asp:Label></td>
        <td><asp:TextBox ID="txtCCNumber" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvCCNumber" runat="server" ControlToValidate="txtCCNumber" ErrorMessage="Credit Card Number is a required field." ForeColor="Red">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revCreditCardNum1" runat="server" ControlToValidate="txtCCNumber" ValidationExpression="\d+" ValidationGroup="CheckoutGroup" Text="Card Number must contain only numbers" ErrorMessage="Card Number must contain only numbers" ForeColor="Red"></asp:RegularExpressionValidator>
            <asp:RegularExpressionValidator ID="revCreditCardNum2" runat="server" ControlToValidate="txtCCNumber" ValidationExpression="^(3[47][0-9]{13}|5[1-5][0-9]{14}|4[0-9]{12}(?:[0-9]{3})?)$" ValidationGroup="CheckoutGroup" Text="Card Number must be 16 digits" ErrorMessage="Card Number must be 16 digits" ForeColor="Red"></asp:RegularExpressionValidator>
        </td></tr>
        <tr><td width="150"><asp:Label ID="lblCardType" runat="server" Text="Card Type:"></asp:Label></td>
        <td><asp:DropDownList ID="ddlCardType" runat="server">
        <asp:ListItem Text="--Select Card Type--"></asp:ListItem>
        <asp:ListItem Text="American Express"></asp:ListItem>
        <asp:ListItem Text="Diners Club International"></asp:ListItem>
        <asp:ListItem Text="Discover Network"></asp:ListItem>
        <asp:ListItem Text="Mastercard"></asp:ListItem>
        <asp:ListItem Text="Visa"></asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="rfvCreditCard" runat="server" ErrorMessage="Credit Card type is missing" ControlToValidate="ddlCardType" Display="Dynamic" ForeColor="Red">*</asp:RequiredFieldValidator>
        </td></tr>
        <tr><td width="150"></td><td><img src="images/tip_icon.gif" alt="Tip Icon" />&nbsp;<a href="#">Don't see your card type?</a></td></tr>
        <tr><td width="150"><asp:Label ID="lblExpDate" runat="server" Text="Expiration date:"></asp:Label></td>
        <td><asp:DropDownList ID="ddlMonths" runat="server"></asp:DropDownList>
        <asp:DropDownList ID="ddlYears" runat="server"></asp:DropDownList></td></tr>
        <tr><td width="150"><asp:Label ID="lblSecurityCode" runat="server" Text="Card Identification Number:"></asp:Label></td>
        <td><asp:TextBox ID="txtSecurityCode" runat="server" Width="50"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvSecurityCode" runat="server" ControlToValidate="txtSecurityCode" Display="Dynamic" ErrorMessage="Security Code is a required field." ForeColor="Red">*</asp:RequiredFieldValidator>
         <asp:RegularExpressionValidator ID="revSecurityCode" runat="server" ControlToValidate="txtSecurityCode"  ValidationExpression="^\d{3}$" ValidationGroup="CheckoutGroup" Text="Invalid security code" ErrorMessage="Invalid security code" ForeColor="Red"></asp:RegularExpressionValidator>
        </td></tr>
        <tr><td width="150"></td><td><img src="images/tip_icon.gif" alt="Tip Icon" />&nbsp;<a href="#">What's this?</a></td></tr>
        </table>
        <hr class="hrwidth2" /><br />
        <strong>Cardholder name (as it appears on the card)</strong><br />
        <table><tr>
        <td width="150"><asp:Label ID="lblFirstname" runat="server" Text="First Name:"></asp:Label></td>
        <td width="150"><asp:TextBox ID="txtFirstname" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvFirstname" runat="server" ControlToValidate="txtFirstname" ErrorMessage="First name is required." ToolTip="First name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr>
        <tr><td width="150"><asp:Label ID="lblLastname" runat="server" Text="Last Name:"></asp:Label></td>
        <td width="150"><asp:TextBox ID="txtLastname" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvLastname" runat="server" ControlToValidate="txtLastname" ErrorMessage="Last name is required." ToolTip="Last name is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td></tr></table>
        <strong>Primary billing address</strong><br />
        Please supply the cardholder's billing address as listed on the credit/debit card statement.<br />
        <table>
        <tr><td><asp:Label ID="lblStreet" runat="server" Text="Street:"></asp:Label></td>
        <td width="150"><asp:TextBox ID="txtStreet" runat="server"></asp:TextBox>
       <asp:RequiredFieldValidator ID="rfvStreet" runat="server" ControlToValidate="txtStreet" ErrorMessage="Street address is required." ForeColor="Red"></asp:RequiredFieldValidator>
        </td>
        <td><asp:Label ID="lblSuiteApt" runat="server" Text="Suite or Apt.:"></asp:Label></td>
        <td><asp:TextBox ID="txtSuiteApt" runat="server" Width="50"></asp:TextBox></td></tr>
        <tr><td><asp:Label ID="lblCity" runat="server" Text="City:"></asp:Label></td>
        <td width="150"><asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="City is required." ForeColor="Red">*</asp:RequiredFieldValidator>
        </td>
        <td><asp:Label ID="lblState" runat="server" Text="State:"></asp:Label></td>
        <td><asp:DropDownList ID="ddlStates" runat="server"></asp:DropDownList></td>
        <td><asp:Label ID="lblZipCode" runat="server" Text="Zip Code:"></asp:Label></td>
        <td><asp:TextBox ID="txtZipCode" runat="server" Width="100"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvZipCode" runat="server" ControlToValidate="txtZipCode" ErrorMessage="Zip Code is required." ForeColor="Red">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revZipCode" runat="server" ErrorMessage="Invalid zip code" ForeColor="Red" ControlToValidate="txtZipCode" ValidationExpression="^(\d{5}-\d{4}|\d{5}|\d{9})$|^([a-zA-Z]\d[a-zA-Z] \d[a-zA-Z]\d)$"></asp:RegularExpressionValidator>
        </td></tr>
        <tr><td><asp:Label ID="lblCountry" runat="server" Text="Country:"></asp:Label></td>
        <td><asp:DropDownList ID="ddlCountries" runat="server"></asp:DropDownList>
        </td></tr>
        <tr><td><asp:Label ID="lblPhoneNumber" runat="server" Text="Phone Number:"></asp:Label></td>
        <td><asp:TextBox ID="txtPhoneNumber" runat="server"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Phone Number is required." ForeColor="Red">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Invalid phone number" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" ForeColor="Red"></asp:RegularExpressionValidator>
        </td></tr>
        </table>
        <hr class="hrwidth2" />
        <h2 style="color:Blue">Ticket Delivery &amp; Verify Email Address</h2>
        We'll send your e-ticket confirmation and all other correspondence, including your itinerary and any updates to this email address.
        <asp:GridView ID="GridView1" runat="server" DataSourceID="conDataSource1" GridLines="None" ShowHeader="false"></asp:GridView> (<a href="#">edit email address</a>) 
        <asp:SqlDataSource ID="conDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FlightDBConnectionString %>" SelectCommand="SELECT email FROM flightuserlogininfo"></asp:SqlDataSource>
        <hr class="hrwidth2" />
        <h2 style="color:Blue">Rules &amp; Restrictions</h2>
        <strong>Flight Rules and Restrictions</strong><br />
    Tickets are nonrefundable. A fee of $250.00 per ticket will be charged for itinerary changes after the tickets are issued, provided that the booking rules were followed.<br />
    Tickets are nontransferable and name changes are not allowed.<br />
    Please read important information regarding <a href="#">airline liability limitations</a>.<br />
    Prices do not include <a href="#">baggage fees or other fees</a> charged directly by the airline.<br />
    See an overview of all the <a href="#">rules and restrictions</a> applicable for this fare.<br />
    View the complete <a href="#">penalty rules for changes and cancellations</a> associated with this fare.<br /><br />
    This total includes selected items, taxes, and service fees. Unless specified otherwise, rates are quoted in USD. Please note: There is no booking fee associated with this flight; however, mandatory government and/or airport taxes and fees may apply.
    The total cost of your trip may be listed as separate charges on your credit card statement. All fees are nonrefundable.<br /><br />
    <table>
    <tr><td width="180">Skyscanner Booking Fee:</td><td>$0.00</td></tr>
    <tr><td width="180">Flight:</td><td><asp:Label ID="lblFlightPrice2" runat="server"></asp:Label></td></tr>
    <tr><td width="180">Taxes and Fees:</td><td><asp:Label ID="lblTaxFees2" runat="server"></asp:Label></td></tr>        
    </table>
    <hr class="hrwidth3" />
    <table>
    <tr><td width="180">Total Price:</td><td><asp:Label ID="lblTotalPrice2" runat="server"></asp:Label></td></tr>
    </table>

<br /><br />
     <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="images/button_bookaflight.png" AlternateText="Complete Booking" OnClick="btnBookFlight_Click" ImageAlign="Right" />
    </div>
    </asp:Panel>
    </div>
    </form>
</body>
</html>