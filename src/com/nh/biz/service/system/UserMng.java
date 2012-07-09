package com.nh.biz.service.system;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nh.biz.controller.Account.ChangePassword;
import com.nh.biz.dao.impl.system.UserDao;
import com.nh.biz.domain.ResourceGroup;
import com.nh.biz.domain.system.Role;
import com.nh.biz.domain.system.User;
import com.nh.biz.service.ResourceTitleService;
import com.nh.biz.service.ServiceException;

@Service("userMng")
public class UserMng {

	private static Logger logger  = LoggerFactory.getLogger(UserMng.class);
	
	public static final String SESSION_USER = "sessionUser";
	
	
	//按ID查找用户
	public User findById(String userId) {
		return userDao.findById(userId);
	}
	
	//按部门查询用户
	public List<User> findByDepartment(String deptId) {
		return userDao.findByMap(new String[]{"deptId"}, new String[]{deptId},"","");
	}
	
	//登陆名查找用户
	public User findUserByLoginName(String username) {
		return userDao.findUniqueByMap(new String[]{"loginName"}, new String[]{username});
	}
	
	//用户新增
	@Transactional
	public String insert(User user){
		try {
			user.setPassWord("123");//默认密码123；
			String userId = (String)userDao.insert(user);
			user.setUserId(userId);
			insertUserRole(user);
			setResorucePri(user);
			return userId;
		} catch (Exception e) {
			logger.error("角色:{}保存出错", user.getUserName());
			throw new ServiceException("角色保存出错",e);
		}
	}
	
	
	//预设置用户的文档权限
	private void setResorucePri(User user) {
		List<Role> roles = user.getRoleList();
		Boolean actSetted = false;
		Boolean approvalSetted = false;
		for(Role role : roles){
			System.out.println( " role.getPermissionNames()"+role.getPermissionNames());
			if(!actSetted && role.getPermissionNames().indexOf("resource:act") >= 0){
				resourceTitleService.setAllResourceActToUser(user);
				actSetted =true;
			}
			if(!approvalSetted && role.getPermissionNames().indexOf("resource:approval") >= 0){
				resourceTitleService.setAllResourceApprovalToUser(user);
				approvalSetted =true;
			}
			if(actSetted && approvalSetted)
				break;
		}
	}


	//用户更新
	@Transactional
	public User update(User user){
		try {
			User oldUser = userDao.findById(user.getUserId());
			user.setPassWord(oldUser.getPassWord());
		    userDao.update(user);
		    deleteUserRole(user.getUserId());
		    insertUserRole(user);
			return user;
		} catch (Exception e) {
			logger.error("用户:{}更新出错", user.getUserName());
			throw new ServiceException("用户更新出错",e);
		}
	}
	
	//用户删除
	@Transactional
	public void delete(String userId){
		try {
			userDao.deleteById(userId);
			deleteUserRole(userId);
		} catch (Exception e) {
			logger.error("用户:{}删除出错", userId);
			throw new ServiceException("用户删除出错",e);
		}
	}
	
	//[用户-角色]中间表插入
	public void insertUserRole(User user){
		for(Integer roleId : user.getRoleIds()){
			userDao.insertByStatementPostfix(
				UserDao.INSERT_USERROLE,
				new String[]{"userId","roleId"},
				new String[]{user.getUserId(),String.valueOf(roleId)});
		}
	}
	
	//[用户-角色]中间表删除
	public void deleteUserRole(String userId){
		userDao.deleteByStatementPostfix(
				UserDao.DELETE_USERROLE_BY_USERID,
				new String[]{"userId"}, 
				new String[]{userId});
	}
	
	@Resource
	private UserDao userDao;
	@Resource
	private ResourceTitleService resourceTitleService;
	

	/**修改密码**/
	public void changepassword(User user, ChangePassword changePassword) {
		user.setPassWord(changePassword.getPassword1());
		try {
			userDao.update(user);
		} catch (Exception e) {
			throw new ServiceException(e);
		}
	}
}
