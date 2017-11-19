package com.java.po;

import java.util.Date;

/**
 * Water entity. @author fjj1213
 */

public class Water implements java.io.Serializable {

	// Fields

	private Integer id;
	private User user;
	private Money price;
	private Date time;
	private Integer count;
	private String status;
	private Integer beforecount;

	// Constructors

	/** default constructor */
	public Water() {
	}
 

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}


	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Integer getCount() {
		return this.count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
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


	public Integer getBeforecount() {
		return this.beforecount;
	}

	public void setBeforecount(Integer beforecount) {
		this.beforecount = beforecount;
	}

}