//-----------------------------------------------------------------------
// <copyright file="CaptchaControl.cs" company="Mateusz Chodyła">
//   Copyright (c) Mateusz Chodyła. All rights reserved.
// </copyright>
//-----------------------------------------------------------------------

namespace CustomCaptcha
{
    using System;
    using System.Collections.Specialized;
    using System.ComponentModel;
    using System.Drawing;
    using System.Globalization;
    using System.Text;
    using System.Web;
    using System.Web.Caching;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using CustomCaptcha.Properties;

    /// <summary>
    /// CAPTCHA control. Usage: add the CaptchaControl to your toolbox, then just drag and drop the control on a web form and set properties on it.
    /// </summary>
    [ToolboxData("<{0}:CaptchaControl runat=\"server\" />")]
    public class CaptchaControl : CompositeControl, INamingContainer, IPostBackDataHandler, IValidator
    {
        //// INamingContainer - any control that implements this interface creates a new namespace in which all child control ID attributes are guaranteed to be unique within an entire application (marker interface only).

        #region Fields

        private readonly string captchaInputID;

        private string errorMessage;
        private bool userValidated;
        private string optionalUICulture;
        private Layout layoutStyle;
        private CacheType cacheStrategy;
        private int timeoutSecondsMin;
        private int timeoutSecondsMax;
        private string font;

        private CaptchaImage captcha;
        private string previousGuid;

        #endregion
        
        /// <summary>
        /// Initializes a new instance of the CaptchaControl class. Sets all properties and fields to defaults.
        /// </summary>
        public CaptchaControl()
        {
            this.errorMessage = string.Empty;
            this.userValidated = true;
            this.optionalUICulture = string.Empty;
            Resources.Culture = null;

            this.layoutStyle = Layout.Horizontal;
            this.cacheStrategy = CacheType.HttpRuntime;

            this.timeoutSecondsMin = 3;
            this.timeoutSecondsMax = 90;
            this.font = string.Empty;

            this.captchaInputID = "CaptchaInput";

            this.captcha = new CaptchaImage();
        }

        #region Enums

        /// <summary>
        /// Defines orientation of image and text input.
        /// </summary>
        public enum Layout
        {
            /// <summary>
            /// Image and text input on single line.
            /// </summary>
            Horizontal,

            /// <summary>
            /// Image above, text input below.
            /// </summary>
            Vertical
        }

        /// <summary>
        /// Defines type of cache.
        /// </summary>
        public enum CacheType
        {
            /// <summary>
            /// Use HttpRuntime.Cache.
            /// </summary>
            HttpRuntime,

            /// <summary>
            /// Use HttpContext.Session (session state must be enabled).
            /// </summary>
            Session
        }

        #endregion

        #region Properties

        public override bool Enabled
        {
            get
            {
                return base.Enabled;
            }

            set
            {
                base.Enabled = value;
                if (value == false)
                {
                    this.userValidated = true; // when a validator is disabled, generally, the intent is not to make the page invalid for that round trip
                }
            }
        }

        /// <summary>
        /// Gets or sets message to display in a Validation Summary when the CAPTCHA fails to validate (IValidator member).
        /// </summary>
        [Browsable(false)]
        [Bindable(true)]
        public string ErrorMessage
        {
            get
            {
                if (this.userValidated == true)
                {
                    return string.Empty;
                }
                else
                {
                    return this.errorMessage;
                }
            }

            set
            {
                this.errorMessage = value;
            }
        }

        /// <summary>
        /// Gets or sets a value indicating whether the user was CAPTCHA validated after a postback (IValidator member).
        /// </summary>
        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public bool IsValid
        {
            get
            {
                return this.userValidated;
            }

            set
            {
                // must be like that, because it is IValidator member
            }
        }

