using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Avaliador
{
    public partial class Default : System.Web.UI.Page
    {
        static string user = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string url = Request.QueryString["x"];

                if (string.IsNullOrEmpty(url) == false)
                {
                    string[] nomeCripto = url.Split('@');

                    foreach (var item in nomeCripto)
                    {
                        if (item != "")
                            user += Convert.ToChar(Convert.ToInt32(item) - 1);
                    }
                    MembershipUser usuarioM = Membership.GetUser(user);
                    if (usuarioM == null)
                    {
                        hfUserConected.Value = "0";
                    }
                    else
                    {
                        hfUserConected.Value = user;
                    }
                }
                else
                {
                    hfUserConected.Value = "0";
                }
            }
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
        public static ArrayList loadEquipaments(string idMunicipio)
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

        public struct allData
        {
            public string lote { get; set; }
            public string id { get; set; }
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
            public string motivo { get; set; }
            public string tipoId { get; set; }
            public string mnc { get; set; }
            public string mncDsc { get; set; }
            public string infractionId { get; set; }
            public string infractionDsc { get; set; }
            public string infractions { get; set; }
            public string numberPlate { get; set; }
        }

        [WebMethod]
        public static List<allData> loadAllData(string idMunicipio, string[] Eqps)
        {
            List<allData> lst = new List<allData>();
            Banco db = new Banco();
            DataTable dt;
            string or = @" or (([FlagProcess]='P' and DATEDIFF(hour,DtProcess,GETDATE()) <=1)) and usuario='" + user + "' ";
            string eqps = "";
            string mnc = "";

            try
            {
                string sql = @"SELECT top 1 Id Codigo,Equipamento Eqp,(select Tipo from eqp where Serie=Equipamento) TipoId,Faixa,DtHr,Lote,Mnc, 
                    (SELECT Municipio.Dsc + ' - ' +Municipio.Uf FROM Municipio WHERE Municipio.Id=Process.Mnc) mncDsc, 
                    Logradouro,Enquadramento,(SELECT Enq.sDsc FROM Enq WHERE Enq.iId=Process.Enquadramento) EnqDsc,'' Enqs,
                    Placa,Tamanho,VelMedida,VelCons,VelVia, TOcup,TempoSV,Agente FROM Process
                    WHERE (ISNULL([FlagProcess],'')='' or ([FlagProcess]='P' and DATEDIFF(hour,DtProcess,GETDATE()) >=1))";

                if (!string.IsNullOrEmpty(idMunicipio) && idMunicipio != "999666999")
                {
                    mnc = " and Mnc =" + idMunicipio;
                    if (Eqps != null)
                    {
                        if (Eqps.Length > 0)
                            eqps = string.Format(" AND Equipamento IN ('{0}') ", string.Join("','", Eqps));
                    }
                }
                else
                {
                    dt = db.ExecuteReaderQuery(
                        @"select SUBSTRING(r.RoleName,0,5) mncId from dbo.aspnet_UsersInRoles ur 
                        join dbo.aspnet_Roles r on ur.RoleId=r.RoleId
                        join  dbo.aspnet_Users u on u.UserId=ur.UserId 
                        where ISNUMERIC(SUBSTRING(r.RoleName,0,5))=1 and u.UserName='" + user + "'"
                        );

                    int i = 1;
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (i != 1)
                            mnc = mnc + ",";

                        mnc = mnc + dr["mncId"].ToString();
                        i++;
                    }
                    dt.Clear();
                    if (mnc != "")
                        mnc = " and Mnc in (" + mnc + ")";
                }

                sql = sql + mnc;
                sql = sql + eqps;
                sql = sql + or;
                sql = sql + mnc;
                sql = sql + eqps;
                sql = sql + " ORDER BY CONVERT(DATETIME,[DtHr],103)";

                dt = db.ExecuteReaderQuery(sql);

                foreach (DataRow dr in dt.Rows)
                {
                    lst.Add(new allData
                    {
                        lote = dr["lote"].ToString(),
                        id = dr["codigo"].ToString(),
                        eqp = dr["eqp"].ToString(),
                        faixa = dr["faixa"].ToString(),
                        velMedida = dr["velMedida"].ToString(),
                        velCons = dr["velCons"].ToString(),
                        velVia = dr["velVia"].ToString(),
                        tempoSV = dr["tempoSV"].ToString(),
                        dtProcess = dr["DtHr"].ToString(),
                        logradouro = dr["logradouro"].ToString(),
                        tOcup = dr["TOcup"].ToString(),
                        tamanho = dr["Tamanho"].ToString(),
                        tipoId = dr["tipoId"].ToString(),
                        mnc = dr["mnc"].ToString(),
                        mncDsc = dr["mncDsc"].ToString(),
                        infractionId = dr["Enquadramento"].ToString(),
                        infractionDsc = dr["EnqDsc"].ToString(),
                        infractions = dr["Enqs"].ToString(),
                        numberPlate = dr["placa"].ToString()
                    });

                    //Id = Convert.ToInt32(dr["Codigo"]);
                    //EqpId = dr["Eqp"].ToString();
                    //TipoId = Convert.ToInt32(dr["TipoId"]);
                    //Track = Convert.ToInt32(dr["Fx"]);
                    //DtTraf = dr["Dt"].ToString();
                    //Mnc = Convert.ToInt32(dr["mnc"]);
                    //MncDsc = dr["mncDsc"].ToString();
                    //Logr = dr["Lgr"].ToString();
                    //InfractionId = Convert.ToInt32(dr["Enq"]);
                    //InfractionDsc = dr["EnqDsc"].ToString();
                    //Infractions = dr["Enqs"].ToString();
                    //NumberPlate = dr["Plc"].ToString();
                    //Size = dr["Tam"].ToString();
                    //SpeedMeasured = Convert.ToDouble(dr["velM"]);
                    //SpeedConsidered = Convert.ToDouble(dr["velC"]);
                    //SpeedLimit = Convert.ToDouble(dr["velV"]);
                    //TimeOccupancy = dr["TOcup"].ToString() == "" ? 0 : Convert.ToDouble(dr["TOcup"]);
                    //TimeSvOn = dr["Sv"].ToString() == "" ? 0 : Convert.ToDouble(dr["Sv"]);
                    //Agente = dr["ag"].ToString();
                    //Lote = dr["Lote"].ToString();
                }

                db.ExecuteNonQuery(string.Format(
                    @"UPDATE Process SET DtProcess = GETDATE(),FlagProcess='P',Usuario = '{0}'
                    WHERE Id={1}", user, lst[0].id
                    ));

                return lst;
            }
            catch (Exception)
            {

                return lst;
            }
        }

        [WebMethod]
        public static string validateProcess(string idProcess, bool valido, string usuario, string placa,
            string idMotivoRejeicao, string obsRejeito)
        {
            try
            {
                Banco db = new Banco();
                    
                if (!db.ExecuteNonQuery(string.Format(
                    @"UPDATE Process SET Placa='{0}', FlagProcess='E', Valido='{1}', dtAval='{4}',
                    Usuario='{2}' WHERE id={3}", placa, valido, usuario, idProcess,
                    DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss.fff"))))
                {
                    return "Erro ao salvar no banco";
                }

                if (valido == false)
                {
                    try
                    {
                        db.ClearSQLParams();
                        db.AddSQLParam("Idprocess", idProcess);
                        db.AddSQLParam("Motivo", idMotivoRejeicao);
                        db.AddSQLParam("Obs", obsRejeito);
                        if (!db.ExecuteNonQueryStoredProcedure("InsertLogRejeicaoProcess", true))
                            return "Erro ao salvar no banco";
                    }
                    catch (Exception er)
                    {
                        return er.Message;
                    }
                }

            }
            catch (Exception er)
            {
                return "false";
            }

            return "true";
        }
    }
}