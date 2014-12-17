/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rplo.bioskop.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.JdbcUtils;

/**
 *
 * @author Agustinus Agri
 */
public class Film {

    private String mKodeFilm;
    private String mJudulFilm;
    private double mDurasi;
    private String mGenre;
    private String mStatus;
    private String mKategori;
    private String mGambar;
    private static JdbcTemplate jdbcTemplate = new JdbcTemplate(DatabaseConnection.getmDataSource());

    public Film() {
    }

    public String getmKodeFilm() {
        return mKodeFilm;
    }

    public void setmKodeFilm(String mKodeFilm) {
        this.mKodeFilm = mKodeFilm;
    }

    public String getmJudulFilm() {
        return mJudulFilm;
    }

    public void setmJudulFilm(String mJudulFilm) {
        this.mJudulFilm = mJudulFilm;
    }

    public double getmDurasi() {
        return mDurasi;
    }

    public void setmDurasi(double mDurasi) {
        this.mDurasi = mDurasi;
    }

    public String getmGenre() {
        return mGenre;
    }

    public void setmGenre(String mGenre) {
        this.mGenre = mGenre;
    }

    public String getmStatus() {
        return mStatus;
    }

    public void setmStatus(String mStatus) {
        this.mStatus = mStatus;
    }

    public String getmKategori() {
        return mKategori;
    }

    public void setmKategori(String mKategori) {
        this.mKategori = mKategori;
    }

    public String getmGambar() {
        return mGambar;
    }

    public void setmGambar(String mGambar) {
        this.mGambar = mGambar;
    }
    
    public static String getGeneratedKodeFilm() {
        String sql = "SELECT 'F' || TO_CHAR(COUNT(KODE_FILM)+1, 'FM09999') FROM FILM";
        try {
        return jdbcTemplate.queryForObject(sql, String.class); }
        catch(Exception e) { return "F00001"; }
    }
    
    public static void simpanData(Film pFilm)
    {
        //DataSource dataSource = DatabaseConnection.getmDataSource();
        //JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "INSERT INTO film VALUES(?, ?, ?, ?, ? ,?)";

        jdbcTemplate.update(sql,
                new Object[]{
                    getGeneratedKodeFilm(),
                    pFilm.getmJudulFilm(),
                    pFilm.getmDurasi(),
                    pFilm.getmGenre(),
                    pFilm.getmStatus(),
                    pFilm.getmKategori()
                });
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }
    
    public static List<Film> getDataList() {
        //DataSource dataSource = DatabaseConnection.getmDataSource();
        List<Film> filmList = new ArrayList<Film>();

        String sql = "SELECT * FROM film";

        //JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        filmList = jdbcTemplate.query(sql, new FilmRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return filmList;
    }
    
    public static List<Film> getDataListNowPlaying() {
        //DataSource dataSource = DatabaseConnection.getmDataSource();
        List<Film> filmList = new ArrayList<Film>();

        String sql = "SELECT * FROM film WHERE status_film = 'Now Playing'";

        //JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        filmList = jdbcTemplate.query(sql, new FilmRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return filmList;
    }

    public static List<Film> getDataListbyKode(String kode) {
        //DataSource dataSource = DatabaseConnection.getmDataSource();
        List<Film> filmList = new ArrayList<Film>();

        String sql = "SELECT * FROM film WHERE kode_film = '" + kode + "'";

        //JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        filmList = jdbcTemplate.query(sql, new FilmRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return filmList;
    }
    
    public static String getJudul(String kode) {
        //DataSource dataSource = DatabaseConnection.getmDataSource();

        String sql = "SELECT judul_film FROM film WHERE kode_film = '" + kode + "'";

        //JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        return jdbcTemplate.queryForObject(sql, String.class);
        
    }

    public static class FilmRowMapper implements RowMapper<Film> {

        @Override
        public Film mapRow(ResultSet rs, int i) throws SQLException {
            FilmExtractor filmExtractor = new FilmExtractor();
            return filmExtractor.extractData(rs);
        }
    }

    public static class FilmExtractor implements ResultSetExtractor<Film> {

        @Override
        public Film extractData(ResultSet rs) throws SQLException, DataAccessException {
            Film film = new Film();
            
            film.setmKodeFilm(rs.getString(1));
            film.setmJudulFilm(rs.getString(2));
            film.setmDurasi(rs.getDouble(3));
            film.setmGenre(rs.getString(4));
            film.setmStatus(rs.getString(5));
            film.setmKategori(rs.getString(6));
            film.setmGambar("<img width='80' height='120' src='DisplayPhoto?kode="+film.getmKodeFilm()+ "'></img>");

            return film;
        }

    }

}
