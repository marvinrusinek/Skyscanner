using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class reviewflight2 : System.Web.UI.Page
{
    public class FlightDetail
    {
        public Int32 FlightNumber { get; set; }
        public string Airline { get; set; }
        public string Origin { get; set; }
        public string DepartureLocation { get; set; }
        public string Departure { get; set; }
        public string DepartDate { get; set; }
        public string DepartTime { get; set; }
        public string Destination { get; set; }
        public string DestinationLocation { get; set; }
        public string ArrivalTime { get; set; }
        public Int32 Stops { get; set; }
        public string Duration { get; set; }
        public string Distance { get; set; }
        public string ReturnDate { get; set; }
        public string ReturnTime { get; set; }
        public string Cabin { get; set; }
        public string Price { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        string FlightNumber = Request.QueryString["FlightNumber"];
        string Destination = Request.QueryString["Destination"];
        
        var selectedFlight = from f in XElement.Load(MapPath("flightdata.xml")).Elements("flight")
                           where (string)f.Element("flightnumber") == FlightNumber 
                                && (string)f.Element("destinationairportsymbol") == Destination
                           orderby Convert.ToInt32(f.Element("price").Value)
                           select new FlightDetail
                           {
                               FlightNumber = (Int32)f.Element("flightnumber"),
                               Airline = (string)f.Element("airline"),
                               DepartureLocation = (string)f.Element("departurelocation"),
                               Departure = (string)f.Element("departureairportsymbol"),
                               DepartDate = (string)f.Element("departuredate"),
                               DepartTime = (string)f.Element("departuretime"),
                               DestinationLocation = (string)f.Element("destinationlocation"),
                               Destination = (string)f.Element("destinationairportsymbol"),
                               ArrivalTime = (string)f.Element("arrivaltime"),
                               Stops = (int)f.Element("numberofstops"),
                               Duration = (string)f.Element("duration"),
                               Distance = (string)f.Element("distance"),
                               ReturnDate = (string)f.Element("returndate"),
                               ReturnTime = (string)f.Element("returntime"),
                               Cabin = (string)f.Element("cabin"),
                               Price = "$" + (Int32)f.Element("price")
                           };
        DetailsView1.DataSource = selectedFlight;
        DetailsView1.DataBind();
    }

    protected void btnCheckout_Click(object sender, EventArgs e)
    {
        String FlightNumber = Request.QueryString["FlightNumber"];
        String Airline = Request.QueryString["Airline"];
        String DepartCity = Request.QueryString["DepartCity"];
        String Origin = Request.QueryString["Origin"];
        String DepartDate = Request.QueryString["DepartDate"]; 
        String DepartTime = Request.QueryString["DepartTime"];
        String DestCity = Request.QueryString["DestCity"];
        String Destination = Request.QueryString["Destination"];
        String ArrivalDate = Request.QueryString["ArrivalDate"];
        String ArrivalTime = Request.QueryString["ArrivalTime"];
        String Stops = Request.QueryString["Stops"];
        String Duration = Request.QueryString["Duration"];
        String ReturnDate = Request.QueryString["ReturnDate"];
        String ReturnTime = Request.QueryString["ReturnTime"];
        String CabinType = Request.QueryString["CabinType"];
        String Price = Request.QueryString["Price"];
        String Travelers = Request.QueryString["Travelers"];
        String TripType = Request.QueryString["TripType"];

        string bookFlightUrl;

        bookFlightUrl = "bookflight.aspx?FlightNumber=" + FlightNumber + "&TripType=" + TripType + "&Airline=" + Airline + "&DepartCity=" + DepartCity + "&Origin=" + Origin + "&DepartDate=" + DepartDate + "&DepartTime=" + DepartTime + "&DestCity=" + DestCity + "&Destination=" + Destination + "&ArrivalDate=" + ArrivalDate + "&ArrivalTime=" + ArrivalTime + "&Stops=" + Stops + "&Duration=" + Duration + "&ReturnDate=" + ReturnDate + "&ReturnTime=" + ReturnTime + "&CabinType=" + CabinType + "&Price=" + Price + "&Travelers=" + Travelers;

        Response.BufferOutput = true;
        Response.Redirect(bookFlightUrl);
    }

}