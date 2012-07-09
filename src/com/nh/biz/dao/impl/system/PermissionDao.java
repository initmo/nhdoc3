package com.nh.biz.dao.impl.system;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.system.Permission;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository
public class PermissionDao extends GenericSqlMapDao<Permission,String> {

}