        /// <summary>
        /// Gets or sets ResourceManager's culture. If you want use other language - simply add Resources.[two letter language code].resx file to Properties. Resources.resx file is used if ResourceManager can't find appropriate file.
        /// </summary>
        [DefaultValue("")]
        [Description("Optional UICulture (only language: 'de', 'pl',...). If empty - the same effect as Thread.CurrentThread.CurrentUICulture.ToString().")]
        [Category("Appearance")]
        public string OptionalUICulture
        {
            get
            {
                return this.optionalUICulture;
            }

            set
            {
                this.optionalUICulture = value;

                if ((this.IsDesignMode == false) && (string.IsNullOrEmpty(this.optionalUICulture) == false))
                {
                    Resources.Culture = CultureInfo.GetCultureInfo(this.optionalUICulture);
                }
            }
        }

        [DefaultValue(Layout.Horizontal)]
        [Description("Determines if image and input area are displayed horizontally, or vertically.")]
        [Category("Captcha")]
        public Layout LayoutStyle
        {
            get
            {
                return this.layoutStyle;
            }

            set
            {
                this.layoutStyle = value;
            }
        }

        [DefaultValue(CacheType.HttpRuntime)]
        [Description("Determines if CAPTCHA codes are stored in HttpRuntime (fast, but local to current server) or Session (more portable across web farms).")]
        [Category("Captcha")]
        public CacheType CacheStrategy
        {
            get
            {
                return this.cacheStrategy;
            }

            set
            {
                this.cacheStrategy = value;
            }
        }

        [DefaultValue(3)]
        [Description("Minimum number of seconds CAPTCHA must be displayed before it is valid. If you're too fast, you must be a robot. Set to zero to disable.")]
        [Category("Captcha")]
        public int CaptchaMinTimeout
        {
            get
            {
                return this.timeoutSecondsMin;
            }

            set
            {
                if (value > 15)
                {
                    throw new ArgumentOutOfRangeException("CaptchaMinTimeout", "Timeout must be less than 15 seconds. Humans aren't that slow!");
                }
                else
                {
                    this.timeoutSecondsMin = value;
                }
            }
        }

        [DefaultValue(90)]
        [Description("Maximum number of seconds CAPTCHA will be cached and valid. If you're too slow, you may be a CAPTCHA hack attempt. Set to zero to disable.")]
        [Category("Captcha")]
        public int CaptchaMaxTimeout
        {
            get
            {
                return this.timeoutSecondsMax;
            }

            set
            {
                if ((value < 15) && (value != 0))
                {
                    throw new ArgumentOutOfRangeException("CaptchaMaxTimeout", "Timeout must be greater than 15 seconds. Humans can't type that fast!");
                }
                else
                {
                    this.timeoutSecondsMax = value;
                }
            }
        }

        [DefaultValue("")]
        [Description("Font used to render CAPTCHA text. If font name is blank, a random font will be chosen.")]
        [Category("Captcha")]
        public string CaptchaFont
        {
            get
            {
                return this.font;
            }

            set
            {
                this.font = value;
                this.captcha.FontFamilyName = value;
            }
        }

        [DefaultValue("ACDEFGHJKLMNPQRTUVWXY34679")]
        [Description("Characters used to render CAPTCHA text. A character will be picked randomly from the string.")]
        [Category("Captcha")]
        public string CaptchaChars
        {
            get
            {
                return this.captcha.TextChars;
            }

            set
            {
                this.captcha.TextChars = value;
            }
        }

        [DefaultValue(5)]
        [Description("Number of CaptchaChars used in the CAPTCHA text")]
        [Category("Captcha")]
        public int CaptchaLength
        {
            get
            {
                return this.captcha.TextLength;
            }

            set
            {
                this.captcha.TextLength = value;
            }
        }

        [DefaultValue(50)]
        [Description("Height of generated CAPTCHA image.")]
        [Category("Captcha")]
        public int CaptchaHeight
        {
            get
            {
                return this.captcha.Height;
            }

            set
            {
                this.captcha.Height = value;
            }
        }

