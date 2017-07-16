package com.disappear.order.vo;

public class Order {
	
	private String orderseq;
	private String ordermid;
	private String menuseq;
	private int amount;
	private String time;
	private String phonenumber;
	private String requirements;
	private int price;
	private String orderdate;
	private String statement;
	
	private String commentsstate;
	public String getCommentsstate() {
		return commentsstate;
	}
	public void setCommentsstate(String commentsstate) {
		this.commentsstate = commentsstate;
	}
	
	
	public String getStatement() {
		return statement;
	}
	public void setStatement(String statement) {
		this.statement = statement;
	}
	public String getOrderseq() {
		return orderseq;
	}
	public void setOrderseq(String orderseq) {
		this.orderseq = orderseq;
	}
	public String getOrdermid() {
		return ordermid;
	}
	public void setOrdermid(String ordermid) {
		this.ordermid = ordermid;
	}
	public String getMenuseq() {
		return menuseq;
	}
	public void setMenuseq(String menuseq) {
		this.menuseq = menuseq;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getRequirements() {
		return requirements;
	}
	public void setRequirements(String requirements) {
		this.requirements = requirements;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	
}
