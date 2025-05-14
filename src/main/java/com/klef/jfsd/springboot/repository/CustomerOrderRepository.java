package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.CustomerOrder;
import java.util.List;


@Repository
public interface CustomerOrderRepository extends JpaRepository<CustomerOrder, Integer>
{

	public CustomerOrder findByRazorpayOrderId(String razorpayOrderId);
	public List<CustomerOrder> findByCustomerId(int customerId);
}
