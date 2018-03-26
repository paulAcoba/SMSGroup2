package com.cpi.exception;

public class DuplicateEntryException extends Exception{

	private static final long serialVersionUID = -4804856460056398888L;
	private String field;
	private String value;
	
	public DuplicateEntryException(String field, String value){
		this.field = field;
		this.value = value;
	}
	
	public String getErrorField() {
		return field;
	}
	
	public String getErrorValue() {
		return value;
	}
}
