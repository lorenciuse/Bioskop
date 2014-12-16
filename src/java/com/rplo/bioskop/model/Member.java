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
public class Member {

    private String mKodeMember;
    private String mUsernameMember;
    private String mPasswordMember;
    private String mNamaMember;
    private String mTanggalLahir;
    private String mAlamatMember;
    private String mEmail;
    private String mGender;
    private String mNomorTelepon;
    private String mTempatLahir;
    private int mSaldo;

    public Member() {
    }

    public String getmEmail() {
        return mEmail;
    }

    public void setmEmail(String mEmail) {
        this.mEmail = mEmail;
    }

    public String getmKodeMember() {
        return mKodeMember;
    }

    public String getmAlamatMember() {
        return mAlamatMember;
    }

    public void setmAlamatMember(String mAlamatMember) {
        this.mAlamatMember = mAlamatMember;
    }

    public void setmKodeMember(String mKodeMember) {
        this.mKodeMember = mKodeMember;
    }

    public String getmNamaMember() {
        return mNamaMember;
    }

    public void setmNamaMember(String mNamaMember) {
        this.mNamaMember = mNamaMember;
    }

    public String getmGender() {
        return mGender;
    }

    public void setmGender(String mGender) {
        this.mGender = mGender;
    }

    public String getmNomorTelepon() {
        return mNomorTelepon;
    }

    public void setmNomorTelepon(String mNomorTelepon) {
        this.mNomorTelepon = mNomorTelepon;
    }

    public int getmSaldo() {
        return mSaldo;
    }

    public void setmSaldo(int mSaldo) {
        this.mSaldo = mSaldo;
    }

    public String getmTanggalLahir() {
        return mTanggalLahir;
    }

    public void setmTanggalLahir(String mTanggalLahir) {
        this.mTanggalLahir = mTanggalLahir;
    }

    public String getmTempatLahir() {
        return mTempatLahir;
    }

    public void setmTempatLahir(String mTempatLahir) {
        this.mTempatLahir = mTempatLahir;
    }

    public String getmUsernameMember() {
        return mUsernameMember;
    }

    public void setmUsernameMember(String mUsernameMember) {
        this.mUsernameMember = mUsernameMember;
    }

    public String getmPasswordMember() {
        return mPasswordMember;
    }

    public void setmPasswordMember(String mPasswordMember) {
        this.mPasswordMember = mPasswordMember;
    }

    /**
     * Memvalidasi login user, akan mengembalikan nilai int sesuai dengan hasil
     * validasi
     *
     * @param pUsername username yang diinputkan user
     * @param pPassword password yang diinputkan user
     * @return 0 - unregistered username; 1 - wrong username/password; 2 - login
     * as MEMBER accepted;
     */
    public static int validateLoginCredential(String pUsername, String pPassword) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List<Member> memberList = new ArrayList<Member>();

        String sql = "SELECT * FROM member_bioskop WHERE username_member = \'" + pUsername + "\'";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        memberList = jdbcTemplate.query(sql, new MemberRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());

