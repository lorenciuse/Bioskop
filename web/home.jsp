<%-- 
    Document   : home
    Created on : Nov 9, 2014, 12:35:02 PM
    Author     : Lorencius
--%>

<%@page import="java.util.List"%>
<%@page import="com.rplo.bioskop.model.Film"%>
<%@page import="com.rplo.bioskop.model.DataPegawai"%>
<!DOCTYPE html>
<html>
    <%
        if (null != request.getParameter("commit")) {
            session = request.getSession(true);
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
        <title>Home OM-ITEM</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
        <link href="bxslider/jquery.bxslider.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Login Sidebar-->
        <%@include file="sidebar-login.jsp" %>
        <!--End of Login Sidebar-->

        <div class="pusher" id="context1">
            <!--Menu bar-->
            <div class="ui fixed top red inverted menu">
                <%@include file="menubar-home.jsp" %>
            </div>
            <!--End of Menu bar-->

            <!--Main body-->
            <div class="ui grid">
                <div class="three wide column">
                    <!--<div class="ui sticky">-->
                    <h4 class="ui top center aligned attached inverted red block header">
                        BENEFIT
                    </h4>
                    <div class="ui center aligned segment attached">
                        <img src="img/OMitem_Benefit.png" style="width: 67%">
                    </div>
                    <!--</div>-->
                </div>
                <div class="ten wide column">
                    <h4 class="ui top center aligned attached inverted red block header">
                        NOW PLAYING
                    </h4>
                    <div class="ui segment attached">
                        <ul id="slider1">
                            <li><img src="img/Kucing Berdoa.jpg" alt="slide1" title="Kucing Berdoa"></li>
                            <li><img src="img/Kucing Galau.jpg" alt="slide2" title="Kucing Galau"></li>
                            <li><img src="img/Kucing Natal.jpg" alt="slide2" title="Kucing Natal"></li>
                            <li><img src="img/Kucing Fotografer.jpg" alt="slide2" title="Kucing Fotografer"></li>
                        </ul>
                    </div>
                    <h4 class="ui top center aligned attached inverted red block header">
                        COMING SOON
                    </h4>
                    <div class="ui segment attached">
                        <ul id="slider2">
                            <%
                                List<Film> film = Film.getDataList();
                                for (int i = 0; i < film.size(); i++) {%>
                                <li><img src="DisplayPhoto?kode=<%= Film.getDataList().get(i).getmKodeFilm()%>" alt="slide<%=i%>" title="<%= Film.getDataList().get(i).getmJudulFilm()%>"></li>
                                <% }%>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Main body-->

        <!--Script-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="bxslider/jquery.bxslider.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $(document.getElementById("home")).addClass("active");

//                $('.ui.sticky').sticky({
//                    context: '#context1',
//                    pushing: true
//                });
                //Slideshow 1
                $('#slider1').bxSlider({
                    speed: 1000, //transition speed
                    mode: 'horizontal', //transition mode
                    controls: false, //control prev, next
                    captions: true, //captions based on its title
                    auto: true, //auto slide
                    autoStart: true, //auto start when the page load
                    autoControls: false,
                    adaptiveHeight: true
                });

                //Slideshow 2
                $('#slider2').bxSlider({
                    speed: 1000,
                    auto: true,
                    controls: false,
                    autoStart: true,
                    autoControls: false,
                    captions: true,
                    slideWidth: 200,
                    minSlides: 4,
                    maxSlides: 4,
                    moveSlides: 1
                });

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
                        identifier: 'user',
                        rules: [{
                                type: 'empty', prompt: 'Please enter a username'
                            }
                        ]
                    },
                    password: {
                        identifier: 'pass',
                        rules: [{
                                type: 'empty', prompt: 'Please enter a password'
                            }
                        ]
                    }
                }, {
                    on: 'submit',
                    inline: 'true'
                });
            });
        </script>
    </body>
</html>

