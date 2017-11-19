package com.java.po;

/**
 * User entity. @author fjj1213
 */

public class User implements java.io.Serializable {

	// Fields

	private Integer id;
	private String username;
	private String loginname;
	private String password;
	private String address;
	private String phone;

	// Constructors

	/** default constructor */
	public User() {
	}

	/** full constructor */
	public User(String username, String loginname, String password,
			String address, String phone) {
		this.username = username;
		this.loginname = loginname;
		this.password = password;
		this.address = address;
		this.phone = phone;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getLoginname() {
		return this.loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

}