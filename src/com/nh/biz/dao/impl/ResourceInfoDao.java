package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceInfo;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("resourceInfoDao")
public class ResourceInfoDao extends GenericSqlMapDao<ResourceInfo,Integer>{

}
