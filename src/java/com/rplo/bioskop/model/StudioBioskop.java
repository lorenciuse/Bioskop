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
import javax.sql.DataSource;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author root
 */
public class StudioBioskop {

    private String mKodeStudio;
    private String mNamaStudio;

    public StudioBioskop() {
    }

    public String getmKodeStudio() {
        return mKodeStudio;
    }

    public void setmKodeStudio(String mKodeStudio) {
        this.mKodeStudio = mKodeStudio;
    }

    public String getmNamaStudio() {
        return mNamaStudio;
    }

    public void setmNamaStudio(String mNamaStudio) {
        this.mNamaStudio = mNamaStudio;
    }

    public static void simpanData(StudioBioskop pStudioBioskop) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "INSERT INTO studio_bioskop VALUES(?, ?)";

        jdbcTemplate.update(sql,
                new Object[]{
                    pStudioBioskop.getmKodeStudio(),
                    pStudioBioskop.getmNamaStudio()
                });
    }

    public static List<StudioBioskop> getDataList() {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List pegawaiList = new ArrayList();

        String sql = "SELECT * FROM studio_bioskop";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        pegawaiList = jdbcTemplate.query(sql, new StudioBioskopRowMapper());
        return pegawaiList;
    }

    public static class StudioBioskopRowMapper implements RowMapper<StudioBioskop> {

        @Override
        public StudioBioskop mapRow(ResultSet rs, int i) throws SQLException {
            StudioBioskopExtractor studioBioskopExtractor = new StudioBioskopExtractor();
            return studioBioskopExtractor.extractData(rs);
        }

    }

    public static class StudioBioskopExtractor implements ResultSetExtractor<StudioBioskop> {

        @Override
        public StudioBioskop extractData(ResultSet rs) throws SQLException, DataAccessException {
            StudioBioskop studioBioskop = new StudioBioskop();

            studioBioskop.setmKodeStudio(rs.getString(1));
            studioBioskop.setmNamaStudio(rs.getString(2));

            return studioBioskop;
        }

    }

}
