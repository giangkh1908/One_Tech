package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author DELL
 */
public class Transaction {
    String id, transactionType, amount, beforeTransactMoney, afterTransactMoney, userId, creationDate, description, transactionCode;

    public Transaction(String id, String transactionType, String amount, String beforeTransactMoney, String afterTransactMoney, String userId, String creationDate, String description, String transactionCode) {
        this.id = id;
        this.transactionType = transactionType;
        this.amount = amount;
        this.beforeTransactMoney = beforeTransactMoney;
        this.afterTransactMoney = afterTransactMoney;
        this.userId = userId;
        this.creationDate = creationDate;
        this.description = description;
        this.transactionCode = transactionCode;
    }

    public Transaction(String id, String transactionType, String amount, String beforeTransactMoney, String afterTransactMoney, String userId, String creationDate, String description) {
        this.id = id;
        this.transactionType = transactionType;
        this.amount = amount;
        this.beforeTransactMoney = beforeTransactMoney;
        this.afterTransactMoney = afterTransactMoney;
        this.userId = userId;
        this.creationDate = creationDate;
        this.description = description;
    }

    public String getTransactionCode() {
        return transactionCode;
    }

    public void setTransactionCode(String transactionCode) {
        this.transactionCode = transactionCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Transaction(String id, String transactionType, String amount, String beforeTransactMoney, String afterTransactMoney, String userId, String creationDate) {
        this.id = id;
        this.transactionType = transactionType;
        this.amount = amount;
        this.beforeTransactMoney = beforeTransactMoney;
        this.afterTransactMoney = afterTransactMoney;
        this.userId = userId;
        this.creationDate = creationDate;
    }

    public String getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(String creationDate) {
        this.creationDate = creationDate;
    }

    public Transaction(String id, String transactionType, String amount, String beforeTransactMoney, String afterTransactMoney, String userId) {
        this.id = id;
        this.transactionType = transactionType;
        this.amount = amount;
        this.beforeTransactMoney = beforeTransactMoney;
        this.afterTransactMoney = afterTransactMoney;
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Transaction{" + "id=" + id + ", transactionType=" + transactionType + ", amount=" + amount + ", beforeTransactMoney=" + beforeTransactMoney + ", afterTransactMoney=" + afterTransactMoney + ", userId=" + userId + ", creationDate=" + creationDate + '}';
    }

    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public String getAmount() {
        
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getBeforeTransactMoney() {
        return beforeTransactMoney;
    }

    public void setBeforeTransactMoney(String beforeTransactMoney) {
        this.beforeTransactMoney = beforeTransactMoney;
    }

    public String getAfterTransactMoney() {
        return afterTransactMoney;
    }

    public void setAfterTransactMoney(String afterTransactMoney) {
        this.afterTransactMoney = afterTransactMoney;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    
}
