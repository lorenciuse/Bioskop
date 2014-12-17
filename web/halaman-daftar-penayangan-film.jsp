<%-- 
    Document   : halaman-daftar-penayangan-film
    Created on : Nov 13, 2014, 10:23:25 PM
    Author     : Lorencius
--%>

<%@page import="com.rplo.bioskop.model.DataPegawai"%>
<%@page import="com.rplo.bioskop.model.Film"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        if (null != request.getParameter("commit")) {
            session = request.getSession(true);
            session.setMaxInactiveInterval(60 * 60 * 24);
            int login = DataPegawai.validateLoginCredential(request.getParameter("username"), request.getParameter("password"), request.getParameter("commit"));
            switch (login) {
                case 0:
                    out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"Unregistered username\");");
                    out.print("</script>");
                    break;
                case 1:
                    out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"Username or Password or Role was incorrect\");");
                    out.print("</script>");
                    break;
                case 2:
                    session.setAttribute("role", "Operator");
                    session.setAttribute("name", DataPegawai.getDataListByUsername(request.getParameter("username")).get(0).getmNamaPegawai());
                    session.setAttribute("username", DataPegawai.getDataListByUsername(request.getParameter("username")).get(0).getmUsernamePegawai());
                    response.sendRedirect("halaman-utama-operator.jsp");
                    break;
                case 3:
                    session.setAttribute("role", "Admin");
                    session.setAttribute("name", DataPegawai.getDataListByUsername(request.getParameter("username")).get(0).getmNamaPegawai());
                    session.setAttribute("username", DataPegawai.getDataListByUsername(request.getParameter("username")).get(0).getmUsernamePegawai());
                    response.sendRedirect("halaman-utama-admin.jsp");
                    break;
                default:
                    System.err.println("ENTER DEFAULT");
                    break;
            }
        }
    %>
    <head>
        <title>Daftar Tayang</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Login Sidebar-->
        <%@include file="sidebar-login.jsp" %>
        <!--End of Login Sidebar-->

        <div class="pusher">
            <!--Menu bar-->
            <div class="ui fixed top red inverted menu">
                <%@include file="menubar-home.jsp" %>
            </div>
            <!--End of Menu bar-->

            <!--Main body-->
            <h3 class="ui top center aligned attached red header">Now Playing</h3>
            <div class="ui basic segment attached">
                <div class="ui six doubling cards">
                    <%
                        List<Film> film = Film.getDataListNowPlaying();
                        for (int i = 0; i < film.size(); i++) {
                            String judul = film.get(i).getmJudulFilm();
                    %>
                    <div class="card">
                        <div class="dimmable image">
                            <div class="ui dimmer">
                                <div class="content">
                                    <div class="center">
                                        <button class="ui inverted button <%=i%>">Show Info</button>
                                    </div>
                                </div>
                            </div>
                            <img src="DisplayPhoto?kode=<%= Film.getDataList().get(i).getmKodeFilm()%>">
                        </div>
                        <div class="extra">
                            <%=judul%>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <%
                for (int i = 0; i < film.size(); i++) {
                    String judul = film.get(i).getmJudulFilm();
            %>
            <div class="ui modal <%=i%>">
                <i class="close icon"></i>
                <div class="header">
                    <%=judul%>
                </div>
                <div class="content">
                    <div class="ui card">
                        <div class="ui image">
                            <img src="DisplayPhoto?kode=<%= Film.getDataList().get(i).getmKodeFilm()%>">
                        </div>
                    </div>
                    <div class="description">
                        <div class="two fields">
                            <div class="field">
                                Sinopsis<br>
                                <%= film.get(i).getmKodeFilm() %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%}%>
        </div>
        <!--Script-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <script type="text/javascript">
            <%
                for (int i = 0; i < film.size(); i++) {
            %>
            $('.ui.modal.<%=i%>')
                    .modal('attach events', '.ui.inverted.button.<%=i%>', 'show');
            <%}%>
            $(document).ready(function() {
                $(document.getElementById("np")).addClass("active");
                //Login button handler
                $("#loginButton").click(function() {
                    $("#loginSidebar")
                            .sidebar('setting', {
                                overlay: true
                            }).sidebar('toggle');
                });

                //Login sidebar error prompt
                $("#sideLogin").form({
                    username: {
                        identifier: 'username',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Please enter a username'
                            }
                        ]
                    },
                    password: {
                        identifier: 'password',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Please enter a password'
                            }
                        ]
                    }
                }, {
                    on: 'submit',
                    inline: 'true'
                });

                $('.six.doubling.cards .image').dimmer({
                    on: 'hover'
                });
            });
        </script>
    </body>
</html>
