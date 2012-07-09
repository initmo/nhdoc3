package com.nh.biz.dao.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceTitle;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("ResourceTitleDao")
public class ResourceTitleDao extends GenericSqlMapDao<ResourceTitle,Integer> {
	
	public Map getResourceCounts(Integer treeId,Integer deptId){
		Map<String, Object> paramter = new HashMap<String, Object>();
		paramter.put("treeId", treeId);
		paramter.put("deptId", deptId);
		return sqlMapClientTemplate.queryForMap("ResourceTitle.getResourceCounts", paramter,"titleId","resourceCount");
	}
}

