	package com.klef.jfsd.springboot.controller;

import java.sql.Blob;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Customer;
import com.klef.jfsd.springboot.model.CustomerOrder;
import com.klef.jfsd.springboot.model.Product;
import com.klef.jfsd.springboot.service.ProductService;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController 
{
	@Autowired
	private ProductService productService;
	
	 @GetMapping("addproduct")
	   public ModelAndView addproductdemo()
	   {
		   ModelAndView mv = new ModelAndView("addproduct");
		   return mv;
	   }
	 @PostMapping("insertproduct")
	   public ModelAndView insertproductdemo(HttpServletRequest request,@RequestParam("productimage") MultipartFile file) throws Exception
	   {
		   String msg = null;
		   
		   ModelAndView mv = new ModelAndView();
		   
		   try
		   {
		   String category = request.getParameter("category");
		   String name = request.getParameter("name");
		   String description = request.getParameter("description");
		   Double cost = Double.valueOf(request.getParameter("cost"));
		   
			  byte[] bytes = file.getBytes();
			  Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
			  //  creates a Blob object in Java from a byte array (bytes).
			  
			  Product p = new Product();
			  p.setCategory(category);
			  p.setName(name);
			  p.setDescription(description);
			  p.setCost(cost);
			  p.setImage(blob);
			  
			  msg=productService.AddProduct(p);
			  System.out.println(msg);
			  mv.setViewName("addproduct");
			  mv.addObject("message",msg);
		   }	  
		   catch(Exception e)
		   {
			   msg = e.getMessage();
			   System.out.println(msg.toString());
			  
		   }
		   return mv;
	   }
	 
	 @GetMapping("customerhome")
	   public ModelAndView producthome()
	   {
		   List<Product> productlist = productService.ViewAllProducts();
		   
		   ModelAndView mv = new ModelAndView("customerhome");
		   
		   mv.addObject("productlist", productlist);
		   
		   return mv;
	   }
	   
	@GetMapping("displayprodimage")
	public ResponseEntity<byte[]> displayprodimagedemo(@RequestParam("id") int id) throws Exception
	{
	  Product product =  productService.ViewProductByID(id);
	  byte [] imageBytes = null;
	  imageBytes = product.getImage().getBytes(1,(int) product.getImage().length());

	  return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(imageBytes);
	  
	}
	
	@GetMapping("PlaceOrder")
	public ModelAndView PlaceOrder(@RequestParam String amount)
	{
		ModelAndView mv = new ModelAndView("PlaceOrder");
		mv.addObject("amount", amount);
		return mv;
	}
	
	 @PostMapping(value = "/create-order", produces = "application/json")
	    public ResponseEntity<Map<String, Object>> createOrder(@RequestBody CustomerOrder order, HttpSession session) throws Exception {
	        Customer customer = (Customer) session.getAttribute("customer");
	        if (customer == null) {
	            return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	        }

	        order.setCustomerId(customer.getId());
	        order.setEmail(customer.getEmail());

	        CustomerOrder createdOrder = productService.createOrder(order);

	        Map<String, Object> response = new HashMap<>();
	        response.put("id", createdOrder.getRazorpayOrderId());
	        response.put("amount", createdOrder.getAmount() * 100);
	        response.put("currency", "INR");

	        return new ResponseEntity<>(response, HttpStatus.CREATED);
	    }

	    @PostMapping(value = "savePayment", consumes = {"application/json", "application/x-www-form-urlencoded"})
	    public ResponseEntity<String> savePayment(@RequestBody(required = false) Map<String, String> paymentDetails,
	                                               @RequestParam Map<String, String> formParams) {
	        Map<String, String> details = (paymentDetails != null) ? paymentDetails : formParams;

	        boolean isVerified = productService.verifySignature(details);
	        if (!isVerified) {
	            return new ResponseEntity<>("Invalid payment signature", HttpStatus.BAD_REQUEST);
	        }

	        String razorpayOrderId = details.get("razorpay_order_id");
	        productService.updatePaymentStatus(razorpayOrderId, "paid");

	        return new ResponseEntity<>("Payment saved successfully", HttpStatus.OK);
	    }


}
