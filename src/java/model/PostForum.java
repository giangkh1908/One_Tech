/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class PostForum {
    private int id;
    private String title;
    private String coverImg;
    private String img1;
    private String img2;
    private String para1;
    private String para2;
    private String quote;
    private String quote_author;

    public PostForum() {
    }

    public PostForum(int id, String title, String coverImg, String img1, String img2, String para1, String para2, String quote, String quote_author) {
        this.id = id;
        this.title = title;
        this.coverImg = coverImg;
        this.img1 = img1;
        this.img2 = img2;
        this.para1 = para1;
        this.para2 = para2;
        this.quote = quote;
        this.quote_author = quote_author;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCoverImg() {
        return coverImg;
    }

    public void setCoverImg(String coverImg) {
        this.coverImg = coverImg;
    }

    public String getImg1() {
        return img1;
    }

    public void setImg1(String img1) {
        this.img1 = img1;
    }

    public String getImg2() {
        return img2;
    }

    public void setImg2(String img2) {
        this.img2 = img2;
    }

    public String getPara1() {
        return para1;
    }

    public void setPara1(String para1) {
        this.para1 = para1;
    }

    public String getPara2() {
        return para2;
    }

    public void setPara2(String para2) {
        this.para2 = para2;
    }

    public String getQuote() {
        return quote;
    }

    public void setQuote(String quote) {
        this.quote = quote;
    }

    public String getQuote_author() {
        return quote_author;
    }

    public void setQuote_author(String quote_author) {
        this.quote_author = quote_author;
    }
    
    
    
    
}