        [DefaultValue(180)]
        [Description("Width of generated CAPTCHA image.")]
        [Category("Captcha")]
        public int CaptchaWidth
        {
            get
            {
                return this.captcha.Width;
            }

            set
            {
                this.captcha.Width = value;
            }
        }

        [DefaultValue(CaptchaImage.FontWarpFactor.Low)]
        [Description("Amount of random font warping used on the CAPTCHA text")]
        [Category("Captcha")]
        public CaptchaImage.FontWarpFactor CaptchaFontWarping
        {
            get
            {
                return this.captcha.FontWarp;
            }

            set
            {
                this.captcha.FontWarp = value;
            }
        }

        [DefaultValue(CaptchaImage.BackgroundNoiseLevel.Low)]
        [Description("Amount of background noise to generate in the CAPTCHA image")]
        [Category("Captcha")]
        public CaptchaImage.BackgroundNoiseLevel CaptchaBackgroundNoise
        {
            get
            {
                return this.captcha.BackgroundNoise;
            }

            set
            {
                this.captcha.BackgroundNoise = value;
            }
        }

        [DefaultValue(CaptchaImage.LineNoiseLevel.None)]
        [Description("Add line noise to the CAPTCHA image")]
        [Category("Captcha")]
        public CaptchaImage.LineNoiseLevel CaptchaLineNoise
        {
            get
            {
                return this.captcha.LineNoise;
            }

            set
            {
                this.captcha.LineNoise = value;
            }
        }

        public override ControlCollection Controls
        {
            get
            {
                this.EnsureChildControls();
                return base.Controls;
            }
        }

        protected override HtmlTextWriterTag TagKey
        {
            get
            {
                return HtmlTextWriterTag.Div; // otherwise control is enclosed in span
            }
        }

        private bool IsDesignMode
        {
            get
            {
                return (HttpContext.Current == null);
            }
        }

        #endregion

        public void Validate() // IValidator - empty (validation in LoadPostData)
        {
        }

        public bool LoadPostData(string postDataKey, NameValueCollection postCollection) // IPostBackDataHandler
        {
            string userEntry = postCollection[UniqueID + "$" + this.captchaInputID];
            // ((TextBox)this.FindControl(this.captchaInputID)).Text = string.Empty; // can't remove previously entered text, because of validator
            this.ValidateCaptcha(userEntry);
            return false;
        }

        public void RaisePostDataChangedEvent() // IPostBackDataHandler - empty
        {
        }

        protected override void LoadControlState(object savedState)
        {
            if (savedState != null)
            {
                this.previousGuid = (string)savedState;
            }
        }

        protected override object SaveControlState()
        {
            return (object)this.captcha.UniqueId;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            Page.RegisterRequiresControlState(this);
            Page.Validators.Add(this);
        }

        protected override void OnPreRender(EventArgs e)
        {
            if (this.Visible == true)
            {
                if (this.IsDesignMode == false)
                {
                    if (this.cacheStrategy == CacheType.HttpRuntime)
                    {
                        HttpRuntime.Cache.Add(this.captcha.UniqueId, this.captcha, null, DateTime.Now.AddSeconds((double)(this.CaptchaMaxTimeout == 0 ? 90 : this.CaptchaMaxTimeout)), TimeSpan.Zero, CacheItemPriority.NotRemovable, null);
                    }
                    else
                    {
                        HttpContext.Current.Session.Add(this.captcha.UniqueId, this.captcha);
                    }
                }
            }

            base.OnPreRender(e);

            if (Page != null)
            {
                Page.RegisterRequiresPostBack(this);
            }
        }

