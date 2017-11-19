package com.java.po;

import java.util.Date;

/**
 * Power entity. @author fjj1213
 */

public class Power implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private Money price;
	private Integer count;
	private Date time;
	private String status;
	private Integer beforecount;

	// Constructors

	/** default constructor */
	public Power() {
	}
 
 
	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
 
	public Integer getCount() {
		return this.count;
	}
	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public Money getPrice() {
		return price;
	}


	public void setPrice(Money price) {
		this.price = price;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
 
	public Integer getBeforecount() {
		return this.beforecount;
	}

	public void setBeforecount(Integer beforecount) {
		this.beforecount = beforecount;
	}

}