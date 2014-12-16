<%-- 
    Document   : halaman-signin-member
    Created on : Nov 13, 2014, 9:26:57 PM
    Author     : Lorencius
--%>

<%@page import="com.rplo.bioskop.model.Member"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    if (null != request.getParameter("singin")) {
        session = request.getSession(true);
//            session.setMaxInactiveInterval(60 * 60 * 24);
        int login = Member.validateLoginCredential(request.getParameter("username"), request.getParameter("password"));

        switch (login) {
            case 0:
                out.print("<script>");
                out.print("alert(\"Unregistered username\");");
                out.print("</script>");
                break;
            case 1:
//                    username = request.getParameter("username");
                out.print("<script>");
                out.print("alert(\"Username or Password was incorrect\");");
                out.print("</script>");
                break;
            case 2:
                session.setAttribute("mName", request.getParameter("username"));
                session.setAttribute("mUsername", request.getParameter("username"));
                response.sendRedirect("home.jsp");
                break;
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign in M-Tix</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Menu bar-->
        <div class="ui fixed top red inverted menu">
            <%@include file="menubar-home.jsp" %>
        </div>
        <!--End of Menu bar-->

        <div class="ui one column page grid">
            <div class="column">
                <div class="ui info message">
                    <div class="header">
                        You have to sign in
                    </div>
                    <p>
                        Isi form dengan User ID dan Password anda jika anda sudah terdaftar sebagai member M-TIX kami
                        kemudian tekan tombol Sign In. <br>
                        Untuk informasi lebih lanjut, Anda dapat menghubungi administrator kami, terimakasih.

                    </p>
                </div>
            </div>
        </div>
        <div class="ui three column page grid">
            <div class="column"></div>
            <div class="column">
                <h4 class="ui top center aligned attached inverted red block header">
                    SIGN IN
                </h4>
                <form class="ui form segment attached" method="POST" id="mtixSignin">
                    <div class="field">
                        <div class="ui left icon input">
                            <input name="username" type="text" placeholder="Username">
                            <i class="user icon"></i>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui left icon input">
                            <input name="password" type="password" placeholder="Password">
                            <i class="lock icon"></i>
                        </div>
                    </div>
                    <div class="field">
                        <input class="ui tiny red button" type="submit" value="Signin" name="singin">
                    </div>
                </form>
            </div>
            <div class="column"></div>
        </div>
        <!--Script-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <script type="text/javascript">
            //Reset login sidebar value when reload
//            var originalState = $('#mtixSignin').clone();
//            $('#mtixSignin').replaceWith(originalState);

            $(document).ready(function() {
                $(document.getElementById("signin")).addClass("active");
                $(document.getElementById("right")).remove();
                $("#mtixSignin").form({
                    username: {
                        identifier: 'username',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Masukkan username'
                            }
                        ]
                    },
                    password: {
                        identifier: 'password',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Masukkan password'
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
