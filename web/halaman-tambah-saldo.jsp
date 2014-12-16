<%-- 
    Document   : halaman-tambah-saldo
    Created on : Nov 15, 2014, 10:25:26 PM
    Author     : Lorencius
--%>
<%@page import="com.rplo.bioskop.model.Member"%>
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

        //Remove Session when reload
        if (session.getAttribute("id") != null) {
            session.removeAttribute("user");
            session.removeAttribute("nama");
            session.removeAttribute("saldo");
            session.removeAttribute("id");
        }

        //Cari user actionPerformed
        Member member = new Member();
        if (null != request.getParameter("cariData")) {
            session.setAttribute("id", Member.getDataListbyUser(request.getParameter("user")).get(0).getmKodeMember());
            session.setAttribute("nama", Member.getDataListbyUser(request.getParameter("user")).get(0).getmNamaMember());
            session.setAttribute("saldo", Member.getDataListbyUser(request.getParameter("user")).get(0).getmSaldo());
            session.setAttribute("user", request.getParameter("user"));
        }

        //Tambah saldo actionPerformed
        if (null != request.getParameter("tambah")) {
            member.setmKodeMember(request.getParameter("idT"));
            member.setmSaldo(Integer.parseInt(request.getParameter("saldoT")) + Integer.parseInt(request.getParameter("saldo")));
            Member.updateSaldo(member);
            session.setAttribute("id", Member.getDataListbyUser(request.getParameter("userT")).get(0).getmKodeMember());
            session.setAttribute("nama", Member.getDataListbyUser(request.getParameter("userT")).get(0).getmNamaMember());
            session.setAttribute("user", request.getParameter("userT"));
            session.setAttribute("saldo", member.getmSaldo());
        }
    %>
    <head>
        <title>Tambah Saldo</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Menu bar-->
        <%@include file="menubar-admin.jsp" %>
        <!--End of Menu bar-->

        <!--Main body-->
        <br><br><br><br>
        <div class="ui one column page grid">
            <div class="column">
                <!--Search box Form-->
                <form class="ui fluid form segment" method="POST" id="updateSaldo">
                    <div class="three fields">
                        <div class="field">
                            <!--Search box-->
                            <div class="ui search" id="searchInput">
                                <div class="ui icon input">
                                    <input class="prompt" placeholder="Cari User ..." type="text" name="user" value="${user}">
                                    <button class="ui icon button" type="submit" name="cariData">
                                        <i class="search icon"></i>
                                    </button>
                                </div>
                                <div class="results"></div>
                            </div>
                            <!--End of Search box-->
                        </div>
                        <div class="field"></div>
                        <div class="field"></div>
                    </div>
                </form>
                <!--End of Search box Form-->
                <div class="ui fluid form segment">
                    <h4 class="ui horizontal header divider">
                        <i class="info icon"></i>
                        Personal Information
                    </h4>
                    <div class="three fields">
                        <!--User Info-->
                        <div class="field">
                            <label>Id Member</label>
                            <input name="id" placeholder="ID Member" type="text" disabled="disabled" value="${id}">
                        </div>
                        <div class="field">
                            <label>Nama</label>
                            <input name="nama" placeholder="Nama" type="text" disabled="disabled" value="${nama}">
                        </div>
                        <div class="field">
                            <label>Saldo</label>
                            <input name="saldo" placeholder="Saldo" type="text" disabled="disabled" value="${saldo}">
                        </div>
                        <!--End of User Info-->
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <div class="ui blue disabled button"  id="tambahSaldo">Tambah Saldo</div>
                        </div>
                        <div class="field">
                            <!--Success Message-->
                            <div class="ui positive message" id="success">
                                <div class="header">
                                    Proses Penambahan Saldo Berhasil
                                </div>
                                <p>Nominal Saldo <b>Rp. <%=request.getParameter("saldo")%></b> berhasil ditambahkan pada account Anda.</p>
                            </div>
                            <!--End of Success Message-->
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Pop up Add Pulse-->
        <div class="ui small modal saldo">
            <i class="close icon"></i>
            <div class="header">
                Pilih Jumlah Saldo
            </div>
            <div class="content">
                <form class="ui form segment" method="POST" id="formSaldo">
                    <div class="field">
                        <input type="hidden" name="idT" value="${id}">
                        <input type="hidden" name="namaT" value="${nama}">
                        <input type="hidden" name="saldoT" value="${saldo}">
                        <input type="hidden" name="userT" value="${user}">
                        <div class="ui fluid selection dropdown">
                            <input name="saldo" type="hidden">
                            <div class="default text">Pilih Saldo</div>
                            <i class="dropdown icon"></i>
                            <div class="menu">
                                <div class="item" data-value="150000" >Rp. 150.000</div>
                                <div class="item" data-value="200000" >Rp. 200.000</div>
                                <div class="item" data-value="250000" >Rp. 250.000</div>
                            </div>
                        </div>
                    </div>
                    <div class="field">
                        <button class="ui blue button" type="submit" name="tambah">Tambah</button>
                    </div>
                </form>
            </div>
        </div>
        <!--End of Pop up Add Pulse-->
        <!--End of Main body-->

        <!--Jquery and Semantic UI JS-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <!--End of JS-->
        <!--Local Script-->
        <script type="text/javascript">
            $(document).ready(function() {
                //Hide and Show success message
                $(document.getElementById("success")).hide();
            <%if (null != request.getParameter("saldo")) {%>
                $(document.getElementById("success")).show();
            <%}%>
                $(document.getElementById("sal")).addClass("active");

                //Activated tambah saldo button 
            <%
                if (session.getAttribute("id") != null) {
                    if (!session.getAttribute("id").equals("")) { %>
                $(document.getElementById("tambahSaldo")).removeClass("disabled");
            <%
                    }
                }
            %>

                //Show modal onclick tambah saldo
                $('.ui.small.modal.saldo')
                        .modal('attach events', '#tambahSaldo', 'show');

                //Show dropdown on hover 
                $('.ui.dropdown').dropdown({on: 'hover'});

                //List of Username in search box
                $('#searchInput').search({
                    source: [
            <%
                for (int i = 0; i < Member.getDataList().size(); i++) {
            %>
                        {title: '<%= Member.getDataList().get(i).getmUsernameMember()%>'},
            <%
                }
            %>
                    ]
                });

                //Search box error prompt
                $("#updateSaldo").form({
                    idfilm: {
                        identifier: 'user',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Username Member'}
                                ]
                    }
                },
                {
                    on: 'submit',
                    inline: true
                });

                //Tambah saldo error prompt
                $("#formSaldo").form({
                    idfilm: {
                        identifier: 'saldo',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Pilih nominal saldo'}
                                ]
                    }
                },
                {
                    on: 'submit',
                    inline: true
                });
            });
        </script>
        <!--End of Local Script-->
    </body>
</html>
