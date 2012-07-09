package com.nh.biz.dao.impl.system;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.system.Department;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("departmentDao")
public class DepartmentDao extends GenericSqlMapDao<Department,Integer> {
}
