package com.java.po;

import java.util.Date;

/**
 * Money entity. @author fjj1213
 */

public class Money implements java.io.Serializable {

	// Fields

	private Integer id;
	private double powerprice;
	private Date time;
	private double waterprice;
	private int isactive;

	// Constructors

	public int getIsactive() {
		return isactive;
	}

	public void setIsactive(int isactive) {
		this.isactive = isactive;
	}

	/** default constructor */
	public Money() {
	}

	/** minimal constructor */
	public Money(float powerprice) {
		this.powerprice = powerprice;
	}


	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public double getPowerprice() {
		return this.powerprice;
	}

	public void setPowerprice(double powerprice) {
		this.powerprice = powerprice;
	}

	public Date getTime() {
		return this.time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public double getWaterprice() {
		return this.waterprice;
	}

	public void setWaterprice(double waterprice) {
		this.waterprice = waterprice;
	}

}