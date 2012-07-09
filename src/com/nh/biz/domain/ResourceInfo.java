package com.nh.biz.domain;


import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

/**
 * 
 * @author initmo
 * @date 2012-03-05
 */
public class ResourceInfo implements Serializable {
	private static final long serialVersionUID = 1L;


	/**
	 * 文件标识
	 */
	private java.lang.Integer id;

	/**
	 * 考核项目Id
	 */
	private java.lang.Integer titleid;

	/**
	 * 上级编号
	 */
	private java.lang.Integer pid;

	/**
	 * 文件名称
	 */
	private java.lang.String filename;

	/**
	 * 文件别名
	 */
	@NotEmpty(message="文件名不能为空！")
	private java.lang.String filealiasname;

	/**
	 * 是否目录
	 */
	private java.lang.Boolean isdir;

	/**
	 * 文件类型
	 */
	private java.lang.String filetype;

	/**
	 * 文件路径
	 */
	private java.lang.String filedir;

	/**
	 * filerealname
	 */
	private java.lang.String filerealname;

	/**
	 * 文件大小
	 */
	private Long filesize;

	/**
	 * 修改时间
	 */
	private Date modifiedtime;

	/**
	 * 创建人/修改人
	 */
	private java.lang.String creator;
	
	private java.lang.String creatorid;

	/**
	 * departmentid
	 */
	private java.lang.Integer departmentid;

	/**
	 * department
	 */
	private java.lang.String department;

	/**
	 * 审核状态
	 */
	private java.lang.Integer approvalstatus;

	/**
	 * 备注
	 */
	private java.lang.String remark;

	/**
	 * 获取 文件标识 的属性值
	 * @return id : 文件标识
	 * @author tangkf
	 */
	public java.lang.Integer getId(){
		return this.id;
	}

	/**
	 * 设置 文件标识 的属性值
	 * @param id : 文件标识
	 * @author tangkf
	 */
	public void setId(java.lang.Integer id){
		this.id	= id;
	}

	/**
	 * 获取 考核项目Id 的属性值
	 * @return titleid : 考核项目Id
	 * @author tangkf
	 */
	public java.lang.Integer getTitleid(){
		return this.titleid;
	}

	/**
	 * 设置 考核项目Id 的属性值
	 * @param titleid : 考核项目Id
	 * @author tangkf
	 */
	public void setTitleid(java.lang.Integer titleid){
		this.titleid	= titleid;
	}

	/**
	 * 获取 上级编号 的属性值
	 * @return pid : 上级编号
	 * @author tangkf
	 */
	public java.lang.Integer getPid(){
		return this.pid;
	}

	/**
	 * 设置 上级编号 的属性值
	 * @param pid : 上级编号
	 * @author tangkf
	 */
	public void setPid(java.lang.Integer pid){
		this.pid	= pid;
	}

	/**
	 * 获取 文件名称 的属性值
	 * @return filename : 文件名称
	 * @author tangkf
	 */
	public java.lang.String getFilename(){
		return this.filename;
	}

	/**
	 * 设置 文件名称 的属性值
	 * @param filename : 文件名称
	 * @author tangkf
	 */
	public void setFilename(java.lang.String filename){
		this.filename	= filename;
	}

	/**
	 * 获取 文件别名 的属性值
	 * @return filealiasname : 文件别名
	 * @author tangkf
	 */
	public java.lang.String getFilealiasname(){
		return this.filealiasname;
	}

	/**
	 * 设置 文件别名 的属性值
	 * @param filealiasname : 文件别名
	 * @author tangkf
	 */
	public void setFilealiasname(java.lang.String filealiasname){
		this.filealiasname	= filealiasname;
	}

	/**
	 * 获取 是否目录 的属性值
	 * @return isdir : 是否目录
	 * @author tangkf
	 */
	public boolean getIsdir(){
		return this.isdir;
	}

	/**
	 * 设置 是否目录 的属性值
	 * @param isdir : 是否目录
	 * @author tangkf
	 */
	public void setIsdir(java.lang.Boolean isdir){
		this.isdir	= isdir;
	}

	/**
	 * 获取 文件类型 的属性值
	 * @return filetype : 文件类型
	 * @author tangkf
	 */
	public java.lang.String getFiletype(){
		return this.filetype;
	}

	/**
	 * 设置 文件类型 的属性值
	 * @param filetype : 文件类型
	 * @author tangkf
	 */
	public void setFiletype(java.lang.String filetype){
		this.filetype	= filetype;
	}

	/**
	 * 获取 文件路径 的属性值
	 * @return filedir : 文件路径
	 * @author tangkf
	 */
	public java.lang.String getFiledir(){
		return this.filedir;
	}

	/**
	 * 设置 文件路径 的属性值
	 * @param filedir : 文件路径
	 * @author tangkf
	 */
	public void setFiledir(java.lang.String filedir){
		this.filedir	= filedir;
	}

	/**
	 * 获取 filerealname 的属性值
	 * @return filerealname : filerealname
	 * @author tangkf
	 */
	public java.lang.String getFilerealname(){
		return this.filerealname;
	}

