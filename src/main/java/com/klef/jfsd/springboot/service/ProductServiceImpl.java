package com.klef.jfsd.springboot.service;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.CustomerOrder;
import com.klef.jfsd.springboot.model.Product;
import com.klef.jfsd.springboot.repository.CustomerOrderRepository;
import com.klef.jfsd.springboot.repository.ProductRepository;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.annotation.PostConstruct;

@Service
public class ProductServiceImpl implements ProductService
{
	@Autowired
	private ProductRepository productRepository;
	
	@Autowired
	private CustomerOrderRepository orderRepository;
	
	@Value("${razorpay.key.id}")
	private String razorPayKey;
	
	@Value("${razorpay.secret.key}")
	private String razorPaySecret;
	
	private RazorpayClient client;
	
	@Override
	public String AddProduct(Product product) 
	{
		productRepository.save(product);
		return "Product Added Successfully";
	}

	@Override
	public List<Product> ViewAllProducts() 
	{
		return (List<Product>) productRepository.findAll();
	}

	@Override
	public Product ViewProductByID(int productid) 
	{
		return productRepository.findById(productid).get();
	}
	
	@Override
	public Long ProductCount() 
	{
		return productRepository.count();
	}

	@Override
	public List<Product> viewallproductsbycategory(String category) 
	{
		return productRepository.viewallproductsbycategory(category);
	}

	@PostConstruct
    public void initializeRazorpayClient() {
        try {
            this.client = new RazorpayClient(razorPayKey, razorPaySecret);
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize RazorpayClient", e);
        }
    }

    @Override
    public CustomerOrder createOrder(CustomerOrder order) throws Exception {
        JSONObject orderReq = new JSONObject();
        orderReq.put("amount", order.getAmount() * 100); 
        orderReq.put("currency", "INR");
        orderReq.put("receipt", "order_rcptid_" + order.getEmail());

        Order razorpayOrder = client.orders.create(orderReq);

        order.setRazorpayOrderId(razorpayOrder.get("id"));
        order.setOrderStatus(razorpayOrder.get("status"));
        orderRepository.save(order);

        return order;
    }

    @Override
    public boolean verifySignature(Map<String, String> paymentDetails) {
        try {
            String razorpayOrderId = paymentDetails.get("razorpay_order_id");
            String razorpayPaymentId = paymentDetails.get("razorpay_payment_id");
            String razorpaySignature = paymentDetails.get("razorpay_signature");

            String data = razorpayOrderId + "|" + razorpayPaymentId;
            String generatedSignature = generateSignature(data, razorPaySecret);

            return generatedSignature.equals(razorpaySignature);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String generateSignature(String data, String secretKey) throws Exception {
        Mac mac = Mac.getInstance("HmacSHA256");
        SecretKeySpec secretKeySpec = new SecretKeySpec(secretKey.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
        mac.init(secretKeySpec);
        byte[] hmacSha256 = mac.doFinal(data.getBytes(StandardCharsets.UTF_8));

        StringBuilder hexString = new StringBuilder();
        for (byte b : hmacSha256) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    @Override
    public void updatePaymentStatus(String razorpayOrderId, String status) {
        CustomerOrder order = orderRepository.findByRazorpayOrderId(razorpayOrderId);
        if (order != null) {
            order.setOrderStatus(status);
            orderRepository.save(order);
        }
    }

}