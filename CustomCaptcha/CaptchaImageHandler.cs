//-----------------------------------------------------------------------
// <copyright file="CaptchaImageHandler.cs" company="Mateusz Chodyła">
//   Copyright (c) Mateusz Chodyła. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace CustomCaptcha
{
    using System.Drawing;
    using System.Drawing.Imaging;
    using System.Web;
    using System.Web.SessionState;

    /// <summary>
    /// Retrieves CAPTCHA images from cache and streams them to the browser.
    /// You must enable this HttpHandler in your web.config:
    /// [configuration]
    ///   [system.web]
    ///     [httpHandlers]
    ///       [add verb="GET" path="CaptchaImage.aspx" type="CustomCaptcha.CaptchaImageHandler, CustomCaptcha"/]
    ///     [/httpHandlers]
    ///   [/system.web]
    /// [/configuration]
    /// </summary>
    public class CaptchaImageHandler : IHttpHandler, IRequiresSessionState
    {
        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            HttpApplication application = context.ApplicationInstance;
            
            string guid = application.Request.QueryString["guid"];
            bool useSession = !string.IsNullOrEmpty(application.Request.QueryString["useSession"]); // if empty, don't use session

            if (string.IsNullOrEmpty(guid) == false)
            {
                CaptchaImage captchaImage;

                if (useSession == true)
                {
                    captchaImage = (CaptchaImage)HttpContext.Current.Session[guid];
                }
                else
                {
                    captchaImage = (CaptchaImage)HttpRuntime.Cache.Get(guid);
                }

                Bitmap bitmap = captchaImage.GenerateImage();
                bitmap.Save(application.Context.Response.OutputStream, ImageFormat.Jpeg);
                bitmap.Dispose();
                application.Response.ContentType = "image/jpeg";
                application.Response.StatusCode = 200;                
            }
            else
            {
                application.Response.StatusCode = 404;
            }

            context.ApplicationInstance.CompleteRequest();
        }
    }
}