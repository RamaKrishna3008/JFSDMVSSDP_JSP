package com.klef.jfsd.springboot.service;

import java.util.List;

import com.klef.jfsd.springboot.model.Employee;

public interface EmployeeService 
{
	public String EmployeeRegistration(Employee e);
	public Employee checkemplogin(String email,String pwd);
	public Employee displayEmployeeByID(int eid);
	public String UpdateEmployeeProfile(Employee emp);
	public void sendEmail(String toEmail,String subject,String body);
	public int sendOtp(String Email);
	
	public List<Employee> displayEmployeesByDepartment(String dept);
	
}