        protected override void CreateChildControls()
        {
            this.Controls.Clear();

            //// master DIV
            Literal openingDivs = new Literal();
            openingDivs.Text = "<div";
            if (string.IsNullOrEmpty(CssClass) == false)
            {
                openingDivs.Text += " class='" + CssClass + "'";
            }

            openingDivs.Text += this.GenerateCssStyle();
            openingDivs.Text += ">";

            //// image DIV/SPAN
            if (this.LayoutStyle == Layout.Vertical)
            {
                openingDivs.Text += "<div style='text-align:center;margin:5px;'>";
            }
            else
            {
                openingDivs.Text += "<span style='margin:5px;float:left;'>";
            }

            this.Controls.Add(openingDivs);

            //// image - its URL triggers the CaptchaImageHandler
            Literal image = new Literal();

            image.Text = "<img src=\"CaptchaImage.aspx";
            if (this.IsDesignMode == false)
            {
                image.Text += "?guid=" + this.captcha.UniqueId;
            }

            if (this.CacheStrategy == CacheType.Session)
            {
                image.Text += "&useSession=1";
            }

            image.Text += "\" border=\"0\"";

            if (ToolTip.Length > 0)
            {
                image.Text += " alt=\"" + ToolTip + "\"";
            }

            image.Text += " width=\"" + this.captcha.Width + "\"";
            image.Text += " height=\"" + this.captcha.Height + "\"";
            image.Text += "/>";

            this.Controls.Add(image);

            Literal divsContinue = new Literal();

            if (this.LayoutStyle == Layout.Vertical)
            {
                divsContinue.Text = "</div>";
            }
            else
            {
                divsContinue.Text = "</span>";
            }

            //// text input and submit button DIV/SPAN
            if (this.LayoutStyle == Layout.Vertical)
            {
                divsContinue.Text += "<div style='text-align:center;margin:5px;'>";
            }
            else
            {
                divsContinue.Text += "<span style='margin:5px;float:left;'>";
            }

            divsContinue.Text += Resources.enterCode;
            divsContinue.Text += "<br/>";

            this.Controls.Add(divsContinue);

            TextBox input = new TextBox();
            input.ID = this.captchaInputID;

            input.Attributes.Add("size", this.captcha.TextLength.ToString());
            input.MaxLength = this.captcha.TextLength;

            input.AccessKey = AccessKey;
            input.Enabled = this.Enabled;
            input.TabIndex = TabIndex;
            input.Text = string.Empty;

            input.EnableViewState = false;

            this.Controls.Add(input);

            RequiredFieldValidator reqField = new RequiredFieldValidator();
            reqField.ID = "CaptchaInputValidator";
            reqField.ControlToValidate = this.captchaInputID;
            reqField.Text = "*";
            reqField.ErrorMessage = Resources.textInputFieldRequired;
            reqField.Display = ValidatorDisplay.Dynamic;
            this.Controls.Add(reqField);

            Literal closingDivs = new Literal();

            if (this.LayoutStyle == Layout.Vertical)
            {
                closingDivs.Text = "</div>";
            }
            else
            {
                closingDivs.Text = "</span>";
                closingDivs.Text += "<br clear='all'/>";
            }

            //// closing tag for master DIV
            closingDivs.Text += "</div>";

            this.Controls.Add(closingDivs);
        }

        protected override void OnUnload(EventArgs e)
        {
            if (Page != null)
            {
                Page.Validators.Remove(this);
            }

            base.OnUnload(e);
        }

        private CaptchaImage GetCachedCaptcha(string guid)
        {
            if (this.cacheStrategy == CacheType.HttpRuntime)
            {
                return (CaptchaImage)HttpRuntime.Cache.Get(guid);
            }
            else
            {
                return (CaptchaImage)HttpContext.Current.Session[guid];
            }
        }

        private void RemoveCachedCaptcha(string guid)
        {
            if (this.cacheStrategy == CacheType.HttpRuntime)
            {
                HttpRuntime.Cache.Remove(guid);
            }
            else
            {
                HttpContext.Current.Session.Remove(guid);
            }
        }

