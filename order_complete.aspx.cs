using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class order_complete : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GenerateKey();
    }

    protected void GenerateKey()
    {
        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }

        string longstring = string.Format("{0:x}", i - DateTime.Now.Ticks);
        string confnum = longstring.ToUpper().Substring(0, 6);
        //lblConfNumTest.Text = shortstring.ToString();

        InsertKeyIntoConfNumTable(confnum);
    }

    protected void InsertKeyIntoConfNumTable(string confnum)
    {
        string strCon = "Data Source=(local);Initial Catalog=FlightDB;Integrated Security=True";
        SqlConnection objCon = new SqlConnection(strCon);

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
            string sql = "INSERT INTO flightconfirmation (confnum) VALUES ('" + confnum + "')";
            SqlCommand cmd = new SqlCommand(sql, objCon);
            cmd.ExecuteNonQuery();

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
    }

    protected void bookAnotherFlightBtn_Click(object sender, EventArgs e)
    {
        string url = "index.aspx";

        Response.BufferOutput = true;
        Response.Redirect(url);
    }
}