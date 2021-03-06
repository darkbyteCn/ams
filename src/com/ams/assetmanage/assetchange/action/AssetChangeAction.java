package com.ams.assetmanage.assetchange.action;
import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ams.BaseConst;
import com.ams.assetmanage.assetchange.entity.AssetChange;
import com.ams.assetmanage.assetchange.model.AssetChangeModel;
import com.ams.assetmanage.assetchange.service.AssetChangeService;
import com.ams.assetmanage.assetinf.entity.Assetinf;
import com.ams.assetmanage.assetinf.service.AssetinfService;
import com.ams.infomanage.depart.entity.Depart;
import com.ams.infomanage.depart.service.DepartService;
import com.ams.system.entity.User;
import com.ams.system.model.UserModel;
import com.ams.system.service.UserService;
import com.core.action.BaseAction;
import com.core.model.OutputMessage;
import com.util.updownload.*;
import com.util.enums.PageSizeEnum;
import com.util.json.JackJsonUtils;
import com.util.page.Pager;
import com.util.page.PagerHelper;

/**
 * 资产调拨控制器
 * @author simon
 * @date 2016年11月1日 下午4:18:00
 */
@Controller
public class AssetChangeAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6290317236056630565L;
	
	@Resource
	private AssetChangeService assetChangeService;
	@Resource 
	private DepartService departService;
	@Resource
	private AssetinfService assetinfService;
	@Resource
	public UserService userService;
	
	/**
	 * 跳转到新增资产调拨页面
	 * @author simon
	 * @date 2016年11月1日 下午4:22:03
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/add")
	public String add(ModelMap map)	{
		//1.assetinfList
		List<Assetinf> assetinfList=assetinfService.findByCondition(new Assetinf(),	null);
		map.addAttribute("assetinfList", assetinfList);
		//2.departList
		List<Depart> departList=departService.findByCondition(new Depart(), null);
		map.addAttribute("departList", departList);
		//3.userList
		List<User> userList=userService.findByCondition(new UserModel(), null);
		map.addAttribute("userList", userList);
		//4.日期
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		map.addAttribute("now_time", df.format(new Date()));
		return ASSETCHANGE+"edit";
	}
	
	/**
	 * 跳转到资产调拨列表
	 * @author simon
	 * @date 2016年11月1日 下午4:23:38
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/toList")
	public String toList(){
		return ASSETCHANGE+"list";
	}
	
	/**
	 * 查看详细
	 * @author simon
	 * @date 2016年11月1日 下午4:28:39
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/detail")
	public String detail(String id,ModelMap map){
		if(StringUtils.isNotEmpty(id)){
			AssetChangeModel model=assetChangeService.getModelById(id);
			map.addAttribute("model", model);
			return ASSETCHANGE+"detail";
		}else{
			this.returnException("资产调拨编号不存在，查看不了详细！msg from Action");
		}
		return ERROR;
	}
	
	/**
	 * 返回资产调拨列表的json字符串
	 * @author simon
	 * @date 2016年11月1日 下午4:35:15
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/list",produces={"application/json;charset=UTF-8"})
	public @ResponseBody String list(AssetChangeModel model){
		Pager page=PagerHelper.getInstance(this.request, PageSizeEnum.MIDDLE);
		List<AssetChangeModel> list=assetChangeService.findByCondition(model,page);
		page.setRows(list);
		return JackJsonUtils.toJSon(page);
	}
	
	/**
	 * 资产调拨修改
	 * @author simon
	 * @date 2016年11月1日 下午4:39:58
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/edit")
	public String edit(String id,ModelMap map){
		//1.assetinfList
		List<Assetinf> assetinfList=assetinfService.findByCondition(new Assetinf(),	null);
		map.addAttribute("assetinfList", assetinfList);
		//2.departList
		List<Depart> departList=departService.findByCondition(new Depart(), null);
		map.addAttribute("departList", departList);
		//3.userList
		List<User> userList=userService.findByCondition(new UserModel(), null);
		map.addAttribute("userList", userList);
		//4.model
		
		if(StringUtils.isNotEmpty(id)){
			AssetChange model=assetChangeService.getById(id);
			map.addAttribute("model", model);
			return ASSETCHANGE+"edit";
		}else{
			this.returnException("资产调拨编号不存在，不能编辑！msg from Action");
		}
		return ERROR;
	}
	
	/**
	 * 根据ID删除资产调拨信息
	 * @author simon
	 * @date 2016年11月1日 下午7:57:04
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/delete",produces={"application/json;charset=UTF-8"})
	public @ResponseBody String delete(String id){
		OutputMessage msg=new OutputMessage();
		if(StringUtils.isNotEmpty(id)){
			assetChangeService.delete(id);
			msg=setOutputMessage(true, "删除成功！msg from Action", id);
		}else{
			msg=setOutputMessage(false, "删除失败，资产调拨编号为空！msg from Action", id);
		}
		return JackJsonUtils.toJSon(msg);
	}
	
	/**
	 * 保存按钮
	 * @author simon
	 * @date 2016年11月2日 上午11:53:24
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/save",produces={"application/json;charset=UTF-8"})
	public @ResponseBody String save(AssetChange model){
		OutputMessage msg=new OutputMessage();
		if(null!=model){
			if(StringUtils.isNotEmpty(model.getAciId())){//修改
				AssetChange assetChange=assetChangeService.getById(model.getAciId());
				if(null!=assetChange){
					assetChangeService.update(model);
					msg=setOutputMessage(true, "修改成功！msg from Action", model.getAciId());
				}else{
					msg=setOutputMessage(false, "该资产调拨信息已经被删除！msg from Action", model.getAciId());
				}
			}else{//保存
				if(isBack(model.getAssetId()).equals("true")){//如果该资被归还或无记录
					assetChangeService.save(model);
					msg=setOutputMessage(true, "领用成功！msg from Action", model.getAciId());
				}else{
					msg=setOutputMessage(false, "该资产尚未归还！msg from Action", model.getAciId());
				}
				
			}
		}else{
			msg=setOutputMessage(false, "数据为空 msg from Action", "");
		}
		String json=JackJsonUtils.toJSon(msg);
		return json;
	}
	
	/**
	 * 资产调拨是否归还。默认为领取状态，未归还。false是领用状态，true是归还和无记录状态
	 * @author simon
	 * @date 2016年11月1日 下午8:30:39
	 * @param id
	 * @return
	 */
	public String isBack(String id){
		return String.valueOf(assetChangeService.isBack(id));
	}
	
	/**
	 * 归还资产
	 * @author simon
	 * @date 2016年11月2日 上午11:57:13
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/assetmanage/assetchange/back",produces={"application/json;charset=UTF-8"})
	public @ResponseBody String back(String id){
		OutputMessage msg=new OutputMessage();
		if(StringUtils.isNotEmpty(id)){
			AssetChange assetChange=assetChangeService.getById(id);
			assetChange.setAssetStatus("0");//设置资产状态为0 0为归还
			assetChangeService.update(assetChange);
			msg=setOutputMessage(true, "归还成功！msg from Action", id);
		}else{
			msg=setOutputMessage(false, "归还失败，资产调拨编号为空！msg from Action", id);
		}
		return JackJsonUtils.toJSon(msg);
	}
	
	/***
	 * 附件上传
	 * @author simon
	 * @date 2016年11月24日 上午11:05:30
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value="/assetmanage/assetchange/upload",produces={"application/json;charset=UTF-8"})
	public void upload(@RequestParam(value="file", required=false) MultipartFile file) throws IOException{
		UploadHelper.upload(file, request);
	}

	
}
