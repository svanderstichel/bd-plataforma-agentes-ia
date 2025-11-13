using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaIA.UI.Webforms
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
        }

        public string IsActive(string pagina)
        {
            string url = Request.Url.AbsolutePath.ToLower();
            return url.Contains(pagina.ToLower()) ? "active" : "";
        }
    }
}