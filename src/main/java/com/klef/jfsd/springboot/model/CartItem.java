package com.klef.jfsd.springboot.model;

public class CartItem {
    private int id;
    private String name;
    private String category;
    private double cost;
    private int quantity;

    // Constructors
    public CartItem() {}

    public CartItem(int id, String name, String category, double cost, int quantity) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.cost = cost;
        this.quantity = quantity;
    }

    
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getCost() { return cost; }
    public void setCost(double cost) { this.cost = cost; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

}
