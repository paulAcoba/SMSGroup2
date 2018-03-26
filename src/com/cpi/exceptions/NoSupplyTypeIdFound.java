package com.cpi.exceptions;

public class NoSupplyTypeIdFound extends Exception{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("unused")
	private int supplyTypeId;
	public NoSupplyTypeIdFound(int supplyTypeId) {
		super();
		this.supplyTypeId = supplyTypeId;
	}
	
	
}
