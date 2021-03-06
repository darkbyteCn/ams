package com.ams.system.entity;

import java.io.Serializable;

/**
 * 用户信息实体
 * @author Shalnark
 *
 */
public class User implements Serializable{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2493902718516521134L;
	private String userId;    //用户编码
	private String userName;  //用户名称
	private String password;  //用户密码
	private String realName;  //用户真实姓名
	private String phone;     //用户电话
	private String enable;    //是否启用
	private String departId; //部门编号
	
	public String getDepartId() {
		return departId;
	}
	public void setDepartId(String departId) {
		this.departId = departId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEnable() {
		return enable;
	}
	public void setEnable(String enable) {
		this.enable = enable;
	}
	

;}
