package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceApproval;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("resourceApprovalDao")
public class ResourceApprovalDao extends GenericSqlMapDao<ResourceApproval,Integer> {
}
