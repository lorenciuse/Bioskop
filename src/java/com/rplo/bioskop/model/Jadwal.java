/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.rplo.bioskop.model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Agustinus Agri
 */
public class Jadwal {

    private String mKodeJadwal;
    private String mKodeFilm;
    private String mKodeStudio;
    private String mJamTayang;
    private String mTanggalTayang;

    private static JdbcTemplate jdbcTemplate = new JdbcTemplate(DatabaseConnection.getmDataSource());

    public Jadwal() {
    }

    public String getmKodeJadwal() {
        return mKodeJadwal;
    }

    public void setmKodeJadwal(String mKodeJadwal) {
        this.mKodeJadwal = mKodeJadwal;
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

    public String getmJamTayang() {
        return mJamTayang;
    }

    public void setmJamTayang(String mJamTayang) {
        this.mJamTayang = mJamTayang;
    }

    public String getmTanggalTayang() {
        return mTanggalTayang;
    }

    public void setmTanggalTayang(String mTanggalTayang) {
        this.mTanggalTayang = mTanggalTayang;
    }

    public static String getGeneratedKodeJadwal() {
        String sql = "SELECT 'J' || TO_CHAR(COUNT(KODE_JADWAL)+1, 'FM09999') FROM JADWAL";
        return jdbcTemplate.queryForObject(sql, String.class);
    }

    public static List<Jadwal> getDataList() {
        List<Jadwal> jadwalList = new ArrayList<Jadwal>();
        String sql = "SELECT * FROM jadwal";

        try {
            jadwalList = jdbcTemplate.query(sql, new JadwalRowMapper());
            return jadwalList;
        } catch (Exception e) {
            return null;
        }

    }

    public static void simpanData(Jadwal pJadwal) {
        String sql = "INSERT INTO JADWAL VALUES(?,?,?,?,?)";
        jdbcTemplate.query(sql,
                new Object[]{
                    getGeneratedKodeJadwal(),
                    pJadwal.getmKodeFilm(),
                    pJadwal.getmKodeStudio(),
                    pJadwal.getmJamTayang(),
                    pJadwal.getmTanggalTayang()}, new JadwalRowMapper());
        
        sql = "UPDATE film SET status_film = 'Now Playing' WHERE kode_film = ?";
        jdbcTemplate.update(sql, new Object[]{pJadwal.getmKodeFilm()});
    }

    public static class JadwalRowMapper implements RowMapper<Jadwal> {

        @Override
        public Jadwal mapRow(ResultSet rs, int i) throws SQLException {
            JadwalExtractor jadwalExtractor = new JadwalExtractor();
            return jadwalExtractor.extractData(rs);
        }

    }

    public static class JadwalExtractor implements ResultSetExtractor<Jadwal> {

        @Override
        public Jadwal extractData(ResultSet rs) throws SQLException, DataAccessException {
            Jadwal jadwal = new Jadwal();

            jadwal.setmKodeJadwal(rs.getString(1));
            jadwal.setmKodeFilm(rs.getString(2));
            jadwal.setmKodeStudio(rs.getString(3));
            jadwal.setmJamTayang(rs.getString(4));
            jadwal.setmTanggalTayang(rs.getString(5));

            return jadwal;
        }

    }

    public static void main(String[] args) {
        List<Jadwal> jadwalList = Jadwal.getDataList();
        for (int i = 0; i < jadwalList.size(); i++) {
            System.out.println(jadwalList.get(i).getmKodeFilm());
            System.out.println(Film.getJudul(jadwalList.get(i).getmKodeFilm()));
        }
        System.out.println("done");
    }
}


