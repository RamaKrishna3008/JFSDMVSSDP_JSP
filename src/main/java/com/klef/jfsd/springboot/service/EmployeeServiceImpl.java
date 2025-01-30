package com.klef.jfsd.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Employee;
import com.klef.jfsd.springboot.repository.EmployeeRepository;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmployeeServiceImpl implements EmployeeService
{
	@Autowired
	private EmployeeRepository employeeRepository;
	
	@Autowired
	private JavaMailSender mailSender;

	@Override
	public String EmployeeRegistration(Employee e) 
	{
		 employeeRepository.save(e);
		 return "Employee Registered Successfully";
	}

	@Override
	public Employee checkemplogin(String email, String pwd)
	{
		return employeeRepository.checkemplogin(email, pwd);
		
	}

	@Override
	public Employee displayEmployeeByID(int eid) 
	{
		return employeeRepository.findById(eid).get();
	}

	@Override
	public String UpdateEmployeeProfile(Employee emp) 
	{
		Employee e = employeeRepository.findById(emp.getId()).get();
	    
	    e.setContact(emp.getContact());
	    e.setDateofbirth(emp.getDateofbirth());
	    e.setDepartment(emp.getDepartment());
	    e.setGender(emp.getGender());
	    e.setLocation(emp.getLocation());
	    e.setName(emp.getName());
	    e.setPassword(emp.getPassword());
	    e.setSalary(emp.getSalary());
	    
	    employeeRepository.save(e);
	    
	    return "Employee Updated Successfully";
	}

	@Override
	public void sendEmail(String toEmail, String subject, String body) {
	    MimeMessage mimeMessage = mailSender.createMimeMessage();

	    try {
	        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
	        helper.setFrom("sivaramm683@gmail.com");
	        helper.setTo(toEmail);
	        helper.setSubject(subject);
	        helper.setText(body, true);

	        mailSender.send(mimeMessage);

	        System.out.println("HTML Email Sent Successfully...");
	    } catch (MessagingException e) {
	        e.printStackTrace();
	        System.out.println("Error Sending HTML Email...");
	    }
	}

	@Override
	public int sendOtp(String email) {
	    int rnd = 100000 + (int) (Math.random() * 900000);
	    String subject = "Your ShopEasy OTP for Account Verification";

	    String body = "<div style='font-family: Arial, sans-serif; color: #333; padding: 20px;'>"
	                + "<h2 style='color: #4CAF50;'>ShopEasy OTP Verification</h2>"
	                + "<p>Dear Customer,</p>"
	                + "<p>We received a request to verify your account on <b>ShopEasy</b>. "
	                + "Please use the One-Time Password (OTP) below to complete the process:</p>"
	                + "<div style='font-size: 24px; color: #4CAF50; font-weight: bold; margin: 20px 0;'>"
	                + "OTP: " + rnd + "</div>"
	                + "<p style='color: #555;'>This OTP is valid for the next <b>10 minutes</b>. "
	                + "If you did not request this, please ignore this email or contact our support team.</p>"
	                + "<hr style='border: none; border-top: 1px solid #ddd;'>"
	                + "<p style='font-size: 14px; color: #888;'>Thank you for choosing <b>ShopEasy</b>!</p>"
	                + "<p style='font-size: 14px; color: #888;'>Best regards,<br>The ShopEasy Team</p>"
	                + "</div>";

	    sendEmail(email, subject, body);
	    return rnd;
	}


	@Override
	public List<Employee> displayEmployeesByDepartment(String dept) 
	{
		return employeeRepository.findByDepartment(dept);
	}
	
	
}
