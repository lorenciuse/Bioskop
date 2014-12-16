<%-- 
    Document   : halaman-edit-data-member
    Created on : Nov 15, 2014, 10:26:46 PM
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
            session.removeAttribute("user");
            session.removeAttribute("nama");
            session.removeAttribute("tempat");
            session.removeAttribute("tanggal");
            session.removeAttribute("alamat");
            session.removeAttribute("nomor");
            session.removeAttribute("email");
            session.removeAttribute("saldo");
            session.removeAttribute("id");
            session.invalidate();
            response.sendRedirect("home.jsp");
            return;
        }

        //Remove session when reload
        if (session.getAttribute("user") != null) {
            session.removeAttribute("user");
            session.removeAttribute("nama");
            session.removeAttribute("tempat");
            session.removeAttribute("tanggal");
            session.removeAttribute("alamat");
            session.removeAttribute("nomor");
            session.removeAttribute("email");
            session.removeAttribute("saldo");
            session.removeAttribute("id");
        }

        //Update actionPerformed
        Member member = new Member();
        if (null != request.getParameter("updateData")) {
            member.setmUsernameMember(request.getParameter("username"));
            member.setmPasswordMember(request.getParameter("password"));
            member.setmNamaMember(request.getParameter("nama"));
            member.setmTanggalLahir(request.getParameter("tanggalLahir"));
            member.setmAlamatMember(request.getParameter("alamat"));
            member.setmEmail(request.getParameter("email"));
            member.setmNomorTelepon(request.getParameter("telepon"));
            member.setmSaldo(Integer.parseInt(request.getParameter("saldo")));
            member.setmTempatLahir(request.getParameter("tempatLahir"));
            member.setmKodeMember(request.getParameter("kode"));

            Member.updateData(member);

            session.setAttribute("user", Member.getDataListbyUser(request.getParameter("username")).get(0).getmUsernameMember());
            session.setAttribute("nama", Member.getDataListbyUser(request.getParameter("username")).get(0).getmNamaMember());
            session.setAttribute("tempat", Member.getDataListbyUser(request.getParameter("username")).get(0).getmTempatLahir());
            session.setAttribute("tanggal", Member.getDataListbyUser(request.getParameter("username")).get(0).getmTanggalLahir());
            session.setAttribute("alamat", Member.getDataListbyUser(request.getParameter("username")).get(0).getmAlamatMember());
            session.setAttribute("nomor", Member.getDataListbyUser(request.getParameter("username")).get(0).getmNomorTelepon());
            session.setAttribute("email", Member.getDataListbyUser(request.getParameter("username")).get(0).getmEmail());
            session.setAttribute("id", Member.getDataListbyUser(request.getParameter("username")).get(0).getmKodeMember());
            session.setAttribute("saldo", Member.getDataListbyUser(request.getParameter("username")).get(0).getmSaldo());
        }

        //Cari User actionPerformed
        if (null != request.getParameter("cariData")) {
            session.setAttribute("user", Member.getDataListbyUser(request.getParameter("user")).get(0).getmUsernameMember());
            session.setAttribute("nama", Member.getDataListbyUser(request.getParameter("user")).get(0).getmNamaMember());
            session.setAttribute("tempat", Member.getDataListbyUser(request.getParameter("user")).get(0).getmTempatLahir());
            session.setAttribute("tanggal", Member.getDataListbyUser(request.getParameter("user")).get(0).getmTanggalLahir());
            session.setAttribute("alamat", Member.getDataListbyUser(request.getParameter("user")).get(0).getmAlamatMember());
            session.setAttribute("nomor", Member.getDataListbyUser(request.getParameter("user")).get(0).getmNomorTelepon());
            session.setAttribute("email", Member.getDataListbyUser(request.getParameter("user")).get(0).getmEmail());
            session.setAttribute("id", Member.getDataListbyUser(request.getParameter("user")).get(0).getmKodeMember());
            session.setAttribute("saldo", Member.getDataListbyUser(request.getParameter("user")).get(0).getmSaldo());
        }
    %>
    <head>
        <title>Edit Data Member</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
        <link href="date/redmond.datepick.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <!--Menu bar-->
        <%@include file="menubar-admin.jsp" %>
        <!--End of Menu bar-->
        <br><br><br><br>
        <div class="ui one column page grid">
            <div class="column">
                <form class="ui fluid form segment" method="POST" id="searchForm">
                    <div class="two fields">
                        <div class="field">
                            <div class="two fields">
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
                            </div>
                        </div>
                        <div class="field"></div>
                    </div>
                </form>
            </div>
        </div>
        <div class="ui one column page grid">
            <div class="column">
                <form class="ui fluid form segment" method="POST" id="updateForm">
                    <!--Form Edit Data-->
                    <div class="two fields">
                        <div class="field">
                            <h4 class="ui horizontal header divider">
                                <i class="info icon"></i>
                                Personal Information
                            </h4>
                        </div>
                        <div class="field">
                            <h4 class="ui horizontal header divider">
                                <i class="user icon"></i>
                                Account Information
                            </h4>
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Nama</label>
                            <input name="nama" id="namaM" disabled="disabled" placeholder="Nama" type="text" value="${nama}">
                        </div>
                        <input name="kode" type="hidden" value="${id}">
                        <input name="saldo" type="hidden" value="${saldo}">
                        <div class="field">
                            <label>Username</label>
                            <input name="username" id="usernameM" disabled="disabled" placeholder="Username" type="text" value="${user}">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <div class="two fields">
                                <div class="field">
                                    <label>Tempat Lahir</label>
                                    <input name="tempatLahir" id="tempatLahirM" disabled="disabled" placeholder="Tempat Lahir" type="text" value="${tempat}">
                                </div>
                                <div class="field">
                                    <label>Tanggal Lahir</label>
                                    <input name="tanggalLahir"  type="text" id="datePicker" placeholder="Tanggal Lahir" value="${tanggal}">
                                </div>
                            </div>
                        </div>
                        <div class="field">
                            <label>E-mail</label>
                            <input name="email" id="emailM" disabled="disabled" placeholder="E-mail" type="text" value="${email}">
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Alamat</label>
                            <input name="alamat" id="alamatM" disabled="disabled" placeholder="Alamat" type="text" value="${alamat}">
                        </div>
                        <div class="field">
                            <div class="two fields">
                                <div class="field">
                                    <label>Password</label>
                                    <input name="password" id="passwordM" disabled="disabled" placeholder="Password" type="password">
                                </div>
                                <div class="field">
                                    <label>Confirm Password</label>
                                    <input name="cpassword" id="cpasswordM" disabled="disabled" placeholder="Password" type="password">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="two fields">
                        <div class="field">
                            <label>Telepon</label>
                            <input name="telepon" id="teleponM" disabled="disabled" placeholder="Telepon" type="text" value="${nomor}">
                        </div>
                        <div class="field">
                            <button class="ui blue disabled button" type="submit" id="updateButton" name="updateData">Update</button>
                        </div>
                    </div>
                    <div class="field">
                        <!--Success Message-->
                        <div class="ui positive message" id="success">
                            <div class="header">
                                Update Data Member Berhasil
                            </div>
                            <p>Account dengan Username <b><%=request.getParameter("username")%></b> berhasil di update.</p>
                        </div>
                        <!--End of Success Message-->
                    </div>
                    <!--End of Form Edit Data-->
                </form>
            </div>
        </div>
        <!--Script-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <script src="date/jquery.plugin.js" type="text/javascript"></script>
        <script src="date/jquery.datepick.js" type="text/javascript"></script>
        <!--Local Script-->
        <script type="text/javascript">
            $(document).ready(function() {
                //Hide and Show Success Message
                $(document.getElementById("success")).hide();
            <%if (null != request.getParameter("username")) {%>
                $(document.getElementById("success")).show();
            <%}%>

                $(document.getElementById("up")).addClass("active");

                //Show dropdown on hover
                $('.ui.dropdown').dropdown({on: 'hover'});

                //Disable datepick
                $("#datePicker").datepick({dateFormat: 'dd-mm-yyyy'})
                        .datepick('disable');

                //Enable all field after searching
            <%
                if (session.getAttribute("user") != null) {
                    if (!session.getAttribute("user").equals("")) {
            %>
                $(document.getElementById("updateButton")).removeClass("disabled");
                $(document.getElementById("namaM")).removeAttr("disabled");
//                $(document.getElementById("usernameM")).removeAttr("disabled");
                $(document.getElementById("tempatLahirM")).removeAttr("disabled");
                $("#datePicker").datepick('enable');
                $(document.getElementById("emailM")).removeAttr("disabled");
                $(document.getElementById("teleponM")).removeAttr("disabled");
                $(document.getElementById("alamatM")).removeAttr("disabled");
                $(document.getElementById("passwordM")).removeAttr("disabled");
                $(document.getElementById("cpasswordM")).removeAttr("disabled");
            <%
                    }
                }
            %>

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

                //Search Form error prompt
                $("#searchForm").form({
                    search: {
                        identifier: 'user',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Username'}
                                ]
                    }
                });

                //Update Form error prompt
                $("#updateForm").form({
                    idfilm: {
                        identifier: 'nama',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Nama'}
                                ]
                    },
                    judul: {
                        identifier: 'tempatLahir',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Tempat Lahir'}
                                ]
                    },
                    genre: {
                        identifier: 'tanggalLahir',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Tanggal Lahir'}
                                ]
                    },
                    status: {
                        identifier: 'alamat',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Alamat'}
                                ]
                    },
                    kategori: {
                        identifier: 'telepon',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Nomor Telepon'}
                                ]
                    },
                    email: {identifier: 'email',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Alamat E-mail'},
                                    {type: 'email', prompt: 'Masukkan Alamat E-mail yang benar'}
                                ]
                    },
                    password: {
                        identifier: 'password',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Password'},
                                    {type: 'length[6]', prompt: 'Password harus lebih dari 6 karakter'}
                                ]
                    },
                    cpassword: {
                        identifier: 'cpassword',
                        rules:
                                [
                                    {type: 'empty', prompt: 'Masukkan Konfirmasi Password'},
                                    {type: 'match[password]', prompt: 'Password yang Anda masukkan tidak sesuai'}
                                ]
                    }
                },
                {
                    on: 'submit',
                    inline: 'true'
                });
            });
        </script>
        <!--End of Local Script-->
    </body>
</html>
