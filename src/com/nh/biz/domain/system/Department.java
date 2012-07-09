package com.nh.biz.domain.system;

import java.io.Serializable;

public class Department  implements Serializable{
	
	private static final long serialVersionUID = -6589358266187384296L;
	private Integer deptId;
	private String deptName;
	private Integer pid;
	private boolean hasChild;
	
	public Department(){
	}
	public Department(Integer deptId,String deptName){
		this.deptId = deptId;
		this.deptName = deptName;
	}
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public Integer getDeptId() {
		return deptId;
	}
	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public boolean isHasChild() {
		return hasChild;
	}
	public void setHasChild(boolean hasChild) {
		this.hasChild = hasChild;
	}
	public Integer getPid() {
		return pid;
	}
	public void setPid(Integer pid) {
		this.pid = pid;
	}
	
	@Override
	public int hashCode() {
		final int PRIME = 31;
		int result = 1;
		result = PRIME * result + ((deptId == null) ? 0 : deptId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		final Department other = (Department) obj;
		if (deptId == null) {
			if (other.deptId != null)
				return false;
		} else if (!deptId.equals(other.deptId))
			return false;
		return true;
	}
	

	
	
}
