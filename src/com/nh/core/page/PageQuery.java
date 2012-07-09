package com.nh.core.page;

public class PageQuery {

	private Integer pageSize = 20;
	private Integer pageNo = 1;
	
	public Integer getPageNo() {
		return pageNo;
	}
	public void setPageNo(Integer pageNo) {
		if(null == pageNo || pageNo <= 0)
			pageNo = 1;
		this.pageNo = pageNo;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		if(null == pageSize || pageSize <= 0)
			pageSize = 15;
		this.pageSize = pageSize;
	}
	
}
