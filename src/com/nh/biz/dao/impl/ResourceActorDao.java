package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.ResourceActor;
import com.nh.core.orm.ibatis.GenericSqlMapDao;
@Repository("resourceActorDao")
public class ResourceActorDao extends GenericSqlMapDao<ResourceActor,Integer> {
}
