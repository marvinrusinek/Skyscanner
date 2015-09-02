using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Web.Script.Services;
using System.Collections.Generic;
using System.Xml;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
	 
	/// <summary>
	/// Summary description for WebService
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[ScriptService]
	 
	public class Autocomplete : System.Web.Services.WebService
	{
	    [WebMethod]
	    public string[] GetItemsList(string prefixText, int count)
	    {
	        List<string> suggestions = new List<string>();
	        using (XmlTextReader reader = new XmlTextReader(HttpContext.Current.Server.MapPath("flightdata.xml")))
	        {
	            while (reader.Read())
	            {
	                if (reader.NodeType == XmlNodeType.Element && reader.Name == "departurelocation")
	                {
	                    string itemName = reader.ReadInnerXml();
	                    if (itemName.StartsWith(prefixText, StringComparison.InvariantCultureIgnoreCase))
	                    {
                            if (!suggestions.Contains(itemName))
	                        suggestions.Add(itemName);
	 
	                        if (suggestions.Count == count) break;
	                    }
	                }

                    if (reader.NodeType == XmlNodeType.Element && reader.Name == "destinationlocation")
                    {
                        string itemName = reader.ReadInnerXml();
                        if (itemName.StartsWith(prefixText, StringComparison.InvariantCultureIgnoreCase))
                        {
                            if (!suggestions.Contains(itemName))
                            suggestions.Add(itemName);

                            if (suggestions.Count == count) break;
                        }
                    }

	            }
	        }
	        return suggestions.ToArray();
	    }
	}