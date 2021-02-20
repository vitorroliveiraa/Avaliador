using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Avaliador.Rejected
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

        [WebMethod]
        public static ArrayList editEqps(string idMunicipio)
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco();

            DataTable dt = db.ExecuteReaderQuery(
                @"SELECT Serie FROM dbo.Eqp WHERE Mnc=" + idMunicipio + " ORDER BY Serie"
                );


            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(
                    dr["Serie"].ToString()
                    ));
            }

            return lst;
        }

        public struct equipament
        {
            public string eqp { get; set; }
            public string faixa { get; set; }
            public string velMedida { get; set; }
            public string velCons { get; set; }
            public string velVia { get; set; }
            public string tempoSV { get; set; }
            public string dtProcess { get; set; }
            public string logradouro { get; set; }
            public string tOcup { get; set; }
            public string tamanho { get; set; }
            public string agente { get; set; }
            public string motivo { get; set; }
            public string obs { get; set; }
            public string arquivo { get; set; }
        }

        [WebMethod]
        public static List<equipament> searchEqp(string lote, string[] eqpsSelecteds)
        {
            List<equipament> lst = new List<equipament>();
            Banco db = new Banco();

            string sql = "";
            sql += @"(select p.equipamento eqp,p.Faixa,VelMedida,VelCons,VelVia,TempoSV,DtProcess,Logradouro,[TOcup],[Tamanho],
                   Agente, motivo=(select dsc from motivo m where m.id=r.motivo), obs,
                   arquivo='http://sistemas.cobrasin.com.br:9091/imgLotes/'+p.equipamento+'/'+p.lote+'/'+replace(CONVERT(VARCHAR(10),p.dthr,110),'/','_') 
                   +'/'+ LEFT(substring(i.path,charindex('\',i.path,55)+1, len(i.path)), 
                   case when(PATINDEX('%Pan%', substring(i.path,charindex('\',i.path,55)+1, len(i.path)-3)))=0 
                   then (PATINDEX('%Zo%', substring(i.path,charindex('\',i.path,55)+1, len(i.path)-3))) else
                   (PATINDEX('%Pan%', substring(i.path,charindex('\',i.path,55)+1, len(i.path)-3))) end-1)+'.jpg'
                   from process p join logrejeicao r on r.idprocess=p.id join imageprocess i on i.process=p.id 
                   where p.valido=0 and p.lote='" + lote + "' and equipamento in ('" + string.Join("','", eqpsSelecteds) + "')) ";

            DataTable dt = db.ExecuteReaderQuery(sql);

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new equipament
                {
                    eqp = dr["eqp"].ToString(),
                    faixa = dr["faixa"].ToString(),
                    velMedida = dr["velMedida"].ToString(),
                    velCons = dr["velCons"].ToString(),
                    velVia = dr["velVia"].ToString(),
                    tempoSV = dr["tempoSV"].ToString(),
                    dtProcess = dr["dtProcess"].ToString(),
                    logradouro = dr["logradouro"].ToString(),
                    tOcup = dr["TOcup"].ToString(),
                    tamanho = dr["Tamanho"].ToString(),
                    agente = dr["agente"].ToString(),
                    motivo = dr["motivo"].ToString(),
                    obs = dr["obs"].ToString(),
                    arquivo = dr["arquivo"].ToString()
                });
            }

            return lst;
        }

        [WebMethod]
        public static ArrayList getEnquadramentos(string eqp, string endereco, string lote)
        {
            ArrayList lst = new ArrayList();
            Banco db = new Banco();
            DataTable dt = db.ExecuteReaderQuery(
                @" distinct enquadramento cod,enquadramento=(select sdsc from enq e where e.iId =p.Enquadramento)  
                from process p where equipamento='" + eqp + "' and logradouro='" + endereco + "' " +
                " and lote='" + lote + "' "
                );

            foreach (DataRow dr in dt.Rows)
            {
                lst.Add(new ListItem(
                    dr["cod"].ToString(),
                    dr["enquadramento"].ToString()
                    ));
            }

            return lst;
        }
    }
}