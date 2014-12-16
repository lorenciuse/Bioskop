<%-- 
    Document   : halaman-tambah-film
    Created on : Nov 14, 2014, 3:03:21 PM
    Author     : Lorencius
--%>
<%@page import="javax.sql.DataSource"%>
<%@page import="com.rplo.bioskop.model.DatabaseConnection"%>
<%@page import="com.rplo.bioskop.model.Film"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        if (session.getAttribute("username") == null) {
            out.print("<script>");
            out.print("alert(\"You don't have permission to access this page\");");
            out.print("window.location = 'home.jsp'");
            out.print("</script>");
        }

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
        <title>Tambah Film</title>
        <link rel="shortcut icon" href="img/OM-Item_Logo.png" type="image/png">
        <link href="Semantic-UI-1.0.0/dist/semantic.css" rel="stylesheet" type="text/css">
        <link href="dropper/jquery.fs.dropper.css" rel="stylesheet" type="text/css">
        <link href="Fixed-Header-Table-master/css/defaultTheme.css" type="text/css">
    </head>
    <body>
        <!--Add Film Sidebar-->
        <div class="ui very wide right vertical sidebar menu" id="addSidebar">
            <div class="item">
                <form class="ui form basic segment" enctype="multipart/form-data" method="POST" action="TambahDataFilm">
                    <div class="field">
                        <input name="idfilm" type="text" placeholder="ID Film">
                    </div>
                    <div class="field">
                        <input name="judul" type="text" placeholder="Judul">
                    </div>
                    <div class="field">
                        <input name="durasi" type="text" placeholder="Durasi">
                    </div>
                    <div class="field">
                        <input name="genre" type="text" placeholder="Genre">
                    </div>
                    <div class="three fields">
                        <div class="field">
                            <div class="ui fluid selection dropdown">
                                <input name="kategori" type="hidden">
                                <div class="default text">Kategori</div>
                                <i class="dropdown icon"></i>
                                <div class="menu">
                                    <div class="item" data-value="Dewasa" >Dewasa</div>
                                    <div class="item" data-value="Remaja" >Remaja</div>
                                    <div class="item" data-value="Semua Umur" >Semua Umur</div>
                                </div>
                            </div>
                        </div>
                        <div class="field">
                            <div class="ui action input">
                                <input type="text" id="_attachmentName" placeholder="Pilih Gambar">
                                <label for="attachmentName" class="ui icon button btn-file">
                                    <i class="photo icon"></i>
                                    <input type="file" id="attachmentName" name="attachmentName" style="display: none">
                                </label>
                            </div>
                        </div>
                        <div class="field">
                            <button class="ui blue button" type="submit">Simpan</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <!--End of Add Film Sidebar-->

        <div class="pusher">
            <!--Menu bar-->
            <%@include file="menubar-admin.jsp" %>
            <!--End of Menu bar-->

            <!--Film List Table-->
            <br><br><br><br>
            <div class="ui one column page grid">
                <div class="column">
                    <table class="ui blue padded table segment">
                        <thead>
                            <tr>
                                <th>Cover</th>
                                <th>ID Film</th>
                                <th>Judul</th>
                                <th>Durasi</th>
                                <th>Genre</th>
                                <th>Status</th>
                                <th>Kategori</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                DataSource dataSource = DatabaseConnection.getmDataSource();
                                List<Film> film = Film.getDataList();
                                for (int i = 0; i < film.size(); i++) {
                            %>
                            <tr>
                                <td><%out.print(film.get(i).getmGambar());%></td>
                                <td><%=film.get(i).getmKodeFilm()%></td>
                                <td><%=film.get(i).getmJudulFilm()%></td>
                                <td><%=Double.toString(film.get(i).getmDurasi()) + " Menit"%></td>
                                <td><%=film.get(i).getmGenre()%></td>
                                <td><%=film.get(i).getmStatus()%></td>
                                <td><%=film.get(i).getmKategori()%></td>
                            </tr>
                            <%}%>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="5">
                        <div class="ui blue labeled icon button" id="tambah">
                            <i class="video icon"></i> Tambah Film
                        </div>
                        </th>
                        </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
            <!--End of Film List Table-->
        </div>

        <!--Script-->
        <script src="Semantic-UI-1.0.0/dist/jquery-2.1.1.js" type="text/javascript"></script>
        <script src="Semantic-UI-1.0.0/dist/semantic.js" type="text/javascript"></script>
        <script src="Fixed-Header-Table-master/jquery.fixedheadertable.js" type="text/javascript"></script>
        <!--Local script-->
        <script type="text/javascript">
            $(document).ready(function() {
                var fileExtentionRange = '.jpg';
                var MAX_SIZE = 4; // MB

                $(document).on('change', '.btn-file :file', function() {
                    var input = $(this);

                    if (navigator.appVersion.indexOf("MSIE") != -1) { // IE
                        var label = input.val();

                        input.trigger('fileselect', [1, label, 0]);
                    } else {
                        var label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
                        var numFiles = input.get(0).files ? input.get(0).files.length : 1;
                        var size = input.get(0).files[0].size;

                        input.trigger('fileselect', [numFiles, label, size]);
                    }
                });

                $('.btn-file :file').on('fileselect', function(event, numFiles, label, size) {
                    $('#attachmentName').attr('name', 'attachmentName'); // allow upload.

                    var postfix = label.substr(label.lastIndexOf('.'));
                    if (fileExtentionRange.indexOf(postfix.toLowerCase()) > -1) {
                        if (size > 1024 * 1024 * MAX_SIZE) {
                            alert('max size：<strong>' + MAX_SIZE + '</strong> MB.');

                            $('#attachmentName').removeAttr('name'); // cancel upload file.
                        } else {
                            $('#_attachmentName').val(label);
                        }
                    } else {
                        alert('file type：<br/> <strong>' + fileExtentionRange + '</strong>');

                        $('#attachmentName').removeAttr('name'); // cancel upload file.
                    }
                });
//                $(document.getElementById("add")).addClass("active");
//                $('.dropper').dropper();

                //Show dropdown on hover
                $('.ui.dropdown').dropdown({on: 'hover'});

                //Tambah film button handler
                $("#tambah").click(function() {
                    $("#addSidebar")
                            .sidebar('setting', {overlay: true})
                            .sidebar('toggle');
                });

                //Add film sidebar error prompt
                $("#addSidebar").form({
                    idfilm: {
                        identifier: 'idfilm',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Masukkan ID Film'
                            }
                        ]
                    },
                    judul: {
                        identifier: 'judul',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Masukkan Judul Film'
                            }
                        ]
                    },
                    durasi: {
                        identifier: 'durasi',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Masukkan Durasi Film'
                            }
                        ]
                    },
                    genre: {
                        identifier: 'genre',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Masukkan Genre Film'
                            }]
                    },
                    kategori: {
                        identifier: 'kategori',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Pilih Kategori Film'
                            }
                        ]
                    },
                    gambar: {
                        identifier: 'attachmentName',
                        rules: [
                            {
                                type: 'empty',
                                prompt: 'Pilih Gambar Film'
                            }]
                    }
                }, {
                    on: 'submit',
                    inline: 'true'
                });
            });
        </script>
        <!--End of Local script-->
    </body>
</html>