	/**
	 * 设置 filerealname 的属性值
	 * @param filerealname : filerealname
	 * @author tangkf
	 */
	public void setFilerealname(java.lang.String filerealname){
		this.filerealname	= filerealname;
	}

	/**
	 * 获取 文件大小 的属性值
	 * @return filesize : 文件大小
	 * @author tangkf
	 */
	public java.lang.Long getFilesize(){
		return this.filesize;
	}

	/**
	 * 设置 文件大小 的属性值
	 * @param filesize : 文件大小
	 * @author tangkf
	 */
	public void setFilesize(java.lang.Long filesize){
		this.filesize	= filesize;
	}

	/**
	 * 获取 修改时间 的属性值
	 * @return modifiedtime : 修改时间
	 * @author tangkf
	 */
	public Date getModifiedtime(){
		return this.modifiedtime;
	}

	/**
	 * 设置 修改时间 的属性值
	 * @param modifiedtime : 修改时间
	 * @author tangkf
	 */
	public void setModifiedtime(Date modifiedtime){
		this.modifiedtime	= modifiedtime;
	}

	/**
	 * 获取 创建人/修改人 的属性值
	 * @return creator : 创建人/修改人
	 * @author tangkf
	 */
	public java.lang.String getCreator(){
		return this.creator;
	}

	/**
	 * 设置 创建人/修改人 的属性值
	 * @param creator : 创建人/修改人
	 * @author tangkf
	 */
	public void setCreator(java.lang.String creator){
		this.creator	= creator;
	}

	/**
	 * 获取 departmentid 的属性值
	 * @return departmentid : departmentid
	 * @author tangkf
	 */
	public java.lang.Integer getDepartmentid(){
		return this.departmentid;
	}

	/**
	 * 设置 departmentid 的属性值
	 * @param departmentid : departmentid
	 * @author tangkf
	 */
	public void setDepartmentid(java.lang.Integer departmentid){
		this.departmentid	= departmentid;
	}

	/**
	 * 获取 department 的属性值
	 * @return department : department
	 * @author tangkf
	 */
	public java.lang.String getDepartment(){
		return this.department;
	}

	/**
	 * 设置 department 的属性值
	 * @param department : department
	 * @author tangkf
	 */
	public void setDepartment(java.lang.String department){
		this.department	= department;
	}

	/**
	 * 获取 审核状态 的属性值
	 * @return approvalstatus : 审核状态
	 * @author tangkf
	 */
	public java.lang.Integer getApprovalstatus(){
		return this.approvalstatus;
	}

	/**
	 * 设置 审核状态 的属性值
	 * @param approvalstatus : 审核状态
	 * @author tangkf
	 */
	public void setApprovalstatus(java.lang.Integer approvalstatus){
		this.approvalstatus	= approvalstatus;
	}

	/**
	 * 获取 备注 的属性值
	 * @return remark : 备注
	 * @author tangkf
	 */
	public java.lang.String getRemark(){
		return this.remark;
	}

	/**
	 * 设置 备注 的属性值
	 * @param remark : 备注
	 * @author tangkf
	 */
	public void setRemark(java.lang.String remark){
		this.remark	= remark;
	}

	/**
	 * 转换为字符串
	 * @author tangkf
	 */
	public String toString(){
		return "{" + "id(文件标识)=" + id + "," +"titleid(考核项目Id)=" + titleid + "," +"pid(上级编号)=" + pid + "," +"filename(文件名称)=" + filename + "," +"filealiasname(文件别名)=" + filealiasname + "," +"isdir(是否目录)=" + isdir + "," +"filetype(文件类型)=" + filetype + "," +"filedir(文件路径)=" + filedir + "," +"filerealname()=" + filerealname + "," +"filesize(文件大小)=" + filesize + "," +"modifiedtime(修改时间)=" + modifiedtime + "," +"creator(创建人/修改人)=" + creator + "," +"departmentid()=" + departmentid + "," +"department()=" + department + "," +"approvalstatus(审核状态)=" + approvalstatus + "," +"remark(备注)=" + remark + "}";
	}
	/**
	 * 转换为 JSON 字符串
	 * @author tangkf
	 */
	public String toJson(){
		return "{" + "id:'" + id + "'," +"titleid:'" + titleid + "'," +"pid:'" + pid + "'," +"filename:'" + filename + "'," +"filealiasname:'" + filealiasname + "'," +"isdir:'" + isdir + "'," +"filetype:'" + filetype + "'," +"filedir:'" + filedir + "'," +"filerealname:'" + filerealname + "'," +"filesize:'" + filesize + "'," +"modifiedtime:'" + modifiedtime + "'," +"creator:'" + creator + "'," +"departmentid:'" + departmentid + "'," +"department:'" + department + "'," +"approvalstatus:'" + approvalstatus + "'," +"remark:'" + remark + "'}";
	}
	/**
	 * 获取文件全路径
	 */
	public String getFullPath(){
		return getFiledir()+getFilerealname();
	}

	public java.lang.String getCreatorid() {
		return creatorid;
	}

	public void setCreatorid(java.lang.String creatorid) {
		this.creatorid = creatorid;
	}
}
	