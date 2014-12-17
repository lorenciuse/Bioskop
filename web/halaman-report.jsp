<%-- 
    Document   : halaman-report-penjualan-tiket
    Created on : Nov 15, 2014, 10:46:01 PM
    Author     : Lorencius
--%>

<%@page import="com.rplo.bioskop.model.Tiket"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.rplo.bioskop.model.DatabaseConnection"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        //Check Login Session
        if (session.getAttribute("username") == null) {
            out.print("<script>");
            out.print("alert(\"You don't have permission to access this page\");");
            out.print("window.location = 'home.jsp'");
            out.print("</script>");
        }

        //Logout actionPerformed
        if (request.getParameter("logout") != null) {
            session.removeAttribute("username");
            session.removeAttribute("password");
            session.removeAttribute("name");
            session.removeAttribute("role");
            session.invalidate();
            response.sendRedirect("home.jsp");
            return;
        }

        if (null != request.getParameter("download")) {
            if (request.getParameter("tanggalAwal") != null && request.getParameter("tanggalAkhir") != null) {
                Connection conn = DatabaseConnection.getmConnection();
//            Inpu path = IOUtils.toString(getServletContext().getResourceAsStream("/WEB-INF/report/report_tanggal.jasper"));
                //File reportFile = new File(path);
                Map<String, Object> params = new HashMap<String, Object>();

                params.put("TANGGAL_AWAL", request.getParameter("tanggalAwal"));
                params.put("TANGGAL_AKHIR", request.getParameter("tanggalAkhir"));

                params.put("TOTAL_TIKET", Tiket.sumTiket_date(request.getParameter("tanggalAwal"), request.getParameter("tanggalAkhir")));
                params.put("TOTAL_HARGA", Tiket.sumharga_date(request.getParameter("tanggalAwal"), request.getParameter("tanggalAkhir")));

                byte[] bytes = JasperRunManager.runReportToPdf(getServletContext().getResourceAsStream("/WEB-INF/report/report_tanggal.jasper"), params, conn);

                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);

                ServletOutputStream outStream = response.getOutputStream();
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();
                outStream.close();
            } else {
                Connection conn = DatabaseConnection.getmConnection();
                Map<String, Object> params = new HashMap<String, Object>();

                byte[] bytes = JasperRunManager.runReportToPdf(getServletContext().getResourceAsStream("/WEB-INF/report/report_sysdate.jasper"), params, conn);

                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);

                ServletOutputStream outStream = response.getOutputStream();
                outStream.write(bytes, 0, bytes.length);
                outStream.flush();
                outStream.close();
            }
        }

    %>

    <head>
        <title>Report Penjualan Tiket</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
        <link href="date/redmond.datepick.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Menu bar-->        
        <%@include file="menubar-admin.jsp" %>
        <!--End of Menu bar-->

        <!--Main body-->
        <br><br><br><br>
        <div class="ui three column page grid" >
            <div class="column"></div>
            <div class="column">
                <form class="ui fluid form segment" method="POST" id="reportForm" target="_blank">
                    <h4 class="ui horizontal header divider">
                        <i class="file text outline icon"></i>
                        REPORT PENJUALAN TIKET
                    </h4>
                    <div class="two fields">
                        <div class="field">
                            <div class="field">
                                <label class="ui red teal tag label" >Tanggal Awal</label>
                                <input name="tanggalAwal" type="text" id="datePicker1" placeholder="Tanggal Awal">
                            </div>
                        </div>
                        <div class="field">
                            <div class="field">
                                <label class="ui red teal tag label" >Tanggal Akhir</label>
                                <input name="tanggalAkhir" type="text" id="datePicker2" placeholder="Tanggal Akhir">
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui checkbox">
                            <input id="hariIni" type="checkbox">
                            <label>Hari ini</label>
                        </div>
                    </div>
                    <div class="field">
                        <button class="ui button" type="submit" name="download">
                            <i class="cloud download icon"></i>
                            Download
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <!--End of Main body-->

        <!--Script-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <script src="date/jquery.plugin.js" type="text/javascript"></script>
        <script src="date/jquery.datepick.js" type="text/javascript"></script>
        <!--Local script-->
        <script type="text/javascript">
            $(document).ready(function() {

                $(document.getElementById("rep")).addClass("active");

                $('.ui.checkbox')
                        .checkbox({
                            'onChecked': function() {
                                $("#datePicker1")
                                        .datepick('disable');
                                $("#datePicker2")
                                        .datepick('disable');
                            },
                            'onUnchecked': function() {
                                $("#datePicker1")
                                        .datepick('enable');
                                $("#datePicker2")
                                        .datepick('enable');
                            }
                        });

                //Show dropdown on hover
                $('.ui.dropdown').dropdown({on: 'hover'});
                $("#datePicker1").datepick({dateFormat: 'dd-M-yyyy'});
                $("#datePicker2").datepick({dateFormat: 'dd-M-yyyy'});
            });
        </script>
        <!--End of Local script-->
    </body>
</html>
