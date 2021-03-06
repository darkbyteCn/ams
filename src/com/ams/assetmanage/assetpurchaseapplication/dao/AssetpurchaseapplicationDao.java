package com.ams.assetmanage.assetpurchaseapplication.dao;

import java.util.List;

import com.ams.company.entity.Company;
import com.ams.company.model.CompanyModel;
import com.ams.assetmanage.assetpurchaseapplication.entity.Assetpurchaseapplication;
import com.ams.assetmanage.assetpurchaseapplication.model.AssetpurchaseapplicationModel;
import com.ams.assetmanage.maintenanceRecord.model.MaintenanceRecordModel;
import com.core.dao.BaseDao;
import com.util.page.Pager;

/**
 * 单位管理
 * @author Wymann
 * @Data 2014-12-12 下午06:11:59
 *
 */
public interface AssetpurchaseapplicationDao extends BaseDao<Assetpurchaseapplication>{

	/**
	 * 条件查询
	 * @param model
	 * @param page
	 * @return
	 */
	List<AssetpurchaseapplicationModel> findByCondition(AssetpurchaseapplicationModel model, Pager page);

	/**
	 * 检查当前资产购置申请是否存在
	 * @param name
	 * @param id
	 * @return
	 */
	List<Assetpurchaseapplication> checkAssetpurchaseapplication(String name, String id);
	
	/**
	 * 根据名称获取资产购置申请信息
	 * @param name
	 * @return
	 */
	Assetpurchaseapplication getByName(String name);
	
	/**
	 * 根据资产id获取维护记录model
	 * @param id
	 * @return
	 */
	AssetpurchaseapplicationModel getModel(String id);

}
