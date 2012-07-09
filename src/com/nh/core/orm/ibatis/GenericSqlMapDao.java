package com.nh.core.orm.ibatis;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.orm.ibatis.SqlMapClientCallback;
import org.springframework.orm.ibatis.SqlMapClientTemplate;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import com.nh.core.page.Pagination;
import com.nh.core.utils.reflaection.ReflectionUtils;


/**
 * 通用Dao的iBATIS实现
 * eg.
 * public class UserDao extends GenericSqlMapDao<User, Long>{
 * }
 * 或者
 * public class UserDaoImpl extends GenericSqlMapDao<User, Long> implement UserDao{
 * }
 *
 * @param <T>  DAO操作的对象类型
 * @param <PK> 主键类型
 * 
 * @author initmo@gmail.com
 */
public abstract  class GenericSqlMapDao<T, PK extends Serializable> {
	protected final Logger logger = Logger.getLogger(getClass());  
	  
    public static final String POSTFIX_SELECTBYID = ".selectById";  
    public static final String POSTFIX_SELECTBYIDS = ".selectByIds";  
    public static final String POSTFIX_SELECTBYMAP = ".selectByMap";  
    public static final String POSTFIX_SELECTUNIQUEBYMAP = ".selectUniqueByMap";  
    public static final String POSTFIX_SELECTIDSLIKEBYMAP = ".selectIdsLikeByMap";  
    public static final String POSTFIX_PKSELECTMAP = ".pkSelectByMap";  
    public static final String POSTFIX_COUNT = ".count";  
    public static final String POSTFIX_COUNTLIKEBYMAP = ".countLikeByMap";  
    public static final String POSTFIX_INSERT = ".insert";  
   
    public static final String POSTFIX_DELETEBYID = ".deleteById";  
    public static final String POSTFIX_DELETEBYIDS = ".deleteByIds";  
    public static final String POSTFIX_DELETEBYIDSMAP = ".deleteByIdsMap";  
    public static final String POSTFIX_DELETEBYMAP = ".deleteByMap";  
    public static final String POSTFIX_UPDATE = ".update";  
    public static final String POSTFIX_UPDATEBYMAP = ".updateByMap";  
    public static final String POSTFIX_UPDATEBYIDSMAP = ".updateByIdsMap";  
    
    public static final String POSTFIX_BATCHINSERT = ".batchInsert";  
  
    protected Class<T> clazz;  
  
    //子类泛型参数类名
    protected String clazzName;  
  
    protected T t;  
    
    
    protected SqlMapClientTemplate sqlMapClientTemplate; 
    
    
    
    public SqlMapClientTemplate getSqlMapClientTemplate() {
		return sqlMapClientTemplate;
	}

