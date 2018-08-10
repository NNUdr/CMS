package com.usts.entity;


//账单报表实体
public class AccountStatement {
	private String name;// 客户名称
	private double totalCost;  //消费总金额
	
	public AccountStatement() {}
	public AccountStatement(String name,double totalCost) {
		this.name = name;
		this.totalCost = totalCost;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public double getTotalCost() {
		return totalCost;
	}
	public void setTotalCost(double totalCost) {
		this.totalCost = totalCost;
	}
	
}
