package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceTree;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("resourceTreeDao")
public class ResourceTreeDao extends GenericSqlMapDao<ResourceTree,Integer> {

}
