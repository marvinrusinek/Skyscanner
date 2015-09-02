using System;

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
         * to force UICulture for this page set this property in Page directive - for example: UICulture="pl"
         * 
         * both SessionState and ViewState are disabled, to show that control doesn't rely on them (see EnableSessionState in Page directive and enableviewstate property on form)
         * if you want use Session as CacheStrategy, set EnableSessionState=true
         */

        // System.Globalization.CultureInfo info = System.Threading.Thread.CurrentThread.CurrentUICulture;
    }
}