using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class regtest : System.Web.UI.Page
{
    string strCon = "Data Source=(local);Initial Catalog=FlightDB;Integrated Security=True";
        
    protected void Page_Load(object sender, EventArgs e) { }

    protected void btnreg_Click(object sender, EventArgs e)
    {
        CaptchaValidate();

        SqlConnection objCon = new SqlConnection(strCon);
        objCon.Open();
        
        try
        {
            objCon.ConnectionString = strCon;
            objCon.Open();
        }
        catch (Exception ex)
        {
            this.lblConnect.Text = "Unable to connect to database.";
        }

        if (objCon.State == System.Data.ConnectionState.Open)
        {
            Session["users"] = this.txtUsername.Text;
            Session["pwd"] = this.txtPassword.Text;
            lblConnect.Text = "Connected";

            InsertFlightUserLoginInfo();            
            
            objCon.Close();
            objCon.Dispose();
        }
        else
        {
            lblConnect.Text = "Unable to connect to database.";
            objCon.Close();
            objCon.Dispose();

        }
        objCon.Close();
        objCon.Dispose();

        redirectToNextPage();
    }

    protected void CaptchaValidate()
    {
        CaptchaControl1.Validate();
        if (!CaptchaControl1.IsValid)
        {
            lblcaptcha.Text = "Not successful";
            return;
        }
        else
        {
            lblcaptcha.Text = "Successful";
        }
    }

    protected void InsertFlightUserLoginInfo()
    {
        string sql = "sp_insert_flightuserlogininfo";
        SqlConnection objCon = new SqlConnection(strCon);
        objCon.Open();

        SqlCommand cmd = new SqlCommand(sql, objCon);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.Parameters.Add("@fname", SqlDbType.VarChar).Value = txtFirstname.Text;
        cmd.Parameters.Add("@mname", SqlDbType.VarChar).Value = txtMiddlename.Text;
        cmd.Parameters.Add("@lname", SqlDbType.VarChar).Value = txtLastname.Text;
        cmd.Parameters.Add("@username", SqlDbType.VarChar).Value = txtUsername.Text;
        cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = txtEmailAddr.Text;
        cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = txtPassword.Text;
        cmd.ExecuteNonQuery();
    }

    protected void redirectToNextPage()
    {
        string url = "login.aspx";

        Response.BufferOutput = true;
        Response.Redirect(url);
    }
}