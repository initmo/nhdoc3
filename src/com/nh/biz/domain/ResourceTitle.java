package com.nh.biz.domain;

public class ResourceTitle {
	private Integer id;
	private String titleName;
	private Integer treeId;
	private Boolean isApproval;
	private Boolean isEnable;
	private String noticeCycle;
	private String actDay;
	private Integer resourceCount;
	
	public Integer getResourceCount() {
		return resourceCount;
	}
	public void setResourceCount(Integer resourceCount) {
		this.resourceCount = resourceCount;
	}
	public String getActDay() {
		return actDay;
	}
	public void setActDay(String actDay) {
		this.actDay = actDay;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getTitleName() {
		return titleName;
	}
	public void setTitleName(String titleName) {
		this.titleName = titleName;
	}
	public Integer getTreeId() {
		return treeId;
	}
	public void setTreeId(Integer treeId) {
		this.treeId = treeId;
	}
	public Boolean getIsApproval() {
		return isApproval;
	}
	public void setIsApproval(Boolean isApproval) {
		this.isApproval = isApproval;
	}
	public Boolean getIsEnable() {
		return isEnable;
	}
	public void setIsEnable(Boolean isEnable) {
		this.isEnable = isEnable;
	}
	public String getNoticeCycle() {
		return noticeCycle;
	}
	public void setNoticeCycle(String noticeCycle) {
		this.noticeCycle = noticeCycle;
	}
	
	
	/**
	 * 逻辑相等的两个对象必须有相同的哈希码，保证在集合类的数据结构中有相同的hash索引。
	 */
	@Override
	public int hashCode() {
		final int PRIME = 31;
		int result = 1;
		result = PRIME * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	
	/**
	 * 比较ResourceTilte
	 * 只要满足id相等即认为两个ResourceTilte相等。
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final ResourceTitle other = (ResourceTitle) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
	public String toString() {
		return new StringBuilder()
			.append("{")
			.append("id:"+getId()).append(",")	
			.append("titleName:"+getTitleName()).append(",")	
			.append("treeId:"+getTreeId()).append(",")	
			.append("isEnable:"+getIsEnable()).append(",")	
			.append("noticeCycle:"+getNoticeCycle()).append(",")	
			.append("actDay:"+getActDay()).append(",")	
			.append("isApproval:"+getIsApproval()).append(",")	
			.append("resourceCounts:"+getResourceCount())
			.append("}")
			.toString();
	}

}
