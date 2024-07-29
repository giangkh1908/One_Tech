/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DELL
 */
public class Bill {
     private String id;
    private String transactionID;
    private String productName;
    private String productID;
     private String code;
    private String seriNumber;
    private String status;

    public Bill() {
    }

    public Bill(String id, String transactionID, String productName, String productID, String code, String seriNumber, String status) {
        this.id = id;
        this.transactionID = transactionID;
        this.productName = productName;
        this.productID = productID;
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

    public String getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
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
        return "Bill{" + "id=" + id + ", transactionID=" + transactionID + ", productName=" + productName + ", productID=" + productID + ", code=" + code + ", seriNumber=" + seriNumber + ", status=" + status + '}';
    }
    
    
}
