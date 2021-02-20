﻿<%@ Page Title="Reprovados" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Avaliador.Rejected.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../ControllersJS/General.css" rel="stylesheet" />

    <div class="container-fluid">
        <div class="row">
            <%--SEARCH--%>
            <div class="col-sm w-65 pl-2 pr-2" style="max-width: 22%;">
                <div class="card mb-2">
                    <h5 class="card-header" onclick="closeSearch()">Pesquisa</h5>
                    <div class="collapse show" id="divBodyEditionImage">
                        <div class="card-body p-1">
                            <div class="text-center">
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="rdoLote" class="custom-control-input"
                                        onclick="checkLote()" checked>
                                    <label class="custom-control-label" for="rdoLote">Lote</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="rdoIntervalo" class="custom-control-input"
                                        onclick="checkIntervalo()">
                                    <label class="custom-control-label" for="rdoIntervalo">Intervalo</label>
                                </div>
                            </div>

                            <div class="p-1" id="dvSearchLote">
                                <input type="text" class="form-control mw-100" id="txtLote" placeholder="Lote">
                            </div>

                            <div id="dvDateStarEnd" style="display: none;">
                                <div class="p-1">
                                    <input type="date" class="form-control mw-100" id="txtDateStart">
                                </div>
                                <div class="p-1">
                                    <input type="date" class="form-control mw-100" id="txtDateEnd">
                                </div>
                            </div>

                            <div class="p-1">
                                <button type="button" class="btn btn-secondary"
                                    id="btnEqp" onclick="editEqp(this)" value="btn">
                                    Equipamento
                                </button>
                                <button type="button" class="btn btn-primary"
                                    id="btnSearch" onclick="searchEqp()">
                                    Pesquisar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <h5 class="card-header" onclick="closeListImages()">Lista de Imagens</h5>
                    <div class="collapse show" id="divBodyListImages">
                        <div class="card-body p-2">
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm mb-0" id="tblListImages">
                                    <thead>
                                        <tr>
                                            <th>Imagem</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbListImages">
                                        <tr>
                                            <td colspan="3">Não há resgistros!</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--IMAGE--%>
            <div class="col-sm pr-0 pl-0">
                <div class="card">
                    <h5 class="card-header" style="padding: 0.3rem;">
                        <div class="row pl-pr-2r">
                            <label class="mb-0 align-self-center mr-1">Município:</label>
                            <select class="form-control w-50" id="sleMunicipio" onchange="editEqp(this)"
                                value="sle">
                            </select>
                        </div>
                    </h5>
                    <div class="card-body p-0" style="height: 40.3rem;">
                        <img src="../Images/fotoMultaMoto.png" class="img-fluid" alt="Responsive image">
                    </div>
                </div>
            </div>

            <%--INFO--%>
            <div class="col-sm pb-0 pr-2 pl-2" style="max-width: 28%;">
                <div class="card mb-2 float-right w-100">
                    <h5 class="card-header" onclick="closeEquipment()">Equipamento:
                    <label class="mb-0" id="lblEquipamento"></label>
                    </h5>
                    <div class="collapse show" id="divBodyEquipment">
                        <div class="card-body p-2">
                            <div class="input-group-sm">
                                <label class="mb-0">Município:</label>
                                <label id="lblMunicipio"></label>
                            </div>
                            <div class="input-group-sm divider-eqp">
                                <label class="mb-1 mt-1" id="lblEndereco">Endereço:</label>
                            </div>

                            <div class="row row-cols-2 divider-eqp">
                                <div class="col input-group-sm pr-0 pl-0">
                                    <label class="mb-0 mt-1">Faixa:</label>
                                    <br />
                                    <label class="mb-0" id="lblFaixa"></label>
                                </div>
                                <div class="col input-group-sm">
                                    <label class="mb-0 mt-1">Velocidade da via:</label>
                                    <br />
                                    <label class="mb-0" id="lblVelocidadeViaEqp"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-2 float-right w-100">
                    <h5 class="card-header" onclick="closeEnquadramentos()">Enquadramentos</h5>
                    <div class="collapse show" id="divBodyEnquadramento">
                        <div class="card-body p-2">
                            <div class="input-group-sm">
                                <label class="mb-1">Data:</label>
                                <label class="mb-1" id="dtHrEnquadramento"></label>
                            </div>

                            <div class="row row-cols-3 divider-eqp">
                                <div class="col input-group-sm pl-0">
                                    <label class="mb-0 mt-1">Vel. Medida:</label>
                                    <br />
                                    <label class="mb-1" id="lblVelMedida"></label>
                                </div>
                                <div class="col input-group-sm pl-0 pr-0">
                                    <label class="mb-0 mt-1">Vel. Considerada:</label>
                                    <label class="mb-1" id="lblVelConsiderada"></label>
                                </div>
                                <div class="col input-group-sm pr-0">
                                    <label class="mb-0 mt-1">Tam. Veículo:</label>
                                    <label class="mb-1" id="lblTamanhoVeiculo"></label>
                                </div>
                            </div>
                            <div class="row row-cols-3 divider-eqp">
                                <div class="col input-group-sm pl-0">
                                    <label class="mb-0 mt-1">Tempo SV:</label>
                                    <br />
                                    <label class="mb-0 mt-0" id="lblTempoSV"></label>
                                </div>
                                <div class="col input-group-sm pl-0 pr-0">
                                    <label class="mb-0 mt-1">Tempo Ocup.:</label>
                                    <label class="mb-0 mt-0" id="lblTempoOcup"></label>
                                </div>
                                <div class="col input-group-sm pr-0">
                                    <label class="mb-0 mt-1 font-weight-bold" style="color: rgb(220 53 69);">Lote:</label>
                                    <br />
                                    <label class="mb-0 mt-0 font-weight-bold" style="color: rgb(220 53 69);"
                                        id="lblLote">
                                    </label>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-bordered table-sm mb-0 mt-1" id="tblEnquadramentos">
                                    <thead>
                                        <tr>
                                            <th style="width: 4rem;">Cód.</th>
                                            <th>Descrição</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbEnquadramentos">
                                        <tr>
                                            <td colspan="2">Não há resgistros!</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalEqp">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Equipamentos</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div>
                        <ul class="ks-cboxtags mb-0" id="ulEqps">
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <div style="width: 88%; margin-right: 0;">
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="chkAll"
                                onclick="markAll()" checked>
                            <label class="custom-control-label" for="chkAll">Todos</label>
                        </div>
                        <%--<div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="chkAll"
                                onclick="markAll()">
                            <label class="custom-control-label" for="chkAll">Todos</label>
                        </div>--%>
                    </div>

                    <button type="button" class="btn btn-primary" data-dismiss="modal">Aplicar</button>
                    <%--<button type="button" class="btn btn-outline-secondary"
                        data-dismiss="modal">
                        Fechar</button>--%>
                </div>
            </div>
        </div>
    </div>

    <script src="../ControllersJS/General.js"></script>

    <script>
        var eqpsSelecteds = [];
        var listImagesRejecteds = [];
        var indexImageRejected = 0;
        $(function () {
        });

        //#region close/open panels
        function closeSearch() {

            if ($("#divBodyEditionImage")[0].className == "collapse" ||
                $("#divBodyEditionImage")[0].className == "hide collapse") {

                $("#divBodyEditionImage").removeClass("collapse");
                $("#divBodyEditionImage").addClass("collapse show");
            }
            else {
                $("#divBodyEditionImage").removeClass("collapse show");
                $("#divBodyEditionImage").addClass("hide collapse");
            }
        }

        function closeListImages() {

            if ($("#divBodyListImages")[0].className == "collapse" ||
                $("#divBodyListImages")[0].className == "hide collapse") {

                $("#divBodyListImages").removeClass("collapse");
                $("#divBodyListImages").addClass("collapse show");
            }
            else {
                $("#divBodyListImages").removeClass("collapse show");
                $("#divBodyListImages").addClass("hide collapse");
            }
        }

        function closeEquipment() {

            if ($("#divBodyEquipment")[0].className == "collapse" ||
                $("#divBodyEquipment")[0].className == "hide collapse") {

                $("#divBodyEquipment").removeClass("collapse");
                $("#divBodyEquipment").addClass("collapse show");
            }
            else {
                $("#divBodyEquipment").removeClass("collapse show");
                $("#divBodyEquipment").addClass("hide collapse");
            }
        }

        function closeEnquadramentos() {

            if ($("#divBodyEnquadramento")[0].className == "collapse" ||
                $("#divBodyEnquadramento")[0].className == "hide collapse") {

                $("#divBodyEnquadramento").removeClass("collapse");
                $("#divBodyEnquadramento").addClass("collapse show");
            }
            else {
                $("#divBodyEnquadramento").removeClass("collapse show");
                $("#divBodyEnquadramento").addClass("hide collapse");
            }
        }
        //#endregion

        function checkLote() {

            $("#rdoLote")[0].checked = true;
            $("#rdoIntervalo")[0].checked = false;
            $("#dvDateStarEnd").hide();
            $("#dvSearchLote").show();
            $("#txtDateStart").val("");
            $("#txtDateEnd").val("");
        }

        function checkIntervalo() {

            $("#rdoIntervalo")[0].checked = true;
            $("#rdoLote")[0].checked = false;
            $("#dvSearchLote").hide();
            $("#dvDateStarEnd").show();
            $("#txtLote").val("");
        }

        function editEqp(value) {

            if (value.id == "btnEqp") {

                if ($("#sleMunicipio").val() == "") {

                    Swal.fire({
                        text: 'Selecione um município!',
                        showClass: {
                            popup: 'animate__bounceIn'
                        },
                        hideClass: {
                            popup: 'animate__flipOutX'
                        }
                    });

                    return;
                }

                $("#ulEqps").empty();
                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/editEqps',
                    dataType: 'json',
                    data: "{'idMunicipio':'" + $("#sleMunicipio").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        $("#divLoading").css("display", "block");

                        var i = 0;
                        while (data.d[i]) {
                            var lst = data.d[i];
                            var permission = "";

                            permission += `<li> 
                                       <input type='checkbox' id='chk${lst.Value}'
                                       onchange='addOrRemoveEqp(this)' value='${lst.Value}' checked>
                                       <label for='chk${lst.Value}'>${lst.Value}</label>
                                       </li>`;

                            $("#ulEqps").append(permission);
                            eqpsSelecteds.push(lst.Value);

                            i++;
                        }

                        $("#divLoading").css("display", "none");
                        $("#modalEqp").modal("show");
                    },
                    error: function (data) {
                        $("#divLoading").css("display", "none");
                        Swal.fire({
                            text: 'Ocorreu algum erro, atualize a página novamente!',
                            showClass: {
                                popup: 'animate__bounceIn'
                            },
                            hideClass: {
                                popup: 'animate__flipOutX'
                            }
                        });
                    }
                });
            }
            else {

                if ($("#sleMunicipio").val() == "") {

                    Swal.fire({
                        text: 'Selecione um município!',
                        showClass: {
                            popup: 'animate__bounceIn'
                        },
                        hideClass: {
                            popup: 'animate__flipOutX'
                        }
                    });

                    return;
                }

                $("#ulEqps").empty();
                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/editEqps',
                    dataType: 'json',
                    data: "{'idMunicipio':'" + $("#sleMunicipio").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        $("#divLoading").css("display", "block");

                        var i = 0;
                        while (data.d[i]) {
                            var lst = data.d[i];
                            var permission = "";

                            permission += `<li> 
                                       <input type='checkbox' id='chk${lst.Value}'
                                       onchange='addOrRemoveEqp(this)' value='${lst.Value}' checked>
                                       <label for='chk${lst.Value}'>${lst.Value}</label>
                                       </li>`;

                            $("#ulEqps").append(permission);
                            eqpsSelecteds.push(lst.Value);

                            i++;
                        }

                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {
                        $("#divLoading").css("display", "none");
                        Swal.fire({
                            text: 'Ocorreu algum erro, atualize a página novamente!',
                            showClass: {
                                popup: 'animate__bounceIn'
                            },
                            hideClass: {
                                popup: 'animate__flipOutX'
                            }
                        });
                    }
                });
            }
        }

        function markAll() {

            var ul = $("#ulEqps");
            ul.find('li').each(function (i, el) {
                var li = $(this).find('li').prevObject[0];
                var eqpValue = "";

                if ($("#chkAll")[0].checked) {
                    li.childNodes[1].checked = true;
                    eqpValue = li.childNodes[1].defaultValue;
                    eqpsSelecteds.push(eqpValue);
                }
                else {
                    li.childNodes[1].checked = false;
                    eqpsSelecteds = [];
                }
            });
        }

        function addOrRemoveEqp(value) {

            var equipament = value.defaultValue;
            if (value.checked) {
                eqpsSelecteds.push(equipament);
                if (eqpsSelecteds.length == $("#ulEqps")[0].childNodes.length) {
                    $("#chkAll")[0].checked = true;
                }
            }
            else {
                const index = eqpsSelecteds.indexOf(equipament);
                if (index > -1) {
                    eqpsSelecteds.splice(index, 1);
                    $("#chkAll")[0].checked = false;
                }
            }
        }

        function searchEqp() {

            if ($("#rdoLote")[0].checked) {

                $.ajax({
                    type: 'POST',
                    url: 'Default.aspx/searchEqp',
                    dataType: 'json',
                    data: JSON.stringify({
                        lote: $("#txtLote").val(),
                        eqpsSelecteds: eqpsSelecteds
                    }),
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {

                        $("#divLoading").css("display", "block");
                        var i = 0;
                        while (data.d[i]) {
                            var lst = data.d[i];

                            let imagesRejecteds = {
                                "eqp": lst.eqp,
                                "faixa": lst.faixa,
                                "velMedida": lst.velMedida,
                                "velCons": lst.velCons,
                                "velVia": lst.velVia,
                                "tempoSV": lst.tempoSV,
                                "dtProcess": lst.dtProcess,
                                "logradouro": lst.logradouro,
                                "tOcup": lst.tOcup,
                                "tamanho": lst.tamanho,
                                "agente": lst.agente,
                                "motivo": lst.motivo,
                                "obs": lst.obs,
                                "arquivo": lst.arquivo
                            }

                            listImagesRejecteds.push(imagesRejecteds);
                            i++;
                        }

                        var firstIndex = listImagesRejecteds[0];
                        $("#lblEquipamento")[0].innerHTML = firstIndex.eqp;
                        $("#lblMunicipio")[0].innerHTML = $("#sleMunicipio").find(":selected").text();
                        $("#lblEndereco")[0].innerHTML = "Endereço: " + firstIndex.logradouro;
                        $("#lblFaixa")[0].innerHTML = firstIndex.faixa;
                        $("#lblVelocidadeViaEqp")[0].innerHTML = firstIndex.velVia + "km/h";

                        $("#dtHrEnquadramento")[0].innerHTML = firstIndex.dtProcess;
                        $("#lblVelMedida")[0].innerHTML = firstIndex.velMedida;
                        $("#lblVelConsiderada")[0].innerHTML = firstIndex.velCons;
                        $("#lblTamanhoVeiculo")[0].innerHTML = firstIndex.tamanho;
                        $("#lblTempoSV")[0].innerHTML = firstIndex.tempoSV;
                        $("#lblTempoOcup")[0].innerHTML = firstIndex.tOcup;
                        $("#lblLote ")[0].innerHTML = $("#txtLote").val();

                        indexImageRejected = firstIndex;

                        $("#divLoading").css("display", "none");
                    },
                    error: function (data) {
                        $("#divLoading").css("display", "none");
                        Swal.fire({
                            text: 'Ocorreu algum erro, atualize a página novamente!',
                            showClass: {
                                popup: 'animate__bounceIn'
                            },
                            hideClass: {
                                popup: 'animate__flipOutX'
                            }
                        });
                    }
                });
            }
            else {
                var dtStart = $("#txtDateStart").val();
                var dtEnd = $("#txtDateEnd").val();
            }
        }

        function loadEnquadramento() {

            var adress = "", adressFormated = "";
            adress = $("#lblEndereco").val();
            adressFormated = adress.padStart(4, '0');

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadEnquadramento',
                dataType: 'json',
                data: "{'eqp':'" + $("#lblEquipamento").val() + "', " +
                    " 'endereco':'" + $("#lblEndereco").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {


                }
            });
        }
    </script>
</asp:Content>
