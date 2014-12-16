<%-- 
    Document   : menubar-operator
    Created on : Dec 13, 2014, 1:08:35 AM
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
        <div class="ui fixed top menu">
            <div class="container">
                <a class="item" id="ticket" href="halaman-pesan-tiket.jsp">
                    <i class="ticket icon"></i> JUAL TIKET
                </a>
                <a class="item" id="print" href="halaman-cetak-tiket.jsp">
                    <i class="print icon"></i> CETAK TIKET
                </a>
                <div class="right menu">
                    <form method="POST">
                        <div class="ui floating dropdown link item">
                            <i class="user icon"></i> OPERATOR <i class="dropdown icon"></i>
                            <div class="menu">
                                <div class="header">
                                    Logged as
                                </div>
                                <div class="divider"></div>
                                <div class="item">
                                    ${name}
                                </div>
                                <div class="item">
                                    ${username}
                                </div>
                                <a class="item" href="halaman-utama-operator.jsp?logout=yes"><i class="sign out icon"></i>Logout</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
