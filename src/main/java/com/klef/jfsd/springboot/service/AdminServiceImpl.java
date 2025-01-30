package com.klef.jfsd.springboot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klef.jfsd.springboot.model.Admin;
import com.klef.jfsd.springboot.model.Customer;
import com.klef.jfsd.springboot.model.CustomerOrder;
import com.klef.jfsd.springboot.model.Employee;
import com.klef.jfsd.springboot.repository.AdminRepository;
import com.klef.jfsd.springboot.repository.CustomerOrderRepository;
import com.klef.jfsd.springboot.repository.CustomerRepository;
import com.klef.jfsd.springboot.repository.EmployeeRepository;

@Service
public class AdminServiceImpl implements AdminService
{
	@Autowired
	private EmployeeRepository employeeRepository;
	
	@Autowired
	private AdminRepository adminRepository;
	
	@Autowired
	private CustomerRepository customerRepository;
	
	@Autowired
	private CustomerOrderRepository orderRepository;
	
	
	@Override
	public List<Employee> ViewAllEmployees()
	{
		return employeeRepository.findAll();
	}
	
	
	@Override
	public List<Customer> ViewAllCustomers()
	{
		return customerRepository.findAll();
	}
	
	@Override
	public List<CustomerOrder> ViewAllOrders()
	{
		return orderRepository.findAll();
	}
	
	@Override
	public long ordercount() 
	{
		return orderRepository.count();
	}
	@Override
	public long customercount() 
	{
		return customerRepository.count();
	}
	
	@Override
	public Admin checkadminlogin(String uname, String pwd)
	{
			return adminRepository.checkadminlogin(uname, pwd);
	}

	@Override
	public String deleteemp(int eid) 
	{
		employeeRepository.deleteById(eid);
		return "Employee Deleted Successfully";
	}

	@Override
	public Employee displayempbyId(int eid) 
	{
		return employeeRepository.findById(eid).get();
	}

	@Override
	public long empcount() 
	{
		return employeeRepository.count();
	}

	@Override
	public String updateempstatus(String status, int eid) 
	{
		int n = employeeRepository.updateempstatus(status, eid);
		if(n>0)
			return "Employee Status Updated Successfully";
		else
			return "Employee Id Not Found";
	}

	@Override
	public String AddCustomer(Customer c) 
	{
		customerRepository.save(c);
		return "Customer Added Successfully";
	}
	
	@Override
	public Customer checkCustomerLogin(String email, String pwd) 
	{
		return customerRepository.findByEmailAndPassword(email, pwd);
	}

}
