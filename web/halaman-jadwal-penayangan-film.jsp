<%-- 
    Document   : halaman-jadwal-penayangan-film
    Created on : Nov 15, 2014, 10:47:01 PM
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
        <title>Buat Jadwal Tayang</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
        <link href="date/redmond.datepick.css" rel="stylesheet" type="text/css">
        <link href="jclockpicker/jquery-clockpicker.min.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Menu bar-->
        <%@include file="menubar-admin.jsp" %>
        <!--End of Menu bar-->

        <!--Main body-->
        <br><br><br><br>
        <div class="ui two column page grid">
            <div class="column">
                <form class="ui fluid form segment" method="POST" id="studio">
                    <div class="two fields">
                        <div class="field">
                            <div class="ui selection dropdown">
                                <input type="hidden" name="studio">
                                <div class="default text">Studio</div>
                                <i class="dropdown icon"></i>
                                <div class="menu">
                                    <div class="item" data-value="Studio1">Studio 1</div>
                                    <div class="item" data-value="Studio2">Studio 2</div>
                                    <div class="item" data-value="Studio3">Studio 3</div>
                                </div>
                            </div>
                        </div>
                        <div class="field">
                            <div class="two fields">
                                <div class="field">
                                    <button class="ui blue vertical fluid animated button" type="submit" name="buat">
                                        <div class="hidden content">Buat Jadwal</div>
                                        <div class="visible content">
                                            <i class="calendar icon"></i>
                                        </div>
                                    </button>
                                </div>
                                <div class="field"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="ui two column page grid">
            <div class="column">
                <form class="ui fluid form segment" method="POST" id="formBuat">
                    <div class="field">
                        <h4 class="ui horizontal header divider">
                            <i class="calendar icon"></i>
                            Data Penjadwalan
                        </h4>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Judul Film</label>
                            <div class="ui selection dropdown">
                                <input type="hidden" name="judul">
                                <div class="default text">Pilih Judul</div>
                                <i class="dropdown icon"></i>
                                <div class="disabled menu" id="menuJudul">
                                    <div class="item" data-value="Judul1">Judul 1</div>
                                    <div class="item" data-value="Judul2">Judul 2</div>
                                    <div class="item" data-value="Judul3">Judul 3</div>
                                </div>
                            </div>
                        </div>
                        <div class="field">
                            <label>Durasi Film</label>
                            <input type="text" name="durasi" disabled="disabled" placeholder="Durasi Film">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Tanggal Tayang</label>
                            <input name="tanggal" type="text" id="datePicker" placeholder="Tanggal Tayang">
                        </div>
                        <div class="field">
                            <label>Waktu Tayang</label>
                            <input id="popupClockpicker" placeholder="Waktu Tayang" type="text" name="waktu">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <div class="two fields">
                                <div class="field">
                                    <button class="ui disabled blue vertical fluid animated button" type="submit" name="cek">
                                        <div class="hidden content">Cek</div>
                                        <div class="visible content">
                                            <i class="check square icon"></i>
                                        </div>
                                    </button>
                                </div>
                                <div class="field">
                                    <button class="ui disabled blue vertical fluid animated button" type="submit" name="simpan">
                                        <div class="hidden content">Simpan</div>
                                        <div class="visible content">
                                            <i class="save icon"></i>
                                        </div>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="field">
                        </div>
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
        <script src="jclockpicker/jquery-clockpicker.min.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $(document.getElementById("sche")).addClass("active");

                $("#datePicker").datepick({dateFormat: 'dd-mm-yyyy'})
                        .datepick('disable');

                //Show dropdown on hover
                $('.ui.dropdown').dropdown({on: 'hover'});
                $('#popupClockpicker').clockpicker({autoclose: true});
                $("#datePicker").datepick({dateFormat: 'dd-M-yyyy'});
            });
        </script>
    </body>
</html>