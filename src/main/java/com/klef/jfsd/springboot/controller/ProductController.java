	package com.klef.jfsd.springboot.controller;

import java.sql.Blob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.CartItem;
import com.klef.jfsd.springboot.model.Customer;
import com.klef.jfsd.springboot.model.CustomerOrder;
import com.klef.jfsd.springboot.model.Product;
import com.klef.jfsd.springboot.service.ProductService;

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
	public ModelAndView PlaceOrder(HttpSession session) {
	    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
	    if (cart == null || cart.isEmpty()) {
	        return new ModelAndView("redirect:/cart");  // Redirect if cart is empty
	    }

	    double totalAmount = 0;
	    List<Map<String, Object>> productDetails = new ArrayList<>();

	    for (CartItem item : cart) {
	        totalAmount += item.getQuantity() * item.getCost();
	        Map<String, Object> product = new HashMap<>();
	        product.put("productId", item.getId());
	        product.put("quantity", item.getQuantity());
	        product.put("price", item.getCost());
	        productDetails.add(product);
	    }

	    ModelAndView mv = new ModelAndView("PlaceOrder");
	    mv.addObject("totalAmount", totalAmount);
	    mv.addObject("cartItems", productDetails); // Pass all cart items

	    return mv;
	}


	
	@PostMapping(value = "/create-order", produces = "application/json")
	public ResponseEntity<Map<String, Object>> createOrder(HttpSession session) throws Exception {
	    Customer customer = (Customer) session.getAttribute("customer");
	    if (customer == null) {
	        return new ResponseEntity<>(HttpStatus.UNAUTHORIZED);
	    }

	    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
	    if (cart == null || cart.isEmpty()) {
	        return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }

	    Map<String, Object> response = new HashMap<>();

	    for (CartItem item : cart) {
	        CustomerOrder order = new CustomerOrder();
	        order.setCustomerId(customer.getId());
	        order.setEmail(customer.getEmail());
	        order.setAmount(item.getQuantity() * item.getCost()); // Amount for that item
	        order.setProductid(item.getId()); // Store only product ID

	        CustomerOrder createdOrder = productService.createOrder(order);

	        // Prepare response for each order
	        response.put("id_" + createdOrder.getProductid(), createdOrder.getRazorpayOrderId());
	        response.put("amount_" + createdOrder.getProductid(), createdOrder.getAmount() * 100);
	    }

	    response.put("currency", "INR");
	    return new ResponseEntity<>(response, HttpStatus.CREATED);
	}



	 	
	 @PostMapping(value = "savePayment", consumes = "application/json", produces = "application/json")
	    public ResponseEntity<String> savePayment(@RequestBody Map<String, Object> paymentDetails, HttpSession session) {
	        System.out.println("Received Payment Data: " + paymentDetails); // Debugging Log

	        try {
	            // Validate required fields
	            if (!paymentDetails.containsKey("razorpay_payment_id") || !paymentDetails.containsKey("product_id")) {
	                return ResponseEntity.badRequest().body("Missing required parameters");
	            }

	            String razorpayOrderId = (String) paymentDetails.get("razorpay_order_id");
	            Object productIdObj = paymentDetails.get("product_id");

	            if (razorpayOrderId == null || razorpayOrderId.isEmpty()) {
	                return ResponseEntity.badRequest().body("Invalid data: Empty razorpay_order_id");
	            }

	            List<Integer> productIds = new ArrayList<>();

	            if (productIdObj instanceof List<?>) {
	                for (Object id : (List<?>) productIdObj) {
	                    try {
	                        productIds.add(Integer.parseInt(id.toString()));
	                    } catch (NumberFormatException e) {
	                        return ResponseEntity.badRequest().body("Invalid product ID format: " + id);
	                    }
	                }
	            } else {
	                try {
	                    productIds.add(Integer.parseInt(productIdObj.toString()));
	                } catch (NumberFormatException e) {
	                    return ResponseEntity.badRequest().body("Invalid product ID format");
	                }
	            }

	           

	            // Update payment status for each product
	            for (int productId : productIds) {
	                productService.updatePaymentStatus(razorpayOrderId, "paid");
	                System.out.println("Payment saved successfully for Product ID: " + productId);
	            }

	            // Clear cart after successful payment
	            session.removeAttribute("cart");

	            return ResponseEntity.ok("Payment saved successfully for product IDs: " + productIds);

	        } catch (Exception e) {
	            e.printStackTrace();
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body("An error occurred while processing payment.");
	        }
	    }


	    @GetMapping("/cart")
	    public String viewCart(HttpSession session, Model model) {
	        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
	        if (cart == null) {
	            cart = new ArrayList<>();
	            session.setAttribute("cart", cart);
	        }
	        model.addAttribute("cart", cart);
	        return "cart";  // cart.jsp
	    }
	    @GetMapping("/addToCart")
	    public String addToCart(@RequestParam("id") int id, HttpSession session) {
	        Product product = productService.ViewProductByID(id);
	        if (product == null) {
	            return "redirect:/";
	        }

	        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
	        if (cart == null) {
	            cart = new ArrayList<>();
	        }

	        boolean exists = false;
	        for (CartItem item : cart) {
	            if (item.getId() == id) {
	                item.setQuantity(item.getQuantity() + 1);
	                exists = true;
	                break;
	            }
	        }

	        if (!exists) {
	            cart.add(new CartItem(product.getId(), product.getName(), product.getCategory(), product.getCost(), 1));
	        }

	        session.setAttribute("cart", cart);
	        return "redirect:/cart";
	    }
	    @GetMapping("/removeFromCart")
	    public String removeFromCart(@RequestParam("id") int id, HttpSession session) {
	        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
	        if (cart != null) {
	            cart.removeIf(item -> item.getId() == id);
	            session.setAttribute("cart", cart);
	        }
	        return "redirect:/cart";
	    }
	    @GetMapping("/clearCart")
	    public String clearCart(HttpSession session) {
	        session.removeAttribute("cart");
	        return "redirect:/cart";
	    }
	    
	    @GetMapping("/viewOrders")
	     public ModelAndView viewallOrders(HttpServletRequest request)
	     {
	    	HttpSession session=request.getSession();
	    	Customer c=(Customer)session.getAttribute("customer");
	       ModelAndView mv = new ModelAndView();
	       List<CustomerOrder> clist = productService.viewOrders(c.getId());
	       mv.setViewName("viewOrders");
	       mv.addObject("clist",clist);
	       
	       long count=clist.size();
	       mv.addObject("count",count);
	       
	       return mv;
	     }
}
