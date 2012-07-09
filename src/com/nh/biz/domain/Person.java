package com.nh.biz.domain;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

public class Person implements Serializable {

	private static final long serialVersionUID = -8333984959652704635L;

	private String id;

	@NotNull
	@Size(min=1, max=5)
	private String firstName;

	@NotEmpty(message="lastName不能为空��!")
	private String lastName;

	@NotNull(message="money不能为空��!")
	private Double money;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Double getMoney() {
		return money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

}
