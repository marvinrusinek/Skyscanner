using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Xml.XPath;
using System.Xml;
using System.Data;
using System.Web.UI.HtmlControls;

public partial class searchresult : System.Web.UI.Page
{
    public class FlightDetail
    {
        public Int32 FlightNumber { get; set; }
        public String Airline { get; set; }
        public String Departure { get; set; }
        public String DepartureDate { get; set; }
        public String DepartureTime { get; set; }
        public String Destination { get; set; }
        public String ArrivalDate { get; set; }
        public String ArrivalTime { get; set; }
        public Int32 Stops { get; set; }
        public String Duration { get; set; }
        public String ReturnDate { get; set; }
        public String ReturnTime { get; set; }
        public String Cabin { get; set; }
        public String Price { get; set; }
        public String TripType { get; set; }
        public String ImagePath { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SetIntroductoryFlightText();
            FillAvailableFlightsGridView();
            FillDDLTimes();
        }
    }

    protected void SetIntroductoryFlightText()
    {
        String From = Request.QueryString["DepartCity"];
        String DestCity = Request.QueryString["DestCity"];
        String DepartDate = Request.QueryString["DepartDate"];
        String ReturnDate = Request.QueryString["ReturnDate"];
        String Travelers = Request.QueryString["Travelers"];
        String DepartTime = Request.QueryString["DepartTime"];
        String ReturnTime = Request.QueryString["ReturnTime"];

        

        lblFrom.Text = From.ToString();
        lblTo.Text = DestCity.ToString();
        lblFrom2.Text = From.ToString();
        lblTo2.Text = DestCity.ToString();
        lblDepartingDate.Text = DepartDate.ToString();
        lblReturningDate.Text = ReturnDate.ToString();
        lblNumTravelers.Text = Travelers;
    }
    
