/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rplo.bioskop.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Agustinus Agri
 */
public class Tiket {

    private String mKodeTiket;
    private String mKodeFilm;
    private String mKodeStudio;
    private String mKodeKursi;
    private String mKodeMember;

    public Tiket() {
    }

    public String getmKodeTiket() {
        return mKodeTiket;
    }

    public void setmKodeTiket(String mKodeTiket) {
        this.mKodeTiket = mKodeTiket;
    }

    public String getmKodeFilm() {
        return mKodeFilm;
    }

    public void setmKodeFilm(String mKodeFilm) {
        this.mKodeFilm = mKodeFilm;
    }

    public String getmKodeStudio() {
        return mKodeStudio;
    }

    public void setmKodeStudio(String mKodeStudio) {
        this.mKodeStudio = mKodeStudio;
    }

    public String getmKodeKursi() {
        return mKodeKursi;
    }

    public void setmKodeKursi(String mKodeKursi) {
        this.mKodeKursi = mKodeKursi;
    }

    public String getmKodeMember() {
        return mKodeMember;
    }

    public void setmKodeMember(String mKodeMember) {
        this.mKodeMember = mKodeMember;
    }

    public static void simpanData(Tiket pTiket) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "INSERT INTO tiket VALUES(?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
                new Object[]{
                    pTiket.getmKodeTiket(),
                    pTiket.getmKodeFilm(),
                    pTiket.getmKodeKursi(),
                    pTiket.getmKodeStudio(),
                    pTiket.getmKodeMember()
                });
    }

    public static void cariKursiKosong() {

    }

    public static class FilmRowMapper implements RowMapper<Tiket> {

        @Override
        public Tiket mapRow(ResultSet rs, int i) throws SQLException {
            TiketExtractor tiketExtractor = new TiketExtractor();
            return tiketExtractor.extractData(rs);
        }

    }

    public static class TiketExtractor implements ResultSetExtractor<Tiket> {

        @Override
        public Tiket extractData(ResultSet rs) throws SQLException, DataAccessException {
            Tiket tiket = new Tiket();

            tiket.setmKodeTiket(rs.getString(1));
            tiket.setmKodeFilm(rs.getString(2));
            tiket.setmKodeStudio(rs.getString(3));
            tiket.setmKodeKursi(rs.getString(4));
            tiket.setmKodeMember(rs.getString(5));

            return tiket;
        }

    }

    public static int sumTiket_date(String tanggal_awal, String tanggal_akhir) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select sum(jumlah) from (select t.kode_jadwal,f.kode_film, "
                + "f.judul_film,j.jam_tayang,j.tanggal_tayang, count(t.kode_jadwal) as jumlah, "
                + "sum(t.harga)as total"
                + "from tiket_bioskop t join jadwal_film_bioskop j"
                + "on t.kode_jadwal=j.kode_jadwal"
                + "join film_bioskop f"
                + "on j.kode_film=f.kode_film"
                + "where tanggal between \'" + tanggal_awal + "\' and \'" + tanggal_akhir + "\'"
                + "group by t.kode_jadwal,f.kode_film,f.judul_film,j.jam_tayang,j.tanggal_tayang)";
        
        sql = "select sum(jumlah) from (select t.kode_jadwal,f.kode_film, f.judul_film,j.jam_tayang,j.tanggal_tayang, count(t.kode_jadwal) as jumlah, sum(t.harga)as total \n"
                + "from tiket_bioskop t join jadwal_film_bioskop j \n"
                + "on t.kode_jadwal=j.kode_jadwal \n"
                + "join film_bioskop f \n"
                + "on j.kode_film=f.kode_film \n"
                + "where tanggal between \'" + tanggal_awal + "\' and \'" + tanggal_akhir + "\' \n"
                + "group by t.kode_jadwal,f.kode_film,f.judul_film,j.jam_tayang,j.tanggal_tayang)";

        System.out.println(sql);

        return jdbcTemplate.queryForObject(sql, Integer.class);
//        return jdbcTemplate.queryForInt(sql);
    }

    public static int sumharga_date(String tanggal_awal, String tanggal_akhir) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select sum(total) from (select t.kode_jadwal,f.kode_film, "
                + "f.judul_film,j.jam_tayang,j.tanggal_tayang, count(t.kode_jadwal) as jumlah, "
                + "sum(t.harga)as total"
                + "from tiket_bioskop t join jadwal_film_bioskop j"
                + "on t.kode_jadwal=j.kode_jadwal"
                + "join film_bioskop f"
                + "on j.kode_film=f.kode_film"
                + "where tanggal between \'" + tanggal_awal + "\' and \'" + tanggal_akhir + "\'"
                + "group by t.kode_jadwal,f.kode_film,f.judul_film,j.jam_tayang,j.tanggal_tayang)";

        sql = "select sum(total) from (select t.kode_jadwal,f.kode_film, f.judul_film,j.jam_tayang,j.tanggal_tayang, count(t.kode_jadwal) as jumlah, sum(t.harga)as total \n"
                + "from tiket_bioskop t join jadwal_film_bioskop j \n"
                + "on t.kode_jadwal=j.kode_jadwal \n"
                + "join film_bioskop f \n"
                + "on j.kode_film=f.kode_film \n"
                + "where tanggal between \'" + tanggal_awal + "\' and \'" + tanggal_akhir + "\' \n"
                + "group by t.kode_jadwal,f.kode_film,f.judul_film,j.jam_tayang,j.tanggal_tayang)";

        System.out.println(sql);

        return jdbcTemplate.queryForObject(sql, Integer.class);
//        return jdbcTemplate.queryForInt(sql);
    }

    public static int sumtiket_sysdate() {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select sum(jumlah) from (select t.kode_jadwal,f.kode_film, "
                + "f.judul_film,j.jam_tayang,j.tanggal_tayang, count(t.kode_jadwal) as jumlah, "
                + "sum(t.harga)as total"
                + "from tiket_bioskop t join jadwal_film_bioskop j"
                + "on t.kode_jadwal=j.kode_jadwal"
                + "join film_bioskop f"
                + "on j.kode_film=f.kode_film"
                + "where tanggal like sysdate"
                + "group by t.kode_jadwal,f.kode_film,f.judul_film,j.jam_tayang,j.tanggal_tayang)";
        

        return jdbcTemplate.queryForObject(sql, Integer.class);
    }

    public static int sumharga_sysdate() {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select sum(total) from (select t.kode_jadwal,f.kode_film, "
                + "f.judul_film,j.jam_tayang,j.tanggal_tayang, count(t.kode_jadwal) as jumlah, "
                + "sum(t.harga)as total"
                + "from tiket_bioskop t join jadwal_film_bioskop j"
                + "on t.kode_jadwal=j.kode_jadwal"
                + "join film_bioskop f"
                + "on j.kode_film=f.kode_film"
                + "where tanggal like sysdate"
                + "group by t.kode_jadwal,f.kode_film,f.judul_film,j.jam_tayang,j.tanggal_tayang)";

        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
