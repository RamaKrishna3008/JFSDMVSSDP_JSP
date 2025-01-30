	package com.klef.jfsd.springboot.controller;

import java.net.http.HttpRequest;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Customer;
import com.klef.jfsd.springboot.model.CustomerOrder;
import com.klef.jfsd.springboot.model.Employee;
import com.klef.jfsd.springboot.model.Product;
import com.klef.jfsd.springboot.service.AdminService;
import com.klef.jfsd.springboot.service.EmployeeService;
import com.klef.jfsd.springboot.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController 
{
  @Autowired
  private AdminService adminService;
  
  @Autowired
	private EmployeeService employeeService;
  
  @Autowired
	private ProductService productService;
  
  
  	@GetMapping("Login")
     public ModelAndView adminlogin()
     {
       ModelAndView mv = new ModelAndView();
       mv.setViewName("Login");
       return mv;
     }
  
     @GetMapping("viewallemps")
     public ModelAndView viewallemps()
     {
       ModelAndView mv = new ModelAndView();
       List<Employee> emplist = adminService.ViewAllEmployees();
       mv.setViewName("viewallemps");
       mv.addObject("emplist",emplist);
       
       long count=adminService.empcount();
       mv.addObject("count",count);
       
       return mv;
     }
     
     @GetMapping("viewallcustomers")
     public ModelAndView viewallcustomers()
     {
       ModelAndView mv = new ModelAndView();
       List<Customer> clist = adminService.ViewAllCustomers();
       mv.setViewName("viewallcustomers");
       mv.addObject("clist",clist);
       
       long count=adminService.customercount();
       mv.addObject("count",count);
       
       return mv;
     }
     
     @GetMapping("viewallOrders")
     public ModelAndView viewallOrders()
     {
       ModelAndView mv = new ModelAndView();
       List<CustomerOrder> clist = adminService.ViewAllOrders();
       mv.setViewName("viewallOrders");
       mv.addObject("clist",clist);
       
       long count=adminService.ordercount();
       mv.addObject("count",count);
       
       return mv;
     }
     
     @GetMapping("viewallProducts")
     public ModelAndView viewallProducts()
     {
       ModelAndView mv = new ModelAndView();
       List<Product> clist = productService.ViewAllProducts();
       mv.setViewName("viewallProductsAdmin");
       mv.addObject("productlist",clist);
       
       long count=productService.ProductCount();
       mv.addObject("count",count);
       
       return mv;
     }
     
     
     @GetMapping("deleteemp")
     public ModelAndView deleteemp()
     {
       ModelAndView mv = new ModelAndView();
       List<Employee> emplist = adminService.ViewAllEmployees();
       mv.setViewName("deleteemp");
       mv.addObject("emplist",emplist);
       return mv;
     }
     
     
     
     @GetMapping("delete")
     public String deleteoperation(@RequestParam("id") int eid)
     {
    	 adminService.deleteemp(eid);
    	 
    	 return "redirect:/deleteemp"; // redirection to specific path
     }
     
     @GetMapping("updateempstatus")
     public ModelAndView updateempstatus()
     {
       ModelAndView mv = new ModelAndView();
       List<Employee> emplist = adminService.ViewAllEmployees();
       mv.setViewName("updateempstatus");
       mv.addObject("emplist",emplist);
       return mv;
     }
     
     @GetMapping("updatestatus")
     public String updatestatus(@RequestParam("id") int eid,@RequestParam("status") String status)
     {
      adminService.updateempstatus(status, eid);
      return "redirect:/updateempstatus";
       
     }
     
     @PostMapping("checklogin")
     public ModelAndView checkadminlogin(HttpServletRequest request)
     {
    	 String email = request.getParameter("email");
    	 String pwd = request.getParameter("pwd");
    	 
    	 Admin admin = adminService.checkadminlogin(email, pwd);
    	 Customer customer = adminService.checkCustomerLogin(email, pwd);
    	 Employee emp = employeeService.checkemplogin(email, pwd);
    	 
    	 ModelAndView mv=new ModelAndView();
    	 
    	 if(admin !=null)
    	 {
    		 mv.setViewName("redirect:/adminhome");
    		 
    		 HttpSession session =request.getSession();
    		 session.setAttribute("admin", admin);
    	 }
    	 
    	 else if(emp!=null&& emp.getStatus().equals("Accepted"))
    	 {
    		 //session 
    		 HttpSession session = request.getSession();
    		 session.setAttribute("employee",emp); // employee is session variable
    		 //session.setMaxInactiveInterval(5);    		 
    		 mv.setViewName("redirect:/emphome");
    	 }
    	 else if(emp!=null)
		 {
			mv.setViewName("Login");
		 	mv.addObject("message","Your Request is "+emp.getStatus()+" Please Email 2200030798msbsrk@gmail.com  ");
		 }    	 
    	 else if(customer !=null)
    	 {
    		 HttpSession session =request.getSession();
    		 session.setAttribute("customer", customer);
    		 mv.setViewName("redirect:/customerhome");    
    	 }
    	 else
    	 {
    		//return "Admin Login Fail";
    		 mv.setViewName("Login");
    		 mv.addObject("message", "Login Failed");
    	 }
    	 
    	 return mv;
     }
     
     
     @GetMapping("adminhome")
     public ModelAndView adminhome()
     {
       ModelAndView mv = new ModelAndView();
       mv.setViewName("adminhome");
       
       long count=adminService.empcount();
       mv.addObject("count",count);
       
       return mv;
     }
     
     
     @GetMapping("Logout")
     public ModelAndView Logout(HttpServletRequest request)
     {
       ModelAndView mv = new ModelAndView();
       HttpSession session =request.getSession();
       session.invalidate();
       
       mv.setViewName("Login");
       return mv;
     }
     
     @GetMapping("addcustomer")
     public String addcustomer(Model m)
     {
       m.addAttribute("customer", new Customer());
       return "addcustomer"; //addcustomer.jsp
     }

  @PostMapping("verifyotp")
  public ModelAndView verifyotp(@ModelAttribute("customer") Customer customer, HttpSession session) {
      ModelAndView mv = new ModelAndView();
      session.setAttribute("customer", customer);  // Store customer in session
      int otp = employeeService.sendOtp(customer.getEmail());
      mv.addObject("otp", otp);
      System.out.println("Generated OTP: " + otp);
      mv.setViewName("verifyotp");
      return mv;
  }

  @PostMapping("insertcustomer")
  public ModelAndView insertcustomer(HttpSession session) {
      ModelAndView mv = new ModelAndView();
      Customer customer = (Customer) session.getAttribute("customer");  
      
      if (customer != null) {
          String msg = adminService.AddCustomer(customer);
          mv.addObject("message", msg);
          mv.setViewName("customersuccess");
          session.removeAttribute("customer");  
          } else {
          mv.addObject("message", "Customer details not found.");
          mv.setViewName("error");
      }
      return mv;
  }

     
     
     
    
}