//跨浏览器事件工具
var EventUtil = {
	
	addHandler : function(element, type, handler){
		if (element.addEventListener){
			element.addEventListener(type, handler, false);
		} else if (element.attachEvent){
			element.attachEvent("on" + type, handler);
		} else {
			element["on" + type] = handler;
		}		
	},
	removeHandler : function(element, type, handler){
		if (element.removeEventListener){
			element.removeEventListener(type, handler, false);
		} else if (element.detachEvent){
			element.detachEvent("on" + type, handler);
		} else {
			element["on" + type] = null;
		}		
	}
	
};


/********************************************************
dhxGrid 分页.
params:
	name     -  unique name for the pagebar.
	url      -  url to get data
	pagesize -  size for per page,default by 20. (optional)

eg.
var page1 = new PageBar("page1","/site/gridxml",10);
page1.rendPageInfo(o);  //grid :{"grid":dhxGrid,"statusBar":statusBar}.
**********************************************************/

var PageBar = function(name,url,pagesize){ 
	this.url = url;
	this.grid = null ;
	this.pageSize  = pagesize || 20 ;
	this.totalCount  = 0 ;
	this.totalPage = 0 ;
	this.pageNo = 1 ;
	this.name = name;

	this.rendPageInfo = function(o){ 
	    this.grid = o.grid;
		this.pageSize = parseInt(this.grid.getUserData("","pageSize"));
		this.totalCount = parseInt(this.grid.getUserData("","totalCount"));
		this.totalPage = parseInt(this.grid.getUserData("","totalPage"));
		this.pageNo = parseInt(this.grid.getUserData("","pageNo"));
		var that = this;
		var prePage  = this.pageNo - 1;
		var nextPage = this.pageNo + 1;	
		var html="";
		html += "<a id=nev_first_"+this.name+" href=# class=page >首页</a> ";
		html += "<a id=nev_period_"+this.name+" href=# class=page>上一页</a> ";
		html += "<a id=nev_next_"+this.name+" href=# class=page>下一页</a> ";
		html += "<a id=nev_end_"+this.name+" href=# class=page>尾页</a> ";
		html += "<span class=pageinfo>第"+this.pageNo+"/"+this.totalPage+"页 </span>";
		html += "<span class=pageinfo>共 "+this.totalCount+" 条记录</span> ";
		o.statusBar.setText(html);
		var nev_first  = document.getElementById("nev_first_"+this.name);
		var nev_period = document.getElementById("nev_period_"+this.name);
		var nev_next   = document.getElementById("nev_next_"+this.name);
		var nev_end    = document.getElementById("nev_end_"+this.name);
		
		EventUtil.addHandler(nev_first,"click",function(){that.gopage(1);});
		EventUtil.addHandler(nev_period,"click",function(){that.gopage(prePage);});
		EventUtil.addHandler(nev_next,"click",function(){that.gopage(nextPage);});
		EventUtil.addHandler(nev_end,"click",function(){that.gopage(that.totalPage);});
	};
	
	this.gopage=function(pageNo){
	    var totalPage = parseInt(this.grid.getUserData("","totalPage")); 
	    if(pageNo < 1){alert("已经是首页");return;}
	    if(pageNo > totalPage){alert("已经是尾页");return;}
		this.grid.clearAll();
		this.grid.load(this.url+"?pageNo="+pageNo+"&pageSize="+this.pageSize);  
	};
};



//弹出模式窗口，有返回值；
function OpenMoldalWin(url,w,h)
{
var weight,height;
	if (w>0)  width = w; else width = 720;
	if (h>0)  height = h; else height = 720;
	
	var left=(screen.width-width)/2;
	var top=(screen.height-height)/2;
	
	var qryStr=null;
	config = "scrollbars=no;status=no;dialogLeft="+left+"px;dialogTop="+top+"px;dialogWidth="+width+"px;dialogHeight="+height+"px";
	qryStr= window.showModalDialog(url, null, config); 
	if (qryStr==null) return [];
	else return qryStr;		
}

function OpenWin(url,w,h){
	if (w>0)  width = w; else width = 720;
	if (h>0)  height = h; else height = 720;
	
	var left=(screen.width-width)/2;
	var top=(screen.height-height)/2;
 	window.open(url,'','left='+left+',top='+top+',width='+width+',height='+height+',resizable=1,scrollbars=no,status=no,toolbar=no,menubar=no,location=no');
  }
  
  
  //POST 方式提交
function createForm(method,action){
 var form=document.createElement('form');
           form.method='post';//也可以这样写
           form.action=action;
 document.body.appendChild(form);
           return form;
}

function addparam(name,value,form){
 var hidden=document.createElement('input');
            hidden.type='hidden';
            hidden.name=name;
            hidden.value=value;
 
   if(form){
         form.appendChild(hidden);
   }
 return hidden;
}

 