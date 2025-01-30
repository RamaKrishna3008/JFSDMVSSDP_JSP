package com.klef.jfsd.springboot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Employee;
import com.klef.jfsd.springboot.service.EmployeeService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class EmployeeController
{
	@Autowired
	private EmployeeService employeeService;
	
	@GetMapping("/")
	public ModelAndView home()
	{
		ModelAndView mv = new ModelAndView("home");
		return mv;
	}
	
	@GetMapping("empreg")
	public ModelAndView empreg()
	{
		ModelAndView mv = new ModelAndView();
		mv.setViewName("empreg");
		return mv;
	}
	
	
	
	@PostMapping("insertemp")
	   public ModelAndView insertemp(HttpServletRequest request)
	   {
	    String name = request.getParameter("ename");
	    String gender = request.getParameter("egender");
	    String dob = request.getParameter("edob");
	    String dept = request.getParameter("edept");
	    double salary = Double.parseDouble(request.getParameter("esalary"));
	    String location = request.getParameter("elocation");
	    String email = request.getParameter("eemail");
	    String password = request.getParameter("epwd");
	    String contact = request.getParameter("econtact");
	    String status = "Registered";
	    
	      Employee emp = new Employee();
	      emp.setName(name);
	      emp.setGender(gender);
	      emp.setDepartment(dept);
	      emp.setDateofbirth(dob);
	      emp.setSalary(salary);
	      emp.setLocation(location);
	      emp.setEmail(email);
	      emp.setPassword(password);
	      emp.setContact(contact);
	      emp.setStatus(status);
	      
	      String msg = employeeService.EmployeeRegistration(emp);
	      
	      ModelAndView mv = new ModelAndView("regsuccess");
	      mv.addObject("message", msg);
	    
	      return mv;
	   }
	
		
		
		@GetMapping("emphome")
		public ModelAndView emphome()
		{
			ModelAndView mv = new ModelAndView();
			mv.setViewName("emphome");
			return mv;
		}
		

		@GetMapping("empprofile")
		public ModelAndView empprofile()
		{
			ModelAndView mv = new ModelAndView();
			mv.setViewName("empprofile");
			return mv;
		}
		

		@GetMapping("empcontactus")
		public ModelAndView empcontactus()
		{
			ModelAndView mv = new ModelAndView();
			mv.setViewName("empcontactus");
			return mv;
		}
		
		@PostMapping("sendemail")
		public ModelAndView sendemail(HttpServletRequest request)
		{
			ModelAndView mv = new ModelAndView();
			mv.setViewName("empcontactus");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String subject = request.getParameter("subject");
			String message = request.getParameter("message");
			
			String body = "My name is "+name+"\n"+message;
			
			employeeService.sendEmail(email, subject, body);
			
			mv.addObject("message","Mail Sent Successfully");
			return mv;
		}
		
		@GetMapping("updateemp")
		public ModelAndView updateemp()
		{
			ModelAndView mv = new ModelAndView();
			mv.setViewName("updateemp");
			return mv;
		}
		
		@PostMapping("updateempprofile")
		   public ModelAndView updateempprofile(HttpServletRequest request)
		   {
		     ModelAndView mv = new ModelAndView();
		     
		    try
		    {
		        int id = Integer.parseInt(request.getParameter("eid"));
		        String name = request.getParameter("ename");
		      String gender = request.getParameter("egender");
		      String dob = request.getParameter("edob");
		      String dept = request.getParameter("edept");
		      double salary = Double.parseDouble(request.getParameter("esalary"));
		      String password = request.getParameter("epwd");
		      String location = request.getParameter("elocation");
		      String contact = request.getParameter("econtact");
		      
		        Employee emp = new Employee();
		        emp.setId(id);
		        emp.setName(name);
		        emp.setGender(gender);
		        emp.setDepartment(dept);
		        emp.setDateofbirth(dob);
		        emp.setSalary(salary);
		        emp.setPassword(password);
		        emp.setLocation(location);
		        emp.setContact(contact);
		        
		        String msg = employeeService.UpdateEmployeeProfile(emp);
		        
		        Employee e = employeeService.displayEmployeeByID(id);
		        
		         HttpSession session = request.getSession();
		         session.setAttribute("employee",e); //employee is session variable
		       
		       
		        mv.setViewName("updatesuccess");
		        mv.addObject("message", msg);
		      
		    }
		    catch(Exception e)
		    {
		      mv.setViewName("updateerror");
		      mv.addObject("message", e);
		    }
		      return mv;
		   }
		
		@GetMapping("sessionexpiry")
		public ModelAndView empsessionexpiry()
		{
			ModelAndView mv = new ModelAndView();
			mv.setViewName("empsessionexpiry");
			return mv;
		}
		
		@GetMapping("viewempsbydept")
		public ModelAndView viewempsbydept(HttpServletRequest request)
		{
			ModelAndView mv = new ModelAndView();
			
			HttpSession session = request.getSession();
			
			Employee emp =(Employee)session.getAttribute("employee");// employee is session object
			if(emp!=null){
			mv.setViewName("viewempsbydept");
			List<Employee> emplist = employeeService.displayEmployeesByDepartment(emp.getDepartment());
			
			mv.addObject("emplist", emplist);
			}
			else
			{
				mv.setViewName("redirect:/sessionexpiry");
			}
			
			return mv;
		}
		
		
}
