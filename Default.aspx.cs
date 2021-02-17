using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Avaliador
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static ArrayList loadMunicipio()
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco();

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT DISTINCT e.Mnc, (m.Dsc+' - '+m.Uf)Cidade FROM dbo.Eqp e JOIN dbo.Municipio m 
                ON m.Id = e.Mnc ORDER BY Cidade"
                );

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(
                    dr["Cidade"].ToString(),
                    dr["Mnc"].ToString()
                    ));
            }

            return lst;
        }
    }
}