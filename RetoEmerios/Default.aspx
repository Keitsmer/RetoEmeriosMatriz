<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RetoEmerios._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <script type="text/javascript">

        var minRow = 7;
        var maxCol = 7;
        var numRepeticiones = 0;
        var carRepeticiones = "";
        var posFil = 0;
        var posCol = 0;
        var tempH = [];
        var tempV = [];
        var tempDD = [];
        var tempG = [];
        var matriz = [
            ["B", "B", "D", "A", "D", "E", "F"],
            ["B", "X", "C", "D", "D", "J", "K"],
            ["H", "Y", "I", "3", "D", "D", "3"],
            ["R", "7", "O", "Ñ", "G", "D", "2"],
            ["W", "N", "S", "P", "E", "0", "D"],
            ["A", "9", "C", "D", "D", "E", "F"],
            ["B", "X", "D", "D", "D", "J", "K"]
        ];

        $(document).ready(function () {
            $("#btnGenerar").on("click", function () {
                
                var html = "";
                for (var i = 0; i < minRow; i++) {
                    html += "<tr>";
                    for (var j = 0; j < maxCol; j++) {
                        html += "<td> " + matriz[i][j] + " </td>";
                    }
                    html += "</tr>";
                }
                $("#tbResultMatrix").html(html);

                //buscar en Horizontal
                var cadenaActualH = "";
                var contH = 0;
                var k = 0;
                for (var i = 0; i < minRow; i++) {
                    for (var j = 0; j < maxCol; j++) {
                        if (j == 0) {
                            cadenaActualH = matriz[i][j];
                            contH = contH + 1;
                        } else {
                            if (cadenaActualH == matriz[i][j]) {
                                cadenaActualH = matriz[i][j];
                                contH = contH + 1;
                            } else {
                                cadenaActualH = matriz[i][j];
                                contH = 1;
                            }
                        }
                        if (contH > 1) {
                            tempH[k] = contH + "|" + cadenaActualH;
                            k++;
                        }
                    }
                    cadenaActualH = "";
                    contH = 0;
                }
                
                var mayorH = 0;
                var caracterH = "";
                for (var i = 0; i < tempH.length; i++) {
                    var valor = tempH[i];
                    var contador = valor.split('|')[0];
                    var letra = valor.split('|')[1];
                    if (contador > mayorH) {
                        mayorH = contador;
                        caracterH = letra;
                    }
                }

                var cadenaH = "";
                for (var i = 0; i < mayorH; i++) {
                    cadenaH = cadenaH + caracterH;
                }
                tempG[0] = mayorH + "|" + caracterH;

                //Buscar en Vertical
                var cadenaActualV = "";
                var contV = 0;
                var p = 0;
                
                for (var j = 0; j < maxCol; j++) {
                    for (var i = 0; i < minRow; i++) {
                        if (i == 0) {
                            cadenaActualV = matriz[i][j];
                            contV = contV + 1;
                        } else {
                            if (cadenaActualV == matriz[i][j]) {
                                cadenaActualV = matriz[i][j];
                                contV = contV + 1;
                            } else {
                                cadenaActualV = matriz[i][j];
                                contV = 1;
                            }
                        }
                        if (contV > 1) {
                            tempV[p] = contV + "|" + cadenaActualV;
                            p++;
                        }
                    }
                    cadenaActualV = "";
                    contV = 0;
                }

                var mayorV = 0;
                var caracterV = "";
                for (var i = 0; i < tempV.length; i++) {
                    var valor = tempV[i];
                    var contador = valor.split('|')[0];
                    var letra = valor.split('|')[1];
                    if (contador > mayorV) {
                        mayorV = contador;
                        caracterV = letra;
                    }
                }

                var cadenaV = "";
                for (var i = 0; i < mayorV; i++) {
                    cadenaV = cadenaV + caracterV;
                }

                tempG[1] = mayorV + "|" + caracterV;

                //BUSCAR EN DIAGONAL
                var cadenaActualDD = "";
                var contDD = 0;
                var caracterDD = "";
                
                var i;
                var j;
                for (i = 0; i <  1; i++) {
                    for (j = 2; j < maxCol; j++) {
                        cadenaActualDD = matriz[i][j];
                        if (j < 6) {
                            var newValue = matriz[i + 1][j + 1];
                            if (cadenaActualDD == newValue) {
                                caracterDD = cadenaActualDD;
                                contDD = contDD + 1;
                            }
                        } else {
                            var newValue = matriz[i][j];
                            if (cadenaActualDD == newValue) {
                                caracterDD = cadenaActualDD;
                                contDD = contDD + 1;
                            }
                        }
                        i++;
                    }
                    i = 0;
                }

                tempG[2] = contDD + "|" + caracterDD;

                

                console.log("RESPUESTA");
               
                var contadorLetras = 0;
                var repCaracter = "";
                var resultCadena = "";
                for (var i = 0; i < tempG.length; i++) {
                    var valor = tempG[i];
                    var contador = valor.split('|')[0];
                    var caracter = valor.split('|')[1];
                    if (contador > contadorLetras) {
                        contadorLetras = contador;
                        repCaracter = caracter;
                    }
                }

                console.log(contadorLetras);
                for (var i = 0; i < contadorLetras; i++) {
                    resultCadena = resultCadena + " " + repCaracter;
                }

                $("#resultado").text("LA SUBCADENA MAS LARGA ES: " + resultCadena);
                $("#longitud").text("LA LONGITUD DE LA SUBCADENA ES: " + contadorLetras);

            });
        });

     </script>
     <div class="jumbotron">
        <h1>ASP.NET</h1>
        <p class="lead">RETO: Encuentra la subcadena más larga presente en un matriz</p>
        <p><button type="button"  id="btnGenerar" class="btn btn-primary btn-lg">GENERAR</button></p>
        <div>
            <table>
                <tbody id="tbResultMatrix"></tbody>
            </table>
        </div>
        <br />
        <div>
            <p class="lead" id="resultado"></p>
            <p class="lead" id="longitud"></p>
        </div>
    </div>


</asp:Content>
