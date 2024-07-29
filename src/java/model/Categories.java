/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author KimHo
 */
public class Categories {
    private int id;
    private String name, status;

    public Categories() {
    }

    public Categories(int id, String name, String status) {
        this.id = id;
        this.name = name;
        this.status = status;
    }

    public Categories(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public Categories(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Categories{" + "id=" + id + ", name=" + name + ", status=" + status + '}';
    }
    
    
    
}
