package com.cpi.exception;

public class InvalidCharacterException extends Exception{
	
	private static final long serialVersionUID = -6310021690394745838L;
	
	private String field;
	
	public InvalidCharacterException(String field) {
		this.field = field;
	}
	
	public String errorMessage() {
		return field;
	}
}
