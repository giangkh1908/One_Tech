/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Cart {

    private int id;
    private int userID;
    private String productID;
    private int quantity;
    private String imageURL;
    private String category;
    private String total;
    private int discount;

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }
    

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    

    public Cart() {
    }

    public Cart(int id, int userID, String productID, int quantity) {
        this.id = id;
        this.userID = userID;
        this.productID = productID;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Cart{" + "id=" + id + ", userID=" + userID + ", productID=" + productID + ", quantity=" + quantity + ", imageURL=" + imageURL + ", category=" + category + ", total=" + total + ", discount=" + discount + '}';
    }
    

}
