package com.nh.biz.controller.Account;

import static com.nh.biz.service.system.UserMng.SESSION_USER;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nh.biz.domain.system.User;
import com.nh.biz.service.system.UserMng;
import com.nh.common.web.session.SessionProvider;

@Controller
public class SecurityController {

	@RequestMapping(value="/login",method= RequestMethod.GET)
    public String showLoginForm(Model model, @ModelAttribute LoginCommand command ) {
        return "login";
    }
	
    @RequestMapping(value="/login",method= RequestMethod.POST)
    public String login(HttpServletRequest request,HttpServletResponse response,
    		Model model, @Valid LoginCommand command, BindingResult errors) {

        if( errors.hasErrors() ) {
            return showLoginForm(model, command);
        }
        UsernamePasswordToken token = new UsernamePasswordToken(command.getUsername(), command.getPassword(), command.isRememberMe());
        try {
            SecurityUtils.getSubject().login(token);
        }catch (AuthenticationException e) {
            errors.reject( "error.login.generic", "登陆名或密码错误，请重新登陆！" );
        }
        if( errors.hasErrors() ) {
            return showLoginForm(model, command);
        } else {
        	sessionProvider.setAttribute(request,SESSION_USER, userMng.findUserByLoginName(command.getUsername()));
            return "redirect:/";
        }
    }

    @RequestMapping(value="/unauthorized",method=RequestMethod.GET)
    public String unauthorized(){
    	return "unauthorized";
    }
    
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request,HttpServletResponse response) {
        SecurityUtils.getSubject().logout();
        sessionProvider.logout(request, response);
        return "redirect:/login";
    }
    
    /**修改密码**/
    @RequestMapping(value="/changepassword",method = RequestMethod.GET)
    public String chanagepassword(@ModelAttribute ChangePassword changePassword,HttpServletRequest request){
    	return "system/user/changepassword";
    }
    
    @RequestMapping(value="/changepassword",method = RequestMethod.POST)
    public String chanagepassword(@Valid ChangePassword changePassword,BindingResult errors,HttpServletRequest request){
    	User user = sessionProvider.getSessionUser(request);
    	if(errors.hasErrors()){
    		return chanagepassword(changePassword,request);
    	}
    	if(!changePassword.getPassword1().equals(changePassword.getPassword2())){
    		errors.reject("user.changepassword.noequals","两次密码输入不一致.");
    		return chanagepassword(changePassword,request);
    	}
    	userMng.changepassword(user,changePassword);
    	
    	return "system/user/chpwsuccess";
    }
  
    
    @Resource
    private UserMng userMng;
    @Resource
    private SessionProvider sessionProvider;
}
