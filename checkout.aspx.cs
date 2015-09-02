using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Data;
using System.Data.SqlClient;

public partial class checkout : System.Web.UI.Page
{
    public class CheckoutDetail
    {
        public String totalpricestr { get; set; }
    }   

    string strCon = "Data Source=(local);Initial Catalog=FlightDB;Integrated Security=True";
        
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateDropDowns();
            CreateTripSummary();
        }
    }

    protected void PopulateDropDowns()
    {
        string[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };

        string[] years= { "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026", "2027", "2028", "2029", "2030" };
        
        string[] states = { "AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM","NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "WA", "WI", "WV", "WY", "AA", "AE", "AP" };
        
        ddlMonths.DataSource = months;
        ddlMonths.DataBind();
        ddlYears.DataSource = years;
        ddlYears.DataBind();
        ddlStates.DataSource = states;
        ddlStates.DataBind();

        //consume the getcountries web service and bind to the countries ddl
        var service = new net.webservicex.www.country();
        var xml = service.GetCountries();
        var countries = XDocument.Parse(xml).Descendants("Name").Select(arg => arg.Value).ToList();
        ddlCountries.DataSource = countries;
        ddlCountries.DataBind();    
    }

    protected void CreateTripSummary()
    {
        String FlightNumber = Request.QueryString["FlightNumber"];
        String DepartDate = Request.QueryString["DepartDate"];
        String ReturnDate = Request.QueryString["ReturnDate"];
        String TripType = Request.QueryString["TripType"];
        String DepartCity = Request.QueryString["DepartCity"];
        String DestCity = Request.QueryString["DestCity"];
        String Destination = Request.QueryString["Destination"];
        String PassengerName = Request.QueryString["PassengerName"];
        String Travelers = Request.QueryString["Travelers"];
        
        int numOfTravelers = Convert.ToInt32(Travelers);

        lblStartDate.Text = DepartDate;
        lblEndDate.Text = ReturnDate;
        lblTripType.Text = TripType;
        lblDepartureLocation.Text = DepartCity;
        lblArrivalLocation.Text = DestCity;
        lblTraveler.Text = PassengerName;
        lblNumOfTravelers.Text = Travelers;

        if (numOfTravelers == 1) lblTickets.Text = "ticket";
        else lblTickets.Text = "tickets";

        decimal flightPrice = (from f in XElement.Load(MapPath("flightdata.xml")).Elements("flight")
                               where (string)f.Element("flightnumber") == FlightNumber
                                  && (string)f.Element("destinationairportsymbol") == Destination
                               select (decimal)f.Element("price")
                           ).SingleOrDefault();

        decimal flightPriceSubFee = flightPrice * numOfTravelers;
        lblFlightPrice.Text = "$" + String.Format("{0:0.00}", flightPriceSubFee);
        lblFlightPrice2.Text = "$" + String.Format("{0:0.00}", flightPriceSubFee);

        decimal taxfees = flightPrice * 0.35m;
        lblTaxFees.Text = "$" + taxfees.ToString();
        lblTaxFees2.Text = "$" + taxfees.ToString();
        decimal totalprice = (flightPrice * numOfTravelers) + taxfees;
        string totalpricestr = Convert.ToString(totalprice);
        lblTotalPrice.Text = "$" + totalprice.ToString();
        lblTotalPrice2.Text = "$" + totalprice.ToString();
    }

    protected void btnBookFlight_Click(object sender, EventArgs e)
    {
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
            InsertFlightInfo();
            InsertFlightOrder();
            
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

    protected void InsertFlightInfo()
    {
        String FlightNumber = Request.Params["FlightNumber"];
        String Airline = Request.Params["Airline"];
        String Origin = Request.Params["Origin"];
        String DepartDate = Request.Params["DepartDate"];
        String DepartTime = Request.Params["DepartTime"];
        String Destination = Request.Params["Destination"];
        String ArrivalDate = Request.Params["ArrivalDate"];
        String ArrivalTime = Request.Params["ArrivalTime"];
        String Stops = Request.Params["Stops"];
        String ReturnDate = Request.Params["ReturnDate"];
        String ReturnTime = Request.Params["ReturnTime"];
        String Duration = Request.Params["Duration"];
        String CabinType = Request.Params["CabinType"];
        String Price = Request.Params["Price"];
        String PassengerName = Request.Params["PassengerName"];
        String Assistance = Request.Params["Assistance"];
        
        string sql = "sp_insert_flightinfo";
        SqlConnection objCon = new SqlConnection(strCon);
        objCon.Open();

        SqlCommand cmd = new SqlCommand(sql, objCon);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.Parameters.Add("@flightnum", SqlDbType.VarChar).Value = FlightNumber;
        cmd.Parameters.Add("@airline", SqlDbType.VarChar).Value = Airline;
        cmd.Parameters.Add("@origin", SqlDbType.VarChar).Value = Origin;
        cmd.Parameters.Add("@departdate", SqlDbType.VarChar).Value = DepartDate;
        cmd.Parameters.Add("@departtime", SqlDbType.VarChar).Value = DepartTime;
        cmd.Parameters.Add("@destination", SqlDbType.VarChar).Value = Destination;
        cmd.Parameters.Add("@arrivaldate", SqlDbType.VarChar).Value = ArrivalDate;
        cmd.Parameters.Add("@arrivaltime", SqlDbType.VarChar).Value = ArrivalTime;
        cmd.Parameters.Add("@stops", SqlDbType.VarChar).Value = Stops;
        cmd.Parameters.Add("@duration", SqlDbType.VarChar).Value = Duration;
        cmd.Parameters.Add("@returndate", SqlDbType.VarChar).Value = ReturnDate;
        cmd.Parameters.Add("@returntime", SqlDbType.VarChar).Value = ReturnTime;
        cmd.Parameters.Add("@cabintype", SqlDbType.VarChar).Value = CabinType;
        cmd.Parameters.Add("@price", SqlDbType.VarChar).Value = lblTotalPrice.Text;
        cmd.ExecuteNonQuery();
    }

    protected void InsertFlightOrder()
    {
        String Price = Request.Params["Price"];       
        string ccexpdate = ddlMonths.SelectedValue + " " + ddlYears.SelectedValue;
        string ccholdername = txtFirstname.Text + " " + txtLastname.Text;
        string straddr = txtStreet.Text + " " + txtSuiteApt.Text;

        string sql = "sp_insert_flightorder";
        SqlConnection objCon = new SqlConnection(strCon);
        objCon.Open();

        SqlCommand cmd = new SqlCommand(sql, objCon);
        cmd.CommandType = System.Data.CommandType.StoredProcedure;

        cmd.Parameters.Add("@totalprice", SqlDbType.VarChar).Value = lblTotalPrice.Text;
        cmd.Parameters.Add("@cctype", SqlDbType.VarChar).Value = ddlCardType.SelectedValue;
        cmd.Parameters.Add("@ccnumber", SqlDbType.VarChar).Value = txtCCNumber.Text;
        cmd.Parameters.Add("@ccsecuritycode", SqlDbType.VarChar).Value = txtSecurityCode.Text;
        cmd.Parameters.Add("@ccexpdate", SqlDbType.VarChar).Value = ccexpdate.ToString();
        cmd.Parameters.Add("@ccholdername", SqlDbType.VarChar).Value = ccholdername.ToString();
        cmd.Parameters.Add("@streetaddr", SqlDbType.VarChar).Value = straddr.ToString();
        cmd.Parameters.Add("@city", SqlDbType.VarChar).Value = txtCity.Text;
        cmd.Parameters.Add("@state", SqlDbType.VarChar).Value = ddlStates.SelectedValue;
        cmd.Parameters.Add("@zipcode", SqlDbType.VarChar).Value = txtZipCode.Text;
        cmd.Parameters.Add("@country", SqlDbType.VarChar).Value = ddlCountries.SelectedItem.Value;
        cmd.Parameters.Add("@phonenum", SqlDbType.VarChar).Value = txtPhoneNumber.Text;
        cmd.ExecuteNonQuery();
    }

    public void redirectToNextPage()
    {
        String FlightNumber = Request.Params["Flight"];
        String Airline = Request.Params["Airline"];
        String Origin = Request.Params["Origin"];
        String DepartDate = Request.Params["DepartDate"];
        String DepartTime = Request.Params["DepartTime"];
        String Destination = Request.Params["Destination"];
        String ArrivalDate = Request.Params["ArrivalDate"];
        String ArrivalTime = Request.Params["ArrivalTime"];
        String Stops = Request.Params["Stops"];
        String ReturnDate = Request.Params["ReturnDate"];
        String ReturnTime = Request.Params["ReturnTime"];
        String Duration = Request.Params["Duration"];
        String CabinType = Request.Params["CabinType"];
        String Price = Request.Params["Price"];
        String PassengerName = Request.Params["PassengerName"];
        String Assistance = Request.Params["Assistance"];

        string bookFlightUrl;

        bookFlightUrl = "order_complete.aspx?FlightNumber=" + FlightNumber + "&Airline=" + Airline + "&Origin=" + Origin + "&DepartTime=" + DepartTime + "&Destination=" + Destination + "&ArrivalTime=" + ArrivalTime + "&Stops=" + Stops + "&Duration=" + Duration + "&CabinType=" + CabinType + "&Price=" + lblTotalPrice.Text + "&PassengerName=" + PassengerName + "&Assistance=" + Assistance;

        Response.BufferOutput = true;
        Response.Redirect(bookFlightUrl);
    }
}