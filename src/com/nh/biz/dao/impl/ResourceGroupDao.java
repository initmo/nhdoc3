package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceGroup;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("resourceGroupDao")
public class ResourceGroupDao extends GenericSqlMapDao<ResourceGroup,Integer>{

}
