/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class Repository {

    String id;
    String productId;
    String price;
    String discount;
    String code;
    String seriNumber;
    String status;
    String creationDate;

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public Repository(String id, String productId, String price, String discount, String code, String seriNumber, String status, String creationDate) {
        this.id = id;
        this.productId = productId;
        this.price = price;
        this.discount = discount;
        this.code = code;
        this.seriNumber = seriNumber;
        this.status = status;
        this.creationDate = creationDate;
    }
    

    
    public Repository() {
    }

    public Repository(String productId, String code, String seriNumber) {
        this.productId = productId;
        this.code = code;
        this.seriNumber = seriNumber;
    }

    public Repository(String id, String productId, String code, String seriNumber, String status) {
        this.id = id;
        this.productId = productId;
        this.code = code;
        this.seriNumber = seriNumber;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getSeriNumber() {
        return seriNumber;
    }

    public void setSeriNumber(String seriNumber) {
        this.seriNumber = seriNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Repository{" + "id=" + id + ", productId=" + productId + ", price=" + price + ", discount=" + discount + ", code=" + code + ", seriNumber=" + seriNumber + ", status=" + status + ", creationDate=" + creationDate + '}';
    }

  

}
