package com.nh.biz.dao.impl;

import org.springframework.stereotype.Repository;

import com.nh.biz.domain.MyActNotice;
import com.nh.core.orm.ibatis.GenericSqlMapDao;

@Repository("myActNoticeDao")
public class MyActNoticeDao extends GenericSqlMapDao<MyActNotice,Integer> {

}
