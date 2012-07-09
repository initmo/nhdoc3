package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceChecker;
import com.nh.core.orm.ibatis.GenericSqlMapDao;
@Repository("resourceCheckerDao")
public class ResourceCheckerDao extends GenericSqlMapDao<ResourceChecker,Integer> {
}
