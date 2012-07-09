package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceUserTitle;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("ResourceUserTitleDao")
public class ResourceUserTitleDao extends GenericSqlMapDao<ResourceUserTitle,Integer> {
}

