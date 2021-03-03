﻿<%@ Page Title="Avaliador" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Avaliador.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="ControllersJS/General.css" rel="stylesheet" />

    <asp:HiddenField ID="hfUserConected" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfidProcess" ClientIDMode="Static" runat="server" />

    <div id="dvHome">
        <div class="container-fluid">
            <div class="row">
                <%--EDITION IMAGE--%>
                <div class="col-sm w-65 pl-2 pr-2" style="max-width: 22%;">
                    <div class="card mb-2" style="display: none;">
                        <h5 class="card-header" onclick="closeEditionImage()">Edição e Tratamento</h5>
                        <div class="collapse show" id="divBodyEditionImage">
                            <div class="card-body p-1">
                                <div class="card text-center">
                                    <div class="card-header">
                                        <ul class="nav nav-tabs card-header-tabs">
                                            <li class="nav-item">
                                                <a class="nav-link active" href="#">Imagem</a>
                                            </li>
                                            <div style="width: 66%;">
                                                <button type="button" class="btn btn-light" id="btnUpdateImage"
                                                    onclick="">
                                                    <i class="bi bi-arrow-clockwise"></i>
                                                </button>
                                                <button type="button" class="btn btn-light" id="btnSaveEdition"
                                                    onclick="">
                                                    <i class="bi bi-check-circle-fill"></i>
                                                </button>
                                            </div>
                                        </ul>
                                    </div>
                                    <div class="card-body p-2">
                                        <div class="form-group mb-1">
                                            <label class="mb-0" for="rgBrightness" style="margin-right: 23.5rem;">Brilho</label>
                                            <input type="range" class="form-control-range" id="rgBrightness">
                                        </div>
                                        <div class="form-group mb-1">
                                            <label class="mb-0" for="rgContrast" style="margin-right: 22.5rem;">Contraste</label>
                                            <input type="range" class="form-control-range" id="rgContrast">
                                        </div>
                                        <div class="form-group mb-1">
                                            <label class="mb-0" for="rgContrast" style="margin-right: 22.5rem;">Nevativo</label>
                                            <input type="range" class="form-control-range" id="rgNegative">
                                        </div>

                                        <div class="custom-control custom-checkbox divider-t">
                                            <input type="checkbox" class="custom-control-input" id="chkZoom">
                                            <label class="custom-control-label" for="chkZoom">Zoom</label>
                                        </div>
                                        <div class="form-group divider-b mb-2">
                                            <label class="mb-0" for="rgContrast" style="margin-right: 22.5rem;">Tamanho</label>
                                            <input type="range" class="form-control-range" id="rgSize">
                                        </div>

                                        <div class="row row-cols-2 mb-0">
                                            <div class="col">
                                                <div class="custom-control custom-checkbox">
                                                    <input type="checkbox" class="custom-control-input" id="chkCut">
                                                    <label class="custom-control-label" for="chkCut">Recortar</label>
                                                </div>
                                            </div>
                                            <div class="col">
                                                <button type="button" class="btn btn-outline-dark" id="btnCutImage"
                                                    onclick="">
                                                    <i class="bi bi-scissors"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="card" style="display: none;">
                        <h5 class="card-header" onclick="closeListImages()">Lista de Imagens</h5>
                        <div class="collapse show" id="divBodyListImages">
                            <div class="card-body p-2">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-sm mb-0" id="tblListImages">
                                        <thead>
                                            <tr>
                                                <th>Imagem</th>
                                                <th style="width: 1px;">Válido</th>
                                                <th style="width: 1px;">Notificação</th>
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
                                <select class="form-control w-50" id="sleMunicipio" onchange="loadEquipaments(this)">
                                </select>
                                <button type="button" class="btn btn-outline-primary ml-2"
                                    id="btnEqp" onclick="loadEquipaments(this)">
                                    Equipamento
                                </button>
                                <button type="button" class="btn btn-primary ml-2"
                                    id="btnSearch" onclick="loadAllData()">
                                    Pesquisar
                                </button>
                            </div>
                        </h5>
                        <div class="card-body p-0" style="height: 40.3rem;">
                            <img src="Images/fotoMultaMoto.png" class="img-fluid" alt="Responsive image">
                        </div>
                    </div>
                </div>

                <%--INFO--%>
                <div class="col-sm pb-0 pr-2 pl-2" style="max-width: 28%;">
                    <div class="card mb-2 float-right w-100">
                        <h5 class="card-header" style="padding-top: 5px; padding-bottom: 5px; padding-right: 6px;">
                            <label class="mb-0 align-self-center mr-1 margin-t">Veículo</label>
                            <div class="row float-right" style="padding-right: 1rem;">
                                <button type="button" class="btn btn-success"
                                    id="btnAprovar" onclick="validateProcess(true)">
                                    Aprovar
                                </button>
                                <button type="button" class="btn btn-danger ml-1"
                                    id="btnReprovar" data-toggle="modal" data-target="#modalConfirmRejection"
                                    onclick="getMotivo()">
                                    Reprovar
                                </button>
                            </div>
                        </h5>
                        <div class="collapse show" id="divBodyCar">
                            <div class="card-body p-2">
                                <div class="input-group">
                                    <input type="text" class="form-control font-weight-bold text-uppercase"
                                        id="txtPlaca" placeholder="Placa" style="color: rgb(0 123 255);">
                                    <div class="input-group-append" style="display: none;">
                                        <button class="btn btn-outline-primary" type="button"
                                            id="btnSearchPlaca">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="input-group-sm mt-1">
                                    <label class="mb-0">Município:</label>
                                    <label id="lblMunicipioVeiculo"></label>
                                    <%--<input type="text" class="form-control mw-100" id="txtMunicipioVeiculo" disabled>--%>
                                </div>

                                <div class="row row-cols-2 divider-eqp">
                                    <div class="col input-group-sm pr-0 pl-0">
                                        <label class="mb-0 mt-1">Marca:</label>
                                        <label class="mb-1" id="lblMarca"></label>
                                        <%--<input type="text" class="form-control" id="txtBrand" disabled>--%>
                                    </div>
                                    <div class="col input-group-sm">
                                        <label class="mb-0 mt-1">Cor:</label>
                                        <label class="mb-1" id="lblColor"></label>
                                    </div>
                                </div>

                                <div class="row row-cols-2 divider-eqp">
                                    <div class="col input-group-sm pr-0 pl-0">
                                        <label class="mb-0 mt-1">Tipo:</label>
                                        <label class="mb-0 mt-1" id="lblType"></label>
                                    </div>
                                    <div class="col input-group-sm">
                                        <label class="mb-0 mt-1">Categoria:</label>
                                        <label class="mb-0 mt-1" id="lblCategory"></label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

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
                                    <label class="mb-1 mt-1" id="lblEndereco"></label>
                                </div>

                                <div class="row row-cols-2 divider-eqp">
                                    <div class="col input-group-sm pr-0 pl-0">
                                        <label class="mb-0 mt-1">Faixa:</label>
                                        <label class="mb-0" id="lblFaixa"></label>
                                        <%--<input type="text" class="form-control" id="txtFaixa" disabled>--%>
                                    </div>
                                    <div class="col input-group-sm p-0">
                                        <label class="mb-0 mt-1">Velocidade da via:</label>
                                        <label class="mb-0" id="lblVelocidadeViaEqp"></label>
                                        <%--<input type="text" class="form-control"  disabled>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card float-right w-100">
                        <h5 class="card-header" onclick="closeEnquadramentos()">Enquadramentos</h5>
                        <div class="collapse show" id="divBodyEnquadramento">
                            <div class="card-body p-2">

                                <div class="input-group-sm">
                                    <label class="mb-1">Data:</label>
                                    <label class="mb-1" id="lblDate"></label>
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
                                        <label class="mb-0 mt-0" id="lblTempoSV"></label>
                                    </div>
                                    <div class="col input-group-sm pl-0 pr-0">
                                        <label class="mb-0 mt-1">Tempo Ocup.:</label>
                                        <label class="mb-0 mt-0" id="lblTempoOcup"></label>
                                    </div>
                                    <div class="col input-group-sm pr-0">
                                        <label class="mb-0 mt-1 font-weight-bold" style="color: rgb(220 53 69);">
                                            Lote:
                                        </label>
                                        <label class="mb-0 mt-0 font-weight-bold" id="lblLote"
                                            style="color: rgb(220 53 69);">
                                        </label>
                                    </div>
                                </div>

                                <div class="table-responsive mt-1">
                                    <table class="table table-bordered table-sm mb-0" id="tblEnquadramentos">
                                        <thead>
                                            <tr>
                                                <th style="width: 4rem;">Cód.</th>
                                                <th>Descrição</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbEnquadramentos">
                                            <tr>
                                                <td colspan="2">Não há registros!</td>
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
                        </div>

                        <button type="button" class="btn btn-primary" data-dismiss="modal">Aplicar</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalConfirmRejection">
            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Motivo rejeição</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="mb-0 align-self-center mr-1" for="sleMotivo">Motivo:</label>
                            <select class="form-control" id="sleMotivo" onchange="">
                            </select>
                        </div>

                        <label class="mb-0 align-self-center mr-1" for="txtObs">Obs:</label>
                        <textarea class="form-control" id="txtObs" rows="3"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" onclick="validateProcess(false)">
                            Confirmar
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="ControllersJS/General.js"></script>

    <script>
        var eqpsSelecteds = [];
        var listImagesPending = [];
        var indexImagePending = -1;
        $(function () {

            if ($("#hfUserConected").val() == "0") {

                $("#dvHome").css("display", "none");
                $("#statusAvaliator").css("display", "none");
                Swal.fire({
                    text: 'Usuário não encontrado!',
                    showClass: {
                        popup: 'animate__bounceIn'
                    },
                    hideClass: {
                        popup: 'animate__flipOutX'
                    }
                });
            }
            else {
                $("#dvHome").css("display", "block");
                $("#statusAvaliator").css("display", "block");
                loadAllData();
                getStatusProcess();
            }
        });

        //#region COLLAPSE CARDS
        function closeEditionImage() {

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

        function closeCar() {

            if ($("#divBodyCar")[0].className == "collapse" ||
                $("#divBodyCar")[0].className == "hide collapse") {

                $("#divBodyCar").removeClass("collapse");
                $("#divBodyCar").addClass("collapse show");
            }
            else {
                $("#divBodyCar").removeClass("collapse show");
                $("#divBodyCar").addClass("hide collapse");
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

        function loadAllData() {

            $("#divLoading").css("display", "block");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/loadAllData',
                dataType: 'json',
                data: JSON.stringify({
                    idMunicipio: $("#sleMunicipio").val(),
                    Eqps: eqpsSelecteds
                }),
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    var i = 0;
                    $("#dvImagens").empty();

                    if (data.d.length == 0) {

                        //CARD VEÍCULO
                        $("#txtPlaca").val("");
                        //$("#lblMarca")[0].innerHTML = firstIndex.marca;

                        //CARD EQUIPAMENTO
                        $("#lblMunicipio")[0].innerHTML = "";
                        $("#lblEndereco")[0].innerHTML = "";
                        $("#lblFaixa")[0].innerHTML = "";
                        $("#lblVelocidadeViaEqp")[0].innerHTML = "";

                        //CARD ENQUADRAMENTO
                        $("#lblDate")[0].innerHTML = "";
                        $("#lblVelMedida")[0].innerHTML = "";
                        $("#lblVelConsiderada")[0].innerHTML = "";
                        $("#lblTamanhoVeiculo")[0].innerHTML = "";
                        $("#lblTempoSV")[0].innerHTML = "";
                        $("#lblTempoOcup")[0].innerHTML = "";
                        $("#lblLote ")[0].innerHTML = "";
                        $("#hfidProcess ").val("");

                        $("#tbEnquadramentos").empty();
                        var newRow = $("<tr>");
                        var cols = `<td colspan='2'>Não há registros!</td>`;
                        newRow.append(cols);
                        $("#tbEnquadramentos").append(newRow);

                        Swal.fire({
                            text: 'Não há registros!',
                            showClass: {
                                popup: 'animate__bounceIn'
                            },
                            hideClass: {
                                popup: 'animate__flipOutX'
                            }
                        });

                        $("#divLoading").css("display", "none");
                        return;
                    }
                    else {

                        while (data.d[i]) {
                            var lst = data.d[i];

                            let imagesPending = {
                                "dtProcess": lst.dtProcess,
                                "eqp": lst.eqp,
                                "faixa": lst.faixa,
                                "id": lst.id,
                                "infractionDsc": lst.infractionDsc,
                                "infractionId": lst.infractionId,
                                "logradouro": lst.logradouro,
                                "lote": lst.lote,
                                "mnc": lst.mnc,
                                "mncDsc": lst.mncDsc,
                                "numberPlate": lst.numberPlate,
                                "tamanho": lst.tamanho,
                                "tempoSV": lst.tempoSV,
                                "tipoId": lst.tipoId,
                                "velCons": lst.velCons,
                                "velMedida": lst.velMedida,
                                "velVia": lst.velVia,
                                "tOcup": lst.tOcup,
                                "infractions": lst.tOcup,
                                "idProcess": lst.id,
                            }

                            var ativo = "";
                            if (i == 0)
                                ativo = "active";

                            var div = "<div class='carousel-item " + ativo + "'>" +
                                "<img src='" + lst.arquivo + "' class='d-block w-100' alt='...'></div>";
                            $("#dvImagens").append(div);

                            listImagesPending = [];
                            listImagesPending.push(imagesPending);
                            i++;
                        }

                        var firstIndex = listImagesPending[0];
                        //CARD VEÍCULO
                        $("#txtPlaca").val(firstIndex.numberPlate);
                        //$("#lblMarca")[0].innerHTML = firstIndex.marca;

                        //CARD EQUIPAMENTO
                        $("#lblMunicipio")[0].innerHTML = firstIndex.mncDsc;
                        $("#lblEndereco")[0].innerHTML = "Endereço: " + firstIndex.logradouro;
                        $("#lblFaixa")[0].innerHTML = firstIndex.faixa;
                        $("#lblVelocidadeViaEqp")[0].innerHTML = firstIndex.velVia + "km/h";

                        //CARD ENQUADRAMENTO
                        $("#lblDate")[0].innerHTML = firstIndex.dtProcess;
                        $("#lblVelMedida")[0].innerHTML = firstIndex.velMedida;
                        $("#lblVelConsiderada")[0].innerHTML = firstIndex.velCons;
                        $("#lblTamanhoVeiculo")[0].innerHTML = firstIndex.tamanho;
                        $("#lblTempoSV")[0].innerHTML = firstIndex.tempoSV;
                        $("#lblTempoOcup")[0].innerHTML = firstIndex.tOcup;
                        $("#lblLote ")[0].innerHTML = firstIndex.lote;

                        $("#hfidProcess ").val(firstIndex.idProcess);

                        $("#tbEnquadramentos").empty();
                        var newRow = $("<tr>");
                        var cols = "";
                        cols += `<td>${firstIndex.infractionId}</td>`;
                        cols += `<td>${firstIndex.infractionDsc}</td>`;
                        newRow.append(cols);
                        $("#tbEnquadramentos").append(newRow);

                        indexImagePending = 0;
                    }

                    $("#divLoading").css("display", "none");
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                    Swal.fire({
                        text: 'Falha ao carregar as informações, atualize a página novamente!',
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

        function loadEquipaments(value) {

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

                $("#modalEqp").modal("show");
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
                    url: 'Default.aspx/loadEquipaments',
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
                            text: 'Falha ao carregar os equipamentos, atualize a página novamente!',
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

        function validateProcess(valid) {

            if (valid == false) {
                if ($("#sleMotivo").val() == "") {

                    $("#sleMotivo").addClass("is-invalid");
                    Swal.fire({
                        text: 'Selecione um motivo!',
                        showClass: {
                            popup: 'animate__bounceIn'
                        },
                        hideClass: {
                            popup: 'animate__flipOutX'
                        }
                    });
                    return;
                }
                else {
                    $("#sleMotivo").removeClass("is-invalid");
                }
            }

            $("#divLoading").css("display", "block");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/validateProcess',
                dataType: 'json',
                data: JSON.stringify({
                    idProcess: $("#hfidProcess").val(),
                    valido: valid,
                    usuario: $("#hfUserConected").val(),
                    placa: $("#txtPlaca").val(),
                    idMotivoRejeicao: $("#sleMotivo").val(),
                    obsRejeito: $("#txtObs").val()
                }),
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    if (data.d == "true") {

                        Swal.fire({
                            text: 'Avaliado com sucesso!',
                            showClass: {
                                popup: 'animate__bounceIn'
                            },
                            hideClass: {
                                popup: 'animate__flipOutX'
                            }
                        });

                        $("#sleMotivo").val("");
                        $("#txtObs").val("");
                        $("#modalConfirmRejection").modal("hide");
                        loadAllData();
                    }
                    else {
                        Swal.fire({
                            text: 'Não foi possível avaliar!',
                            showClass: {
                                popup: 'animate__bounceIn'
                            },
                            hideClass: {
                                popup: 'animate__flipOutX'
                            }
                        });
                    }

                    getStatusProcess();

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

        function getStatusProcess() {

            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getStatusProcess',
                dataType: 'json',
                data: "{'user':'" + $("#hfUserConected").val() + "'}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#lblAprovados").text(data.d.qtdAprovadas);
                    $("#lblReprovados").text(data.d.qtdReprovadas);
                    $("#lblTotal").text(data.d.total);
                    $("#lblPendentes").text(data.d.pendentes);
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                    Swal.fire({
                        text: 'Falha ao carregar o status, atualize a página novamente!',
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

        function getMotivo() {

            $("#sleMotivo").removeClass("is-invalid");
            $.ajax({
                type: 'POST',
                url: 'Default.aspx/getMotivo',
                dataType: 'json',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                success: function (data) {

                    $("#sleMotivo").empty();                    $("#sleMotivo").append($("<option></option>").val("").html("─ SELECIONE ─"));                    $.each(data.d, function () {                        $("#sleMotivo").append(                            $("<option></option>").val(this['Value']).html(this['Text'])                        );                    });
                },
                error: function (data) {
                    $("#divLoading").css("display", "none");
                    Swal.fire({
                        text: 'Falha ao carregar o motivo, atualize a página novamente!',
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
    </script>

</asp:Content>
