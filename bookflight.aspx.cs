using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class bookflight : System.Web.UI.Page
{
    string strCon = "Data Source=(local);Initial Catalog=FlightDB;Integrated Security=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateDropDownMenus();
        }
    }

    protected void PopulateDropDownMenus()
    {
        string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };

        string[] days = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17",
                          "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31" };

        string[] years = { "2011", "2010", "2009", "2008", "2007", "2006", "2005", "2004", "2003", "2002", "2001", "2000", "1999", "1998", "1997", "1996", "1995", "1994", "1993", "1992", "1991", "1990", "1989", "1988", "1987", "1986", "1985", "1984", "1983", "1982", "1981", "1980", "1979", "1978", "1977", "1976", "1975", "1974", "1973", "1972",
"1971", "1970", "1969", "1968", "1967", "1966", "1965", "1964", "1963", "1962", "1961", "1960", "1959", "1958", "1957", "1956", "1955", "1954", "1953", "1952", "1951", "1950", "1949", "1948", "1947", "1946", "1945", "1944", "1943", "1942", "1941", "1940", "1939", "1938", "1937", "1936", "1935", "1934", "1933", "1932", "1931", "1930", "1929", "1928", "1927", "1926", "1925", "1924", "1923", "1922", "1921", "1920", "1919", "1918", "1917", "1916", "1915", "1914", "1913", "1912", "1911", "1910", "1909", "1908", "1907", "1906", "1905", "1904", "1903", "1902", "1901", "1900" };

        string[] meals = { "No Preference", "Child Meal", "Japanese-style", "Kosher", "Low Fat/Cholesterol", "Low Sodium", "Pure Vegetarian", "Vegetarian dairy/egg meal", "Fruit Platter", "Halal" };

        string[] assistance = { "None", "Blind with seeing eye dog", "Deaf with hearing dog", "Wheel chair needed - cannot ascend/descend stairs", "Wheel chair needed - can ascend/descend stairs", "Wheelchair - Immobile" };

        ddlDOBMonth.DataSource = months;
        ddlDOBMonth.DataBind();
        ddlDOBDay.DataSource = days;
        ddlDOBDay.DataBind();
        ddlDOBYear.DataSource = years;
        ddlDOBYear.DataBind();
        ddlMeals.DataSource = meals;
        ddlMeals.DataBind();
        ddlAssistance.DataSource = assistance;
        ddlAssistance.DataBind();
    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
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
            //Session["users"] = this.txtUsername.Text;
            //Session["pwd"] = this.txtPassword.Text;
            lblConnect.Text = "Connected";

            InsertPreferences();
            InsertFlightUserInfo();
            
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

    protected void InsertPreferences()
    {                
        string sql = "sp_insert_flightpreferences";
        SqlConnection objCon = new SqlConnection(strCon);
        objCon.Open();

        SqlCommand cmd = new SqlCommand(sql, objCon);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.Parameters.Add("@fname", SqlDbType.VarChar).Value = txtFirstname.Text;
        cmd.Parameters.Add("@mname", SqlDbType.VarChar).Value = txtMiddlename.Text;
        cmd.Parameters.Add("@lname", SqlDbType.VarChar).Value = txtLastname.Text;
        cmd.Parameters.Add("@seat", SqlDbType.VarChar).Value = rblSeat.SelectedValue;
        cmd.Parameters.Add("@meal", SqlDbType.VarChar).Value = ddlMeals.SelectedValue;
        cmd.Parameters.Add("@assistance", SqlDbType.VarChar).Value = ddlAssistance.SelectedValue;
        cmd.ExecuteNonQuery();
    }

    protected void InsertFlightUserInfo()
    {
        string dob = ddlDOBMonth.SelectedValue + " " + ddlDOBDay.SelectedValue + ", " + ddlDOBYear.SelectedValue;
        
        string sql = "sp_insert_flightuserinfo";
        SqlConnection objCon = new SqlConnection(strCon);
        objCon.Open();

        SqlCommand cmd = new SqlCommand(sql, objCon);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;
        
        cmd.Parameters.Add("@gender", SqlDbType.VarChar).Value = gender.SelectedValue;
        cmd.Parameters.Add("@phonenum", SqlDbType.VarChar).Value = txtPhoneNumber.Text;
        cmd.Parameters.Add("@dob", SqlDbType.VarChar).Value = dob;
        cmd.Parameters.Add("@emer_fname", SqlDbType.VarChar).Value = txtEmergencyFirstname.Text;
        cmd.Parameters.Add("@emer_lname", SqlDbType.VarChar).Value = txtEmergencyLastname.Text;
        cmd.Parameters.Add("@emer_phonenum", SqlDbType.VarChar).Value = txtEmergencyPhoneNumber.Text;
        cmd.ExecuteNonQuery();
    }

    protected void redirectToNextPage()
    {
        String FlightNumber = Request.Params["FlightNumber"];
        String Airline = Request.Params["Airline"];
        String DepartCity = Request.Params["DepartCity"];
        String Origin = Request.Params["Origin"];
        String DepartDate = Request.Params["DepartDate"];
        String DepartTime = Request.Params["DepartTime"];
        String DestCity = Request.Params["DestCity"];
        String Destination = Request.Params["Destination"];
        String ArrivalDate = Request.Params["ArrivalDate"];
        String ArrivalTime = Request.Params["ArrivalTime"];
        String Stops = Request.Params["Stops"];
        String Duration = Request.Params["Duration"];
        String ReturnDate = Request.Params["ReturnDate"];
        String ReturnTime = Request.Params["ReturnTime"];
        String CabinType = Request.Params["CabinType"];
        String Price = Request.Params["Price"];
        String TripType = Request.Params["TripType"];
        String Travelers = Request.Params["Travelers"];

        string passengerName = txtFirstname.Text + " " + txtMiddlename.Text + " " + txtLastname.Text;
        string checkoutUrl;

        checkoutUrl = "checkout.aspx?FlightNumber=" + FlightNumber + "&TripType=" + TripType + "&Airline=" + Airline + "&DepartCity=" + DepartCity + "&Origin=" + Origin + "&DepartDate=" + DepartDate + "&DepartTime=" + DepartTime + "&DestCity=" + DestCity + "&Destination=" + Destination + "&ArrivalDate=" + ArrivalDate + "&ArrivalTime=" + ArrivalTime + "&Stops=" + Stops + "&Duration=" + Duration + "&ReturnDate=" + ReturnDate + "&ReturnTime=" + ReturnTime + "&CabinType=" + CabinType + "&Price=" + Price + "&PassengerName=" + passengerName + "&Assistance=" + ddlAssistance.SelectedValue + "&Travelers=" + Travelers;

        Response.BufferOutput = true;
        Response.Redirect(checkoutUrl);
    }
}