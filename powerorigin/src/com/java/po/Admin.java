package com.java.po;

/**
 * Admin entity. @author fjj1213
 */

public class Admin implements java.io.Serializable {

	// Fields

	private Integer id;
	private String username;
	private String password;
	private String loginname;

	// Constructors

	/** default constructor */
	public Admin() {
	}

	/** full constructor */
	public Admin(String username, String password, String loginname) {
		this.username = username;
		this.password = password;
		this.loginname = loginname;
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

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLoginname() {
		return this.loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

}