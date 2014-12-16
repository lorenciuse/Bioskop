<%-- 
    Document   : sidebar-login
    Created on : Dec 13, 2014, 1:28:26 AM
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
        <div class="ui right vertical sidebar menu" id="loginSidebar">
            <div class="item">
                <form class="ui form basic segment" method="POST" id="sideLogin">
                    <div class="field">
                        <div class="ui left icon input">
                            <input name="username" id="user" type="text" placeholder="Username">
                            <i class="user icon"></i>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui left icon input">
                            <input name="password" id="pass" type="password" placeholder="Password">
                            <i class="lock icon"></i>
                        </div>
                    </div>
                    <div class="field">
                        <label>Connect as</label>
                        <div class="ui two fluid red tiny buttons">
                            <input class="ui button" type="submit" name="commit" value="ADMIN">
                            <div class="or"></div>
                            <input class="ui button" type="submit" name="commit" value="OPERATOR">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
    </body>
</html>