    protected void FillAvailableFlightsGridView()
    {
        String TripType = Request.QueryString["TripType"];
        String From = Request.QueryString["DepartCity"];
        String DestCity = Request.QueryString["DestCity"];
        String DepartDate = Request.QueryString["DepartDate"];
        String DepartTime = Request.QueryString["DepartTime"];
        String ReturnDate = Request.QueryString["ReturnDate"];
        String ReturnTime = Request.QueryString["ReturnTime"];
        String Airline = Request.QueryString["Airline"];
        String Flexible = Request.QueryString["Flexible"];
        String Travelers = Request.QueryString["Travelers"];
        String Nonstop = Request.QueryString["Nonstop"];
        String Cabin = Request.QueryString["Cabin"];

        var flights = from f in XElement.Load(MapPath("flightdata.xml")).Elements("flight")
                      where (string)f.Element("departurelocation") == From && (string)f.Element("destinationlocation") == DestCity && (string)f.Element("departuredate") == DepartDate && (string)f.Element("returndate") == ReturnDate
                      //&& (string)f.Element("airline") == Airline                      
                      orderby Convert.ToInt32(f.Element("price").Value)
                      select new FlightDetail
                      {
                          FlightNumber = (Int32)f.Element("flightnumber"),
                          Airline = (string)f.Element("airline"),
                          Departure = (string)f.Element("departureairportsymbol"),
                          DepartureDate = (string)f.Element("departuredate"),
                          DepartureTime = (string)f.Element("departuretime"),
                          Destination = (string)f.Element("destinationairportsymbol"),
                          ArrivalDate = (string)f.Element("arrivaldate"),
                          ArrivalTime = (string)f.Element("arrivaltime"),
                          Stops = (int)f.Element("numberofstops"),
                          Duration = (string)f.Element("duration"),
                          ReturnDate = (string)f.Element("returndate"),
                          ReturnTime = (string)f.Element("returntime"),
                          Cabin = (string)f.Element("cabin"),
                          Price = "$" + (Int32)f.Element("price"),
                          TripType = (string)f.Element("triptype"),
                          ImagePath = (string)f.Element("airlineimageurl")
                      };

        int flightsCount = (flights == null) ? 0 : flights.Count();
        if (flightsCount >= 1)
        {
            lblNumResults.Text = flightsCount.ToString();
            gvAvailableFlights.DataSource = flights;
            gvAvailableFlights.DataBind();
        }
        else
        {
            lblNumResults.Text = "0";
            lblNumResults.Text = "<h2 style='color:red'><strong>No results found. Please try your search again.</strong></h2>";
        }        
    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "select")
        {
            int rowNum = int.Parse(e.CommandArgument.ToString());
            GridView grid = (GridView)e.CommandSource;
            GridViewRow row = grid.Rows[rowNum];

            ListItem flightSelected = new ListItem();
            ListItem airlineSelected = new ListItem();
            ListItem departureAirportSelected = new ListItem();
            ListItem departureDateSelected = new ListItem();
            ListItem departureTimeSelected = new ListItem();
            ListItem destinationAirportSelected = new ListItem();
            ListItem arrivalDateSelected = new ListItem();
            ListItem arrivalTimeSelected = new ListItem();
            ListItem stopsSelected = new ListItem();
            ListItem durationSelected = new ListItem();
            ListItem returnDateSelected = new ListItem();
            ListItem returnTimeSelected = new ListItem();
            ListItem cabinSelected = new ListItem();
            ListItem priceSelected = new ListItem();

            flightSelected.Text = Server.HtmlDecode(row.Cells[2].Text);
            airlineSelected.Text = Server.HtmlDecode(row.Cells[3].Text);
            departureAirportSelected.Text = Server.HtmlDecode(row.Cells[4].Text);
            departureDateSelected.Text = Server.HtmlDecode(row.Cells[5].Text);
            departureTimeSelected.Text = Server.HtmlDecode(row.Cells[6].Text); ;
            destinationAirportSelected.Text = Server.HtmlDecode(row.Cells[7].Text);
            arrivalDateSelected.Text = Server.HtmlDecode(row.Cells[8].Text);
            arrivalTimeSelected.Text = Server.HtmlDecode(row.Cells[9].Text);
            stopsSelected.Text = Server.HtmlDecode(row.Cells[10].Text);
            durationSelected.Text = Server.HtmlDecode(row.Cells[11].Text);
            returnDateSelected.Text = Server.HtmlDecode(row.Cells[12].Text);
            returnTimeSelected.Text = Server.HtmlDecode(row.Cells[13].Text);
            cabinSelected.Text = Server.HtmlDecode(row.Cells[14].Text);
            priceSelected.Text = Server.HtmlDecode(row.Cells[15].Text);

            String TripType = Request.QueryString["TripType"];
            String DepartCity = Request.QueryString["DepartCity"];
            String DestCity = Request.QueryString["DestCity"];
            String Travelers = Request.QueryString["Travelers"];

            string flightSelectedUrl;

            flightSelectedUrl = "reviewflight.aspx?FlightNumber=" + flightSelected.Text + "&TripType=" + TripType + "&Airline=" + airlineSelected.Text + "&DepartCity=" + DepartCity + "&Origin=" + departureAirportSelected.Text + "&DepartDate=" + departureDateSelected.Text + "&DepartTime=" + departureTimeSelected.Text + "&DestCity=" + DestCity + "&Destination=" + destinationAirportSelected.Text + "&ArrivalDate= " + arrivalDateSelected + "&ArrivalTime=" + arrivalTimeSelected + "&Stops=" + stopsSelected + "&Duration=" + durationSelected + "&ReturnDate=" + returnDateSelected.Text + "&ReturnTime=" + returnTimeSelected.Text + "&CabinType=" + cabinSelected + "&Price=" + priceSelected + "&Travelers=" + Travelers;

            Response.BufferOutput = true;
            Response.Redirect(flightSelectedUrl);   
        }
    }

    protected void FillDDLTimes()
    {
        string[] hours = { "Anytime", "12:00 AM", "1:00 AM", "2:00 AM", "3:00 AM", "4:00 AM", "5:00 AM", "6:00 AM", "7:00 AM", "8:00 AM", "9:00 AM", "10:00 AM", "11:00 AM", "12:00 PM", "1:00 PM", "2:00 PM", "3:00 PM", "4:00 PM", "5:00 PM", "6:00 PM", 
"7:00 PM", "8:00 PM", "9:00 PM", "10:00 PM", "11:00 PM", "Morn.", "Noon", "Eve."};
        ddlDepartTime.DataSource = hours;
        ddlDepartTime.DataBind();
        ddlReturnTime.DataSource = hours;
        ddlReturnTime.DataBind();

        int[] numberOfTravelers = { 0, 1, 2, 3, 4, 5, 6 };
        ddlNumTravelers.DataSource = numberOfTravelers;
        ddlNumTravelers.DataBind();
    }

    protected void newsearchbtn_Click(object sender, EventArgs e)
    {
        string newsearchUrl = "searchresult.aspx?DepartCity=" + txtDepLoc.Text + "&DestCity=" + txtDestLoc.Text + "&DepartDate=" + txtDepartDate.Text + "&ReturnDate=" + txtReturnDate.Text + "&Travelers=" + ddlNumTravelers.SelectedValue;

        Response.BufferOutput = true;
        Response.Redirect(newsearchUrl);
    }
}