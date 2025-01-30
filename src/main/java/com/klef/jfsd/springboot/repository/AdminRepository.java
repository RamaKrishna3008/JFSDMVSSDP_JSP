package com.klef.jfsd.springboot.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.klef.jfsd.springboot.model.Admin;

import jakarta.transaction.Transactional;

@Repository
public interface AdminRepository extends JpaRepository<Admin, String>
{
	@Query(" select a from Admin a where a.username=?1 and a.password=?2")
	public Admin checkadminlogin(String uname,String pwd);
	
	@Query("delete from Employee e where e.contact=?1")
	@Modifying
	@Transactional
	public int deleteempbydept(String contact);
	
}