        private void ValidateCaptcha(string userEntry)
        {
            if ((this.Visible == false) || (this.Enabled == false))
            {
                this.userValidated = true;
                return;
            }

            //// retrieve the previous captcha from the cache to inspect its properties
            CaptchaImage ci = this.GetCachedCaptcha(this.previousGuid);
            if (ci == null)
            {
                this.ErrorMessage = string.Format(Resources.codeExpired, this.CaptchaMaxTimeout);
                this.userValidated = false;

                return;
            }

            //// was it entered too quickly?
            if (this.CaptchaMinTimeout > 0)
            {
                if (ci.RenderedAt.AddSeconds(this.CaptchaMinTimeout) > DateTime.Now)
                {
                    this.userValidated = false;
                    this.ErrorMessage = string.Format(Resources.codeTypedTooQuickly, this.CaptchaMinTimeout);
                    this.RemoveCachedCaptcha(this.previousGuid);

                    return;
                }
            }

            if (String.Compare(userEntry, ci.Text, true, CultureInfo.CurrentCulture) != 0)
            {
                this.ErrorMessage = Resources.textDoesNotMatch;
                this.userValidated = false;
            }
            else
            {
                this.userValidated = true;
            }

            this.RemoveCachedCaptcha(this.previousGuid);
        }

        private string GenerateCssStyle()
        {
            StringBuilder cssStyle = new StringBuilder();
            string color;

            cssStyle.Append(" style='");

            if (BorderWidth.ToString().Length > 0)
            {
                cssStyle.Append("border-width:");
                cssStyle.Append(BorderWidth.ToString());
                cssStyle.Append(";");
            }

            if (BorderStyle != BorderStyle.NotSet)
            {
                cssStyle.Append("border-style:");
                cssStyle.Append(BorderStyle.ToString());
                cssStyle.Append(";");
            }

            color = this.GetHtmlColor(BorderColor);
            if (color.Length > 0)
            {
                cssStyle.Append("border-color:");
                cssStyle.Append(color);
                cssStyle.Append(";");
            }

            color = this.GetHtmlColor(BackColor);
            if (color.Length > 0)
            {
                cssStyle.Append("background-color:" + color + ";");
            }

            color = this.GetHtmlColor(ForeColor);
            if (color.Length > 0)
            {
                cssStyle.Append("color:" + color + ";");
            }

            if (this.Font.Bold == true)
            {
                cssStyle.Append("font-weight:bold;");
            }

            if (Font.Italic == true)
            {
                cssStyle.Append("font-style:italic;");
            }

            if (Font.Underline == true)
            {
                cssStyle.Append("text-decoration:underline;");
            }

            if (Font.Strikeout == true)
            {
                cssStyle.Append("text-decoration:line-through;");
            }

            if (Font.Overline == true)
            {
                cssStyle.Append("text-decoration:overline;");
            }

            if (Font.Size.ToString().Length > 0)
            {
                cssStyle.Append("font-size:" + Font.Size.ToString() + ";");
            }

            if (Font.Names.Length > 0)
            {
                cssStyle.Append("font-family:");
                foreach (string fontFamily in Font.Names)
                {
                    cssStyle.Append(fontFamily);
                    cssStyle.Append(",");
                }

                cssStyle.Length = cssStyle.Length - 1;
                cssStyle.Append(";");
            }

            if (string.IsNullOrEmpty(Height.ToString()) == false)
            {
                cssStyle.Append("height:" + Height.ToString() + ";");
            }

            if (string.IsNullOrEmpty(Width.ToString()) == false)
            {
                cssStyle.Append("width:" + Width.ToString() + ";");
            }

            cssStyle.Append("'");

            if (cssStyle.ToString() == " style=''")
            {
                return string.Empty;
            }
            else
            {
                return cssStyle.ToString();
            }
        }

        private string GetHtmlColor(Color color)
        {
            if (color.IsEmpty == true)
            {
                return string.Empty;
            }

            if (color.IsNamedColor == true)
            {
                return color.ToKnownColor().ToString();
            }

            if (color.IsSystemColor == true)
            {
                return color.ToString();
            }

            return "#" + color.ToArgb().ToString("x").Substring(2);
        }
    }
}