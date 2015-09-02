<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default"
     UICulture="en" EnableSessionState="False" %>

<%@ Register Assembly="CustomCaptcha" Namespace="CustomCaptcha" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CustomCaptcha demo</title>
</head>
<body>
    <form id="form1" runat="server" enableviewstate="false">
    <div>
        <cc1:CaptchaControl ID="CaptchaControl1" runat="server" 
            CaptchaLineNoise="Low" ToolTip="Captcha verification" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
        <asp:Button ID="Button1" runat="server" Text="Submit" />
    </div>
    </form>
</body>
</html>
