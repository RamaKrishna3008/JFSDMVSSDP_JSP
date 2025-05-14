package com.klef.jfsd.springboot.service;

import java.util.List;
import java.util.Map;

import com.klef.jfsd.springboot.model.Customer;
import com.klef.jfsd.springboot.model.CustomerOrder;
import com.klef.jfsd.springboot.model.Product;

public interface ProductService 
{
   public String AddProduct(Product product);
   public List<Product> ViewAllProducts();
   public Product ViewProductByID(int productid);
   public List<Product> viewallproductsbycategory(String category);
   
   public CustomerOrder createOrder(CustomerOrder order) throws Exception;
   public Long ProductCount();
   public void updatePaymentStatus(String razorpayOrderId, String status);
   public List<CustomerOrder> viewOrders(int customerid);
   public String updateCustomer(Customer customer);
   public Customer viewCustomerById(int id);
}
