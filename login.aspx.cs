using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;

public partial class login : System.Web.UI.Page
{
    //logging code global variables
    static protected string Log_File_Path = "C:\\ExpediaProject\\";
    static protected int Tmp_File_Keep_Days = 30;
    protected string Log_File_Name;

    protected void Page_Load(object sender, EventArgs e) {}

    private void WriteLog(string txt)
    {
        StreamWriter fs = new StreamWriter(Log_File_Name, true);
        fs.WriteLine(DateTime.Now.ToString() + " - " + txt);
        fs.Close();
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string strCon = "Data Source=(local);Initial Catalog=FlightDB;Integrated Security=True";
        SqlConnection objCon = new SqlConnection();

        try
        {
            objCon.ConnectionString = strCon;
            objCon.Open();
        }
        catch (Exception ex)
        {
            this.lblReturn.Text = "Invalid Login";
        }

        if (objCon.State == System.Data.ConnectionState.Open)
        {
            Session["users"] = this.txtUsername.Text;
            Session["pwd"] = this.txtPassword.Text;
            //lblReturn.Text = "Connected";
            objCon.Close();
            objCon.Dispose();
            //Response.Redirect("default.aspx")
        }
        else
        {
            this.lblReturn.Text = "Invalid Login";
        }


        //logging code starts here
        string LogPath = Log_File_Path + DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString();
        Log_File_Name = LogPath + "\\" + txtUsername.Text + ".txt";

        if (!File.Exists(LogPath))
            Directory.CreateDirectory(LogPath);
        
        SqlConnection objCon2 = new SqlConnection(strCon);        //initialized new sqlconnection for logging purposes
        try
        {
            WriteLog("Initializing connection to: " + strCon);
            objCon2.Open();
            WriteLog("Connection State: " + objCon2.State.ToString());
        }
        catch (Exception ex)
        {
            WriteLog("Error Connecting: " + ex.Message);
            lblReturn.Text += "Invalid login";
        }

        if (objCon2.State == System.Data.ConnectionState.Open)
        {
            Session["user"] = txtUsername.Text;
            Session["password"] = txtPassword.Text;
        }
        else
            lblReturn.Text += "Invalid Login";

        //remove old files
        DateTime d1, d2;

        foreach (string tmp_dir_name in Directory.GetDirectories(Log_File_Path))
        {
            d1 = Directory.GetCreationTime(tmp_dir_name);
            d2 = DateTime.Now;

            if (d1.AddDays(Tmp_File_Keep_Days) < d2)
            {
                WriteLog("Deleting Expired Dir: " + tmp_dir_name);
                //delete dir code here
            }
        }

        //forward the user back to the homepage
        string loginForwardingUrl;
        loginForwardingUrl = "index.aspx?Username=" + txtUsername.Text + "&LoggedIn=True";

        Response.BufferOutput = true;
        Response.Redirect(loginForwardingUrl);
    }
}