/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import forum.Post;
import model.PostForum;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Categories;

/**
 *
 * @author ADMIN
 */
public class ForumDAO extends DBContext {

    //list all post
    public List<PostForum> getAllPost() {
        List<PostForum> list = new ArrayList<>();
        String sql = "select * from Post";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PostForum p = new PostForum(rs.getInt("id"), rs.getString("title"),
                        rs.getString("coverImg"), rs.getString("img1"),
                        rs.getString("img2"), rs.getString("para1"),
                        rs.getString("para2"), rs.getString("quote"),
                        rs.getString("quote_author"));
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

    //get post by id
    public PostForum getPostByID(int id) {
        String sql = "select * from post where id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new PostForum(rs.getInt("id"), rs.getString("title"),
                        rs.getString("coverImg"), rs.getString("img1"),
                        rs.getString("img2"), rs.getString("para1"),
                        rs.getString("para2"), rs.getString("quote"),
                        rs.getString("quote_author"));
            }
        } catch (SQLException e) {

        }
        return null;
    }

    //get post status
    public List<String> getUniqueStatuses() {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM post WHERE status IS NOT NULL";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                statuses.add(rs.getString("status"));
            }
        } catch (SQLException e) {

        }
        return statuses;
    }

    //search post
    public List<PostForum> searchPost(String txt) {
        List<PostForum> list = new ArrayList<>();
        String sql = "Select * from Post where lower(title) like ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            String searchPattern = "%" + txt + "%";
            st.setString(1, searchPattern);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new PostForum(rs.getInt("id"), rs.getString("title"),
                        rs.getString("coverImg"), rs.getString("img1"),
                        rs.getString("img2"), rs.getString("para1"),
                        rs.getString("para2"), rs.getString("quote"),
                        rs.getString("quote_author")));
            }
        } catch (SQLException e) {

        }
        return list;
    }

    //get posts by status
    public List<PostForum> getPostByStatus(String status) {
        List<PostForum> list = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE status = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new PostForum(rs.getInt("id"), rs.getString("title"),
                        rs.getString("coverImg"), rs.getString("img1"),
                        rs.getString("img2"), rs.getString("para1"),
                        rs.getString("para2"), rs.getString("quote"),
                        rs.getString("quote_author")));
            }
        } catch (SQLException e) {

        }
        return list;
    }

    //add post
    public void addPost(String title, String coverImg, String img1, String img2, String para1, String para2, String quote, String quoteAuthor) {
        String sql = "INSERT INTO Post (title, coverImg, img1, img2, para1, para2, quote, quote_author, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'Active')";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, coverImg);
            st.setString(3, img1);
            st.setString(4, img2);
            st.setString(5, para1);
            st.setString(6, para2);
            st.setString(7, quote);
            st.setString(8, quoteAuthor);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //update post
    public void updatePost(int id, String title, String coverImg, String img1, String img2, String para1, String para2, String quote, String quoteAuthor) {
        String sql = "UPDATE Post SET title = ?, coverImg = ?, img1 = ?, img2 = ?, para1 = ?, para2 = ?, quote = ?, quote_author = ? WHERE id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, title);
            st.setString(2, coverImg);
            st.setString(3, img1);
            st.setString(4, img2);
            st.setString(5, para1);
            st.setString(6, para2);
            st.setString(7, quote);
            st.setString(8, quoteAuthor);
            st.setInt(9, id);
            st.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //archive post
    public void archivePost(int id) {
        String sql = "UPDATE post SET status = 'Archived' WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }

    //unarchive post
    public void unarchivePost(int id) {
        String sql = "UPDATE post SET status = 'Active' WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {

        }
    }

    public List<PostForum> getAllPostExceptChoosing(int postId) {
        List<PostForum> list = new ArrayList<>();
        String sql = "select * from Post where id != ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, postId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PostForum p = new PostForum(rs.getInt("id"), rs.getString("title"),
                        rs.getString("coverImg"), rs.getString("img1"),
                        rs.getString("img2"), rs.getString("para1"),
                        rs.getString("para2"), rs.getString("quote"),
                        rs.getString("quote_author"));
                list.add(p);
            }
        } catch (SQLException e) {

        }
        return list;
    }

}