        if (!memberList.isEmpty()) {
            String username = memberList.get(0).getmUsernameMember();
            String password = memberList.get(0).getmPasswordMember();
            if (pUsername.equalsIgnoreCase(username) && pPassword.equals(password)) {
                System.out.println("username : " + username);
                return 2;
            } else {
                System.out.println("WRONG USERNAME/PASSWORD");
                return 1;
            }
        } else {
            System.out.println("UNREGISTERED USERNAME");
            return 0;
        }
    }

    public static void simpanData(Member pMember) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        String sql = "INSERT INTO member_bioskop VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        jdbcTemplate.update(sql,
                new Object[]{
                    pMember.getmKodeMember(),
                    pMember.getmUsernameMember(),
                    pMember.getmPasswordMember(),
                    pMember.getmNamaMember(),
                    pMember.getmTanggalLahir(),
                    pMember.getmAlamatMember(),
                    pMember.getmEmail(),
                    pMember.getmNomorTelepon(),
                    pMember.getmSaldo(),
                    pMember.getmTempatLahir(),
                    pMember.getmGender()
                });
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }

    public static List<Member> getDataList() {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List memberList = new ArrayList();

        String sql = "SELECT * FROM member_bioskop";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        memberList = jdbcTemplate.query(sql, new MemberRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return memberList;
    }

    public static List<Member> getDataListbyUser(String user) {
        DataSource dataSource = DatabaseConnection.getmDataSource();
        List memberList = new ArrayList();

        String sql = "SELECT * FROM member_bioskop WHERE username_member = \'" + user + "\'";

        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        memberList = jdbcTemplate.query(sql, new MemberRowMapper());
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
        return memberList;
    }

    public static void updateData(Member pMember) {
        DataSource dataSource = DatabaseConnection.getmDataSource();

        String sql = "UPDATE member_bioskop SET "
                + "password_member = ?, "
                + "nama_member = ?, "
                + "tgl_member = ?, "
                + "alamat_member = ?, "
                + "email_member = ?, "
                + "no_telp_member = ?, "
                + "tl_member = ? "
                + "WHERE kode_member = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        jdbcTemplate.update(sql,
                new Object[]{
                    pMember.getmPasswordMember(),
                    pMember.getmNamaMember(),
                    pMember.getmTanggalLahir(),
                    pMember.getmAlamatMember(),
                    pMember.getmEmail(),
                    pMember.getmNomorTelepon(),
                    pMember.getmTempatLahir(),
                    pMember.getmKodeMember()
                });
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }

    public static void updateSaldo(Member pMember) {
        DataSource dataSource = DatabaseConnection.getmDataSource();

        String sql = "UPDATE member_bioskop SET "
                + "saldo_member = ? "
                + "WHERE kode_member = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

        jdbcTemplate.update(sql,
                new Object[]{
                    pMember.getmSaldo(),
                    pMember.getmKodeMember()
                });
        JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
    }

    public static boolean isUsernameExist(String pUsername) {
        DataSource dataSource = DatabaseConnection.getmDataSource();

        String sql = "SELECT USERNAME_MEMBER FROM MEMBER_BIOSKOP WHERE USERNAME_MEMBER = ?";
        JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);
        try {
            jdbcTemplate.queryForObject(sql, String.class, pUsername);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public static class MemberRowMapper implements RowMapper<Member> {

        @Override
        public Member mapRow(ResultSet rs, int i) throws SQLException {
            MemberExtractor memberExtractor = new MemberExtractor();
            return memberExtractor.extractData(rs);
        }

    }

    public static class MemberExtractor implements ResultSetExtractor<Member> {

        @Override
        public Member extractData(ResultSet rs) throws SQLException, DataAccessException {
            Member member = new Member();

            member.setmKodeMember(rs.getString(1));
            member.setmUsernameMember(rs.getString(2));
            member.setmPasswordMember(rs.getString(3));
            member.setmNamaMember(rs.getString(4));
            member.setmTanggalLahir(rs.getString(5));
            member.setmAlamatMember(rs.getString(6));
            member.setmEmail(rs.getString(7));
            member.setmNomorTelepon(rs.getString(8));
            member.setmSaldo(rs.getInt(9));
            member.setmTempatLahir(rs.getString(10));
            member.setmGender(rs.getString(11));

            return member;
        }
    }
        
        public static String cariIdTerakhir(){
            String id;
            DataSource dataSource = DatabaseConnection.getmDataSource();
            
            String sql = "select TO_CHAR((count(*)+1), 'FM009') AS terakhir from member_bioskop";
            JdbcTemplate jdbc = new JdbcTemplate(dataSource);
            id = jdbc.queryForObject(sql, String.class).toString();
            JdbcUtils.closeConnection(DatabaseConnection.getmConnection());
            return id;
        }
}
