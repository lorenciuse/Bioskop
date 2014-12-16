<%-- 
    Document   : halaman-report-penjualan-tiket
    Created on : Nov 15, 2014, 10:46:01 PM
    Author     : Lorencius
--%>

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
                <div class="ui fluid form segment">
                    <h4 class="ui horizontal header divider">
                        <i class="file text outline icon"></i>
                        REPORT PENJUALAN TIKET
                    </h4>
                    <div class="two fields">
                        <div class="field">
                            <div class="field">
                                <label class="ui red teal tag label" >Tanggal Awal</label>
                                <input name="tanggalAwal" type="text" id="datePicker" placeholder="Tanggal Awal">
                            </div>
                        </div>
                        <div class="field">
                            <div class="field">
                                <label class="ui red teal tag label" >Tanggal Akhir</label>
                                <input name="tanggalAkhir" type="text" id="datePicker" placeholder="Tanggal Akhir">
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui button" id="download">
                            <i class="cloud download icon"></i>
                            Download
                        </div>
                    </div>
                </div>
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

                //Show dropdown on hover
                $('.ui.dropdown').dropdown({on: 'hover'});
                $("#datePicker").datepick({dateFormat: 'dd-M-yyyy'});
            });
        </script>
        <!--End of Local script-->
    </body>
</html>
