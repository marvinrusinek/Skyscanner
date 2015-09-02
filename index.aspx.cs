using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.XPath;
using System.IO;
using System.Xml.Linq;
using System.Text;
using System.Collections;
using System.Xml;
using System.Data;

public partial class index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DisplaySearchButton();
            PopulateDropDownMenus();            //populates the departure, arrival and airlines dropdowns
            BindDropDownListAdditionalInfo();   //puts the information into the hours and number of travelers dropdowns

            String Username = Request.QueryString["Username"];
            String LoggedIn = Request.QueryString["LoggedIn"];
            if (LoggedIn=="True") lblLoggedIn.Text = "Logged in as " + Username + " | <a href='Logout.aspx'>Log out</a>";
        }
    }

    protected void DisplaySearchButton()
    {
        ibSearch.Attributes.Add("onmouseover", "this.src='images/search2.png'");
        ibSearch.Attributes.Add("onmouseout", "this.src='images/search1.png'");
    }

    protected void PopulateDropDownMenus()
    {
        string flightDataFile = "C:\\Users\\Marvin Rusinek\\Documents\\Visual Studio 2010\\WebSites\\skyscanner2\\flightdata.xml";
        XPathDocument doc = new XPathDocument(flightDataFile);

        //Local declarations
        XPathNavigator departureLocationNav = doc.CreateNavigator();
        XPathNavigator destinationLocationNav = doc.CreateNavigator();
        XPathNavigator airlineNav = doc.CreateNavigator();

        //ddlDepartureLocation
        XPathExpression departureLocationExpr;
        departureLocationExpr = departureLocationNav.Compile("/flightdata/flight/departurelocation");
        XPathNodeIterator departureLocationIterator = departureLocationNav.Select(departureLocationExpr);

        //assemble the departure location ddl
        try
        {
            while (departureLocationIterator.MoveNext())
            {
                XPathNavigator departureLocationNav2 = departureLocationIterator.Current.Clone();
                ddlDepartureLocation.Items.Add(departureLocationNav2.Value);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }

        //sort the departure locations in ascending order
        ddlDepartureLocation.DataSource = ddlDepartureLocation.Items.Cast<ListItem>()
                    .OrderBy(o => o.Text).Distinct()
                    .ToList();
        ddlDepartureLocation.DataBind();


        //ddlDestinationLocation
        XPathExpression destinationLocationExpr;
        destinationLocationExpr = destinationLocationNav.Compile("/flightdata/flight/destinationlocation");
        XPathNodeIterator destinationLocationIterator = destinationLocationNav.Select(destinationLocationExpr);
        ddlDestinationLocation.Items.Clear();

        //assemble the destination location ddl
        try
        {
            while (destinationLocationIterator.MoveNext())
            {
                XPathNavigator destinationLocationNav2 = destinationLocationIterator.Current.Clone();
                ddlDestinationLocation.Items.Add(destinationLocationNav2.Value);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }

        //sort the destinations in ascending order
        ddlDestinationLocation.DataSource = ddlDestinationLocation.Items.Cast<ListItem>()
            .OrderBy(o => o.Text).Distinct()
            .ToList();
        ddlDestinationLocation.DataBind();

        //assemble the airline ddl
        XPathExpression airlineExpr;
        airlineExpr = airlineNav.Compile("/flightdata/flight/airline");
        XPathNodeIterator airlineIterator = airlineNav.Select(airlineExpr);
        ddlAirline.Items.Clear();

        try
        {
            while (airlineIterator.MoveNext())
            {
                XPathNavigator airlineNav2 = airlineIterator.Current.Clone();
                ddlAirline.Items.Add(airlineNav2.Value);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine(ex.Message);
        }
        
        //sort the airlines in ascending order
        ddlAirline.DataSource = ddlAirline.Items.Cast<ListItem>()
                   .OrderBy(o => o.Text).Distinct()
                   .ToList();
        ddlAirline.DataBind();
    }

    protected void BindDropDownListAdditionalInfo()
    {
        string[] hours = { "Anytime", "12 AM", "1 AM", "2 AM", "3 AM", "4 AM", "5 AM", "6 AM", "7 AM", "8 AM", "9 AM", "10 AM", "11 AM", "12 PM", "1 PM", "2 PM", "3 PM", "4 PM", "5 PM", "6 PM", "7 PM", "8 PM", "9 PM", "10 PM", "11 PM", "Morn.", "Noon", "Eve."};
        ddlDepartureTime.DataSource = hours;
        ddlDepartureTime.DataBind();
        ddlReturnTime.DataSource = hours;
        ddlReturnTime.DataBind();

        int[] numberOfTravelers = { 1, 2, 3, 4, 5, 6 };
        ddlTravelers.DataSource = numberOfTravelers;
        ddlTravelers.DataBind();
    }

    protected void ibSearch_Click(object sender, EventArgs e)
    {
        String Username = Request.QueryString["Username"];
        String LoggedIn = Request.QueryString["LoggedIn"];

        string url;
        
        url = "searchresult.aspx?TripType=" + rblTripType.SelectedItem + "&DepartCity=" + From.Text + "&DestCity=" + To.Text + "&DepartDate=" + DepartureDateTextbox.Text + "&DepartTime=" + ddlDepartureTime.SelectedValue + "&ReturnDate=" + ReturnDateTextbox.Text + "&ReturnTime=" + ddlReturnTime.SelectedValue + "&Airline=" + ddlAirline.SelectedValue + "&Flexible=" + Flexible.Checked + "&Travelers=" + ddlTravelers.SelectedValue + "&Nonstop=" + Nonstop.Checked + "&Cabin=" + ddlCabin.SelectedValue;

        Response.BufferOutput = true;
        Response.Redirect(url);        
    }
}