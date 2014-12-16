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

    public static int sumTiket(String tanggal) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "select sum(total) "
                + "from (select tiket.kode_film, film.judul_film, "
                + "count(tiket.kode_film) as total, tiket.tanggal "
                + "from tiket "
                + "right join film on tiket.kode_film=film.kode_film "
                + "where tanggal=\'" + tanggal + "\' "
                + "group by tiket.kode_film, "
                + "film.judul_film,"
                + "tiket.tanggal)";

        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}
