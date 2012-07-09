package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceTemplate;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("resourceTemplateDao")
public class ResourceTemplateDao extends GenericSqlMapDao<ResourceTemplate,Integer> {
}
