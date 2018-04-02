package com.cpi.entity;

import java.util.Date;

public class SuppliesStocks {
	
	private Integer idStock;
	private Integer idSupply;
	private Integer	qty;
	private Integer	prevQty;
	private Date	dateAdded;
	private	Date	datePurchased;
	private	Date	dateUpdate;
	private	String	numReference;
	private String	user;
	private String	itemName;
	private String 	obsoleteTag;
	
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public Integer getIdStock() {
		return idStock;
	}
	public void setIdStock(Integer idStock) {
		this.idStock = idStock;
	}
	public Integer getIdSupply() {
		return idSupply;
	}
	public void setIdSupply(Integer idSupply) {
		this.idSupply = idSupply;
	}
	public Date getDateAdded() {
		return dateAdded;
	}
	public void setDateAdded(Date dateAdded) {
		this.dateAdded = dateAdded;
	}
	public Date getDatePurchased() {
		return datePurchased;
	}
	public void setDatePurchased(Date datePurchased) {
		this.datePurchased = datePurchased;
	}
	public String getNumReference() {
		return numReference;
	}
	public void setNumReference(String numReference) {
		this.numReference = numReference;
	}
	public Integer getQty() {
		return qty;
	}
	public void setQty(Integer qty) {
		this.qty = qty;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public Date getDateUpdate() {
		return dateUpdate;
	}
	public void setDateUpdate(Date dateUpdate) {
		this.dateUpdate = dateUpdate;
	}
	public String getObsoleteTag() {
		return obsoleteTag;
	}
	public void setObsoleteTag(String obsoleteTag) {
		this.obsoleteTag = obsoleteTag;
	}
	public Integer getPrevQty() {
		return prevQty;
	}
	public void setPrevQty(Integer prevQty) {
		this.prevQty = prevQty;
	}
}
