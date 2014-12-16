<%-- 
    Document   : adaajah
    Created on : Nov 28, 2014, 5:22:06 PM
    Author     : Elifelia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1><h3>Random Numbers:</h3>
        <%!
            Random randomValue = new Random();
        %>
        <p>
            Random Number:<%=randomValue.nextInt()%>
            <br>
            Positive Random Number:<%=Math.abs(randomValue.nextInt())%>
            <br>
            Generating a random Number between 1 and 6 :<%=(Math.abs(randomValue.nextInt()) % 5) + 1%>
        <p>
            <b>Note:</b>Each time this script is run a different output will be produced.

    </body>
</html>
