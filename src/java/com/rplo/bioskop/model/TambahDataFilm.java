package com.rplo.bioskop.model;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.jdbc.core.JdbcTemplate;

public class TambahDataFilm extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            DataSource dataSource = DatabaseConnection.getmDataSource();
            Connection con = DatabaseConnection.getmConnection();
//            JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
            // Apache Commons-Fileupload library classes
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload sfu = new ServletFileUpload(factory);

            if (!ServletFileUpload.isMultipartContent(request)) {
                System.out.println("sorry. No file uploaded");
                return;
            }

            // parse request
            List items = sfu.parseRequest(request);
            FileItem id = (FileItem) items.get(0);
            String idfilm = id.getString();

            FileItem judul = (FileItem) items.get(1);
            String judulfilm = judul.getString();

            FileItem durasi = (FileItem) items.get(2);
            String durasifilm = durasi.getString();

            FileItem genre = (FileItem) items.get(3);
            String genrefilm = genre.getString();

            String statusfilm = "Coming Soon";

            FileItem kategori = (FileItem) items.get(4);
            String kategorifilm = kategori.getString();

            // get uploaded file
            FileItem file = (FileItem) items.get(5);

            // Connect to Oracle
//            Class.forName("oracle.jdbc.driver.OracleDriver");
//            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mhs125314109", "mhs125314109");
            con.setAutoCommit(false);

            String sql = "INSERT INTO film_bioskop VALUES(?, ?, ?, ?, ?, ? ,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, idfilm);
            ps.setString(2, judulfilm);
            ps.setString(3, durasifilm);
            ps.setString(4, genrefilm);
            ps.setString(5, statusfilm);
            ps.setString(6, kategorifilm);
            // size must be converted to int otherwise it results in error
            ps.setBinaryStream(7, file.getInputStream(), (int) file.getSize());
//            jdbcTemplate.update(sql, ps);
            ps.executeUpdate();
            con.commit();
            con.close();
//            out.println("Proto Added Successfully. <p> <a href='ListPhotosServlet'>List Photos </a>");
            out.print("<script>");
            out.print("alert(\"Data Film berhasil ditambahkan\");");
            out.print("window.location = 'halaman-tambah-film.jsp';");
            out.print("</script>");
        } catch (Exception ex) {
            out.println("Error --> " + ex.getMessage());
        }
    }
}
