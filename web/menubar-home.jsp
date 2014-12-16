<%-- 
    Document   : menubar-home
    Created on : Dec 13, 2014, 1:16:22 AM
    Author     : Lorencius
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <div class="container">
            <a class="item" id="home" href="home.jsp">
                <i class="home icon"></i> HOME
            </a>
            <a class="item" id="np" href="halaman-daftar-penayangan-film.jsp">
                <i class="video icon"></i> NOW PLAYING
            </a>
            <a class="item" id="signin" href="halaman-signin-member.jsp">
                <i class="user icon"></i> M-TIX
            </a>
            <div class="right menu" id="right">
                <a class="item" id="loginButton">
                    <i class="sign in icon"></i> LOGIN
                </a>
            </div>
        </div>
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
    </body>
</html>