    @Resource
	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}


	public GenericSqlMapDao() {  
        // 通过范型反射，取得在子类中定义的class.  
        clazz =  ReflectionUtils.getSuperClassGenricType(getClass()); 
        clazzName = clazz.getSimpleName();
    }  
    

    public Integer count(String propertyName, Object propertyValue) {  
        return count(new String[]{propertyName},new Object[]{propertyValue});  
    }  
    
    public Integer count(Map map) {  
         return (Integer) sqlMapClientTemplate.queryForObject(clazz.getSimpleName() + POSTFIX_COUNT, map);  
    } 
  
    public Integer count(String[] propertyNames, Object[] propertyValues) {  
  
            Map<String, Object> map = new HashMap<String, Object>();  
            for (int i = 0; i < propertyNames.length; i++) {  
                map.put(propertyNames[i], propertyValues[i]);  
            }  
            return (Integer) sqlMapClientTemplate.queryForObject(clazz.getSimpleName() + POSTFIX_COUNT, map);  
    }  
  
  
    public Integer countLikeByMap(String[] propertyNames, Object[] propertyValues) {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < propertyNames.length; i++) {  
            map.put(propertyNames[i], propertyValues[i]);  
        }  
        return (Integer) sqlMapClientTemplate.queryForObject(clazz.getSimpleName() + POSTFIX_COUNTLIKEBYMAP, map);  
    }  
  
    /** 根据自定义SqlMap中的条件语句查询出记录数量 */  
    public Integer countByStatementPostfix(String statementPostfix,String[] properties, Object[] 

propertyValues){  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        return (Integer) sqlMapClientTemplate.queryForObject(clazz.getName() + statementPostfix, map);  
    }  
    /** 
     * 通过id得到实体对象 
     */  
    @SuppressWarnings("unchecked")
	public T findById(PK id) {  
            return (T) sqlMapClientTemplate.queryForObject(clazz.getSimpleName() + POSTFIX_SELECTBYID, id);  
    }  
  
    /** 
     * 根据ids获取实体列表 
     *  
     * @param ids 
     * @return 
     */  
    @SuppressWarnings("unchecked")
	public List<T> findByIds(List<PK> ids) {  
            return (List<T>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_SELECTBYIDS, ids);  
    }  
    
  
    /** 
     * 根据ids获取实体列表 
     *  
     * @param ids 
     * @return 
     */  
    @SuppressWarnings("unchecked")
	public List<T> findAll() {
    	 Map<String, Object> map = new HashMap<String, Object>(); 
         return (List<T>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_SELECTBYMAP, map);  
    }
    
    /** 
     * 直接从数据库查询出ids列表（包括符合条件的所有id） 
     *  
     * @param properties 
     *            查询条件字段名 
     * @param propertyValues 
     *            字段取值 
     * @return 
     */  
    @SuppressWarnings("unchecked")
	public List<PK> findIdsBy(String[] properties, Object[] propertyValues, String orderBy, String order) {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        if (orderBy != null) {  
            map.put("orderBy", orderBy);  
            map.put("order", order);  
        }  
        return (List<PK>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_PKSELECTMAP, map);  
    }  
  
    /** 
     * 根据条件查询结果 
     *  
     * @param properties 
     *            查询条件名 
     * @param propertyValues 
     *            查询条件值 
     * @return 
     */  
    public List<T> findByMap(String[] properties, Object[] propertyValues, String orderBy, String order) {  
    	Map<String, Object> map = new HashMap<String, Object>();  
         for (int i = 0; i < properties.length; i++) {  
             map.put(properties[i], propertyValues[i]);  
         }    
         if (orderBy != null) {  
             map.put("orderBy", orderBy);  
             map.put("order", order);  
         } 
         return findByMap(map);  
    }  
    
    public List<T> findByMap(String[] properties, Object[] propertyValues) {  
    	return findByMap(properties,propertyValues,null,null);  
    }  
    
    @SuppressWarnings("unchecked")
	public List<T> findByMap(Map map) {   
    	return (List<T>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_SELECTBYMAP, map);  
    }  
  
  
    /** 
     * 根据条件查询结果 ,返回第一条结果
     *  
     * @param properties 
     *            查询条件名 
     * @param propertyValues 
     *            查询条件值 
     * @return 
     */  
    

	@SuppressWarnings("unchecked")
	public T findUniqueByMap(String[] properties, Object[] propertyValues) {  
    	Map<String, Object> map = new HashMap<String, Object>();  
         for (int i = 0; i < properties.length; i++) {  
             map.put(properties[i], propertyValues[i]);  
         }
         
    	return (T) sqlMapClientTemplate.queryForObject(clazz.getSimpleName() + POSTFIX_SELECTBYMAP, map);  
    }  
    
    /** 
     * 根据条件查询结果的id列表 
     *  
     * @param properties 
     *            查询条件名 
     * @param propertyValues 
     *            查询条件值 
     * @return 
     */  
    @SuppressWarnings("unchecked")
	public List<PK> findIdsByMap(String[] properties, Object[] propertyValues, String orderBy, String order) {  
            Map<String, Object> map = new HashMap<String, Object>();  
            for (int i = 0; i < properties.length; i++) {  
                map.put(properties[i], propertyValues[i]);  
            }  
            if (orderBy != null) {  
                map.put("orderBy", orderBy);  
                map.put("order", order);  
            }  
            return (List<PK>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_PKSELECTMAP, map);  
    }  
  
    /** 
     * 分页查询（未处理缓存） 
     *  
     * @param properties 
     *            查询条件字段名 
     * @param propertyValues 
     *            字段取值 
     * @return select top $end$ * from user where id not in (select top $start$ id from user order by id) u  order by id
     */  
    @SuppressWarnings("unchecked")
	public List<T> pageQueryBy(String[] properties, Object[] propertyValues, String orderBy, String order, int pageSize, int pageNo) {  
            Map<String, Object> map = new HashMap<String, Object>();  
            for (int i = 0; i < properties.length; i++) {  
                map.put(properties[i], propertyValues[i]);  
            }  
            if (orderBy != null) {  
                map.put("orderBy", orderBy);  
                map.put("order", order);  
            }  
            map.put("limit", true);  
            map.put("start", (pageNo - 1) * pageSize );// limit 操作  
            map.put("end", pageSize);  
            return (List<T>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_SELECTBYMAP, map);  
    }  
    
    /** 
     * 分页查询（逻辑分页） 
     *  
     * @param properties 
     *            查询条件字段名 
     * @param propertyValues 
     *            字段取值 
     */  
    public Pagination<T> lgcPageQueryBy(String[] properties, Object[] propertyValues,  String orderBy, String order, int pageSize, int pageNo) {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        if (orderBy != null) {  
            map.put("orderBy", orderBy);  
            map.put("order", order);  
        }  
        return  lgcPageQueryBy( map,   pageSize,  pageNo) ;
    }  
    
    @SuppressWarnings("unchecked")
	public Pagination<T> lgcPageQueryBy(Map map,  int pageSize, int pageNo) {  
      
        Integer count = count(map);
        Pagination<T> pagination = new Pagination<T>(pageNo,pageSize,count);
        List<T> list = sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_SELECTBYMAP, map, (pageNo - 1) * pageSize, pageSize);
        pagination.setList(list);
        return pagination ;
} 
  
    /** 
     * 从数据库分页查询出ids列表的前200个id 
     *  
     * @param properties 
     *            查询条件字段名 
     * @param propertyValues 
     *            字段取值 
     * @return 
     */  
    @SuppressWarnings("unchecked")
	protected List<PK> pageQueryIdsBy(String[] properties, Object[] propertyValues, String orderBy, String order) {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        if (orderBy != null) {  
            map.put("orderBy", orderBy);  
            map.put("order", order);  
        }  
        map.put("limit", true);  
        map.put("start", 0);//  操作  
        map.put("end", 200);  
        return (List<PK>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_PKSELECTMAP, map);  
  
    }  
  
    /** 
     * 分页查询出id列表（处理缓存） 
     *  
     * @param properties 
     *            查询条件字段名 
     * @param propertyValues 
     *            字段取值 
     * @return 
     */  
    @SuppressWarnings("unchecked")
	public List<PK> pageQueryIdsByMap(String[] properties, Object[] propertyValues, String orderBy, String 

order, int pageSize, int pageNo) {  
            Map<String, Object> map = new HashMap<String, Object>();  
            for (int i = 0; i < properties.length; i++) {  
                map.put(properties[i], propertyValues[i]);  
            }  
            if (orderBy != null) {  
                map.put("orderBy", orderBy);  
                map.put("order", order);  
            }  
            map.put("limit", true);  
            map.put("start", (pageNo - 1) * pageSize );// limit 操作  
            map.put("end", pageSize);  
            return (List<PK>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + POSTFIX_PKSELECTMAP, map);  
    }  
  
    /** like分页查询(不走列表缓存) */  
    @SuppressWarnings("unchecked")
	public List<T> pageLikeBy(String[] properties, Object[] propertyValues, String orderBy, String order, int 

pageSize, int pageNo){  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        if (orderBy != null) {  
            map.put("orderBy", orderBy);  
            map.put("order", order);  
        }  
        map.put("limit", true);  
        map.put("start", (pageNo - 1) * pageSize );// limit 操作  
        map.put("end", pageSize);  
        List<PK> ids = (List<PK>) sqlMapClientTemplate.queryForList(clazz.getName() + 

POSTFIX_SELECTIDSLIKEBYMAP, map);  
        return findByIds(ids);  
    }  
  
    /** 
     * 新增对象 
     */  
    public Serializable insert(T o) throws Exception {  
       /* if (t instanceof QueryCachable) {  
            // 清除受影响的缓存  
            clearListCache(o);  
        }  */
        return (Serializable) sqlMapClientTemplate.insert(clazz.getSimpleName() + POSTFIX_INSERT, o);  
    }  
    
    /** 
     * 批量新增对象 
     */  
    @SuppressWarnings("unchecked")
	public void batchInsert(final  List<T> list) throws Exception {  
    	sqlMapClientTemplate.execute(new SqlMapClientCallback(){ 
    	    public Object doInSqlMapClient(SqlMapExecutor executor) 
    	            throws SQLException { 
    	    executor.startBatch(); 
    	    int batch = 0; 
    	    for(T t:list){ 
    	 
    	    executor.insert(clazz.getSimpleName() + POSTFIX_INSERT, t); 
    	    batch++; 
    	    //每500条批量提交一次。 
    	    if(batch==500){ 
    	    executor.executeBatch(); 
    	    batch = 0; 
    	    } 
    	    } 
    	    executor.executeBatch(); 
    	    return null; 
    	    } 
    	    }); 
        //return (Serializable) sqlMapClientTemplate.insert(clazz.getSimpleName() + POSTFIX_INSERT, o);  
    }  
  
  
    /** 
     * 更新对象 
     */  
    public T update(T o) throws Exception {  
        sqlMapClientTemplate.update(clazz.getSimpleName() + POSTFIX_UPDATE, o);  
        return o;  
    }  
  
    /** 
     * 更新对象的部分属性 
     */  
    public int update(PK id, String[] properties, Object[] propertyValues) throws Exception {  
        // 更新数据库  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        map.put("id", id);  
        return sqlMapClientTemplate.update(clazz.getSimpleName() + POSTFIX_UPDATEBYMAP, map);  
    }  
  
    /** 
     * 根据ID列表更新对象的部分属性 
     */  
    public int updateByIdsMap(List<PK> ids,String[] properties, Object[] propertyValues) throws Exception{  
        // 更新数据库  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        map.put("ids", ids);  
        return sqlMapClientTemplate.update(clazz.getSimpleName() + POSTFIX_UPDATEBYIDSMAP, map);  
    }  
  
    /** 
     * 根据ID删除对象 
     */  
    public void deleteById(PK id) throws Exception {  
        sqlMapClientTemplate.delete(clazz.getSimpleName() + POSTFIX_DELETEBYID, id);  
    }  
  
    /** 
     * 根据ID删除对象 
     */  
    public void deleteByIds(List<PK> ids) throws Exception {  
        sqlMapClientTemplate.delete(clazz.getSimpleName() + POSTFIX_DELETEBYIDS, ids);  
    }  
  
    
    /** 
     * 批量删除根据ID对象 
     */  
    @SuppressWarnings("unchecked")
	public void batchDelete(final  List<PK> ids) throws Exception {  
    	sqlMapClientTemplate.execute(new SqlMapClientCallback(){ 
    	    public Object doInSqlMapClient(SqlMapExecutor executor) 
    	            throws SQLException { 
    	    executor.startBatch(); 
    	    int batch = 0; 
    	    for(PK id:ids){ 
    	 
    	    executor.insert(clazz.getSimpleName() + POSTFIX_DELETEBYID, id); 
    	    batch++; 
    	    //每500条批量提交一次。 
    	    if(batch==500){ 
    	    executor.executeBatch(); 
    	    batch = 0; 
    	    } 
    	    } 
    	    executor.executeBatch(); 
    	    return null; 
    	    } 
    	    }); 
    }
    
    /** 根据ID及条件删除对象 */  
    public void deleteByIdsMap(List<PK> ids, String[] properties, Object[] propertyValues) throws Exception {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        map.put("ids", ids);  
        sqlMapClientTemplate.delete(clazz.getSimpleName() + POSTFIX_DELETEBYIDSMAP, map);  
    }  
  
    /** 
     * 根据条件删除对象 
     */  
    public int deleteByMap(String[] properties, Object[] propertyValues) throws Exception {  
  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        return sqlMapClientTemplate.delete(clazz.getSimpleName() + POSTFIX_DELETEBYMAP, map);  
    }  
  
    /** 
     * 根据自定义SqlMap中的条件语句查询出列表(注意：不处理缓存) 
     */  
    @SuppressWarnings("unchecked")
	public List<T> findByStatementPostfix(String statementPostfix, String[] properties, Object[] propertyValues, 

String orderBy, String order) {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        if (orderBy != null) {  
            map.put("orderBy", orderBy);  
            map.put("order", order);  
        }  
        return sqlMapClientTemplate.queryForList(clazz.getSimpleName() + statementPostfix, map);  
    }  
      
    /** 
     * 根据自定义SqlMap中的条件语句查询出列表(注意：不处理缓存) 
     */  
    @SuppressWarnings("unchecked")
	public List<T> pageQueryByStatementPostfix(String statementPostfix, String[] properties, Object[] 

propertyValues, String orderBy, String order,int pageSize,int pageNo) {  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        if (orderBy != null) {  
            map.put("orderBy", orderBy);  
            map.put("order", order);  
        }  
        map.put("limit", true);  
        map.put("start", (pageNo - 1) * pageSize );// limit 操作  
        map.put("end", pageSize);  
        List<PK> ids = (List<PK>) sqlMapClientTemplate.queryForList(clazz.getSimpleName() + statementPostfix, map);  
        return findByIds(ids);  
    }  
  
    /** 
     * 根据自定义SqlMap中的条件语句更新数据（注意：不处理缓存） 
     */  
    public void updateByStatementPostfix(String statementPostfix, String[] properties, Object[] propertyValues) 

{  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        sqlMapClientTemplate.update(clazz.getSimpleName() + statementPostfix, map);  
    }  
  
    /** 
     * 根据自定义SqlMap中的条件语句删除数据（注意：不处理缓存） 
     */  
    public void deleteByStatementPostfix(String statementPostfix, String[] properties, Object[] propertyValues) 

{  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        sqlMapClientTemplate.delete(clazz.getSimpleName() + statementPostfix, map);  
    }  
  
    /** 
     * 根据自定义SqlMap中的条件语句插入数据（注意：不处理缓存） 
     */  
    public void insertByStatementPostfix(String statementPostfix, String[] properties, Object[] propertyValues) 

{  
        Map<String, Object> map = new HashMap<String, Object>();  
        for (int i = 0; i < properties.length; i++) {  
            map.put(properties[i], propertyValues[i]);  
        }  
        sqlMapClientTemplate.insert(clazz.getSimpleName() + statementPostfix, map);  
    }  
}
