package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.GroupDept;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("groupDeptDao")
public class GroupDeptDao extends GenericSqlMapDao<GroupDept,Integer> {

}
