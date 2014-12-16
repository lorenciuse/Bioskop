/*
 * To change this template, choose Tools | Templates
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
public class DataPegawai {

    private String mKodePegawai;
    private String mUsernamePegawai;
    private String mPaswordPegawai;
    private String mNamaPegawai;
    private String mTempatTanggalLahir;
    private String mAlamatPegawai;
    private String mEmailPegawai;
    private String mNomorTelepon;
    private String mRolePegawai;

    /**
     * 1 : OPERATOR 2 : ADMIN
     */
    public static class Role {

        public static final String OPERATOR = "OPERATOR"; 
        public static final String ADMIN = "ADMIN";
    }

    public DataPegawai() {
    }

    public String getmKodePegawai() {
        return mKodePegawai;
    }

    public void setmKodePegawai(String mKodePegawai) {
        this.mKodePegawai = mKodePegawai;
    }

    public String getmUsernamePegawai() {
        return mUsernamePegawai;
    }

    public void setmUsernamePegawai(String mUsernamePegawai) {
        this.mUsernamePegawai = mUsernamePegawai;
    }

    public String getmPaswordPegawai() {
        return mPaswordPegawai;
    }

    public void setmPaswordPegawai(String mPaswordPegawai) {
        this.mPaswordPegawai = mPaswordPegawai;
    }

    public String getmNamaPegawai() {
        return mNamaPegawai;
    }

    public void setmNamaPegawai(String mNamaPegawai) {
        this.mNamaPegawai = mNamaPegawai;
    }

    public String getmTempatTanggalLahir() {
        return mTempatTanggalLahir;
    }

    public void setmTempatTanggalLahir(String mTempatTanggalLahir) {
        this.mTempatTanggalLahir = mTempatTanggalLahir;
    }

    public String getmAlamatPegawai() {
        return mAlamatPegawai;
    }

    public void setmAlamatPegawai(String mAlamatPegawai) {
        this.mAlamatPegawai = mAlamatPegawai;
    }

    public String getmEmailPegawai() {
        return mEmailPegawai;
    }

    public void setmEmailPegawai(String mEmailPegawai) {
        this.mEmailPegawai = mEmailPegawai;
    }

    public String getmNomorTelepon() {
        return mNomorTelepon;
    }

    public void setmNomorTelepon(String mNomorTelepon) {
        this.mNomorTelepon = mNomorTelepon;
    }

    public String getmRolePegawai() {
        return mRolePegawai;
    }

    public void setmRolePegawai(String mRolePegawai) {
        this.mRolePegawai = mRolePegawai;
    }

    public static void simpanData(DataPegawai pPegawai) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "INSERT INTO pegawai_bioskop VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
                new Object[]{
                    pPegawai.getmKodePegawai(),
                    pPegawai.getmUsernamePegawai(),
                    pPegawai.getmPaswordPegawai(),
                    pPegawai.getmNamaPegawai(),
                    pPegawai.getmTempatTanggalLahir(),
                    pPegawai.getmAlamatPegawai(),
                    pPegawai.getmEmailPegawai(),
                    pPegawai.getmNomorTelepon(),
                    pPegawai.getmRolePegawai()
                });
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }

    public static List<DataPegawai> getDataList() {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List<DataPegawai> pegawaiList = new ArrayList<DataPegawai>();

        String sql = "SELECT * FROM pegawai_bioskop";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        pegawaiList = jdbcTemplate.query(sql, new PegawaiRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return pegawaiList;
    }

    public static List<DataPegawai> getDataListByUsername(String pUsername) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List<DataPegawai> pegawaiList = new ArrayList<DataPegawai>();

        String sql = "SELECT * FROM pegawai_bioskop WHERE username_pegawai = '" + pUsername + "'";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        pegawaiList = jdbcTemplate.query(sql, new PegawaiRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return pegawaiList;
    }

    /**
     * Memvalidasi login user, akan mengembalikan nilai int sesuai dengan hasil
     * validasi
     *
     * @param pUsername username yang diinputkan user
     * @param pPassword password yang diinputkan user
     * @param pRole role yang dipilih user
     * @return 0 - unregistered username; 1 - wrong username/password; 2 - login
     * as PEGAWAI accepted; 3 - login as ADMIN accepted;
     */
    public static int validateLoginCredential(String pUsername, String pPassword, String pRole) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List<DataPegawai> pegawaiList = new ArrayList<DataPegawai>();

        String sql = "SELECT * FROM pegawai_bioskop WHERE username_pegawai = ?";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        pegawaiList = jdbcTemplate.query(sql, new PegawaiRowMapper(), pUsername.toUpperCase());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());

        if (!pegawaiList.isEmpty()) {
            String username = pegawaiList.get(0).getmUsernamePegawai();
            String password = pegawaiList.get(0).getmPaswordPegawai();
            String role = pegawaiList.get(0).getmRolePegawai();
            if (pUsername.equalsIgnoreCase(username) && pPassword.equals(password) && pRole.equals(role)) {
                System.out.println("ROLE : " + role);
                if (role.equals(Role.OPERATOR)) {
                    return 2;
                } else if (role.equals(Role.ADMIN)) {
                    return 3;
                }
            } else {
                System.out.println("WRONG USERNAME/PASSWORD/ROLE");
                return 1;
            }
        } else {
            System.out.println("UNREGISTERED USERNAME");
            return 0;
        }

        return -1;
    }

    public static void updateData(DataPegawai pPegawai) {
        DataSource dataSource = DatabaseConnection.getmDataSource();

        String sql = "UPDATE pegawai SET "
                + "username_pegawai = ?, "
                + "password_pegawai = ?, "
                + "nama_pegawai = ?, "
                + "ttl_pegawai = ?, "
                + "alamat_pegawai = ?, "
                + "email_pegawai = ?, "
                + "no_telp_pegawai = ?, "
                + "role_pegawai = ? "
                + "WHERE kode_pegawai = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        jdbcTemplate.update(sql,
                new Object[]{
                    pPegawai.getmUsernamePegawai(),
                    pPegawai.getmPaswordPegawai(),
                    pPegawai.getmNamaPegawai(),
                    pPegawai.getmTempatTanggalLahir(),
                    pPegawai.getmAlamatPegawai(),
                    pPegawai.getmEmailPegawai(),
                    pPegawai.getmNomorTelepon(),
                    pPegawai.getmKodePegawai(),
                    pPegawai.getmRolePegawai()
                });
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }

    public static void deleteData(String pKodePegawai) {
        DataSource dataSource = DatabaseConnection.getmDataSource();

        String sql = "DELETE FROM pegawai WHERE kode_pegawai = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        jdbcTemplate.update(sql, 
                new Object[]{pKodePegawai});
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }

    public static class PegawaiRowMapper implements RowMapper<DataPegawai> {

        @Override
        public DataPegawai mapRow(ResultSet rs, int i) throws SQLException {
            PegawaiExtractor pegawaiExtractor = new PegawaiExtractor();
            return pegawaiExtractor.extractData(rs);
        }

    }

    public static class PegawaiExtractor implements ResultSetExtractor<DataPegawai> {

        @Override
        public DataPegawai extractData(ResultSet rs) throws SQLException, DataAccessException {
            DataPegawai pegawai = new DataPegawai();

            pegawai.setmKodePegawai(rs.getString(1));
            pegawai.setmUsernamePegawai(rs.getString(2));
            pegawai.setmPaswordPegawai(rs.getString(3));
            pegawai.setmNamaPegawai(rs.getString(4));
            pegawai.setmTempatTanggalLahir(rs.getString(5));
            pegawai.setmAlamatPegawai(rs.getString(6));
            pegawai.setmEmailPegawai(rs.getString(7));
            pegawai.setmNomorTelepon(rs.getString(8));
            pegawai.setmRolePegawai(rs.getString(9));

            return pegawai;
        }

    }

}
