package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Customer;
import java.util.List;


@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer>
{
	public Customer findByEmailAndPassword(String email, String password);
}
