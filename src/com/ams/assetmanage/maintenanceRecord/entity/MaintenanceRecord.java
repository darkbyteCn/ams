package com.ams.assetmanage.maintenanceRecord.entity;

import java.sql.Timestamp;



/**
 * 资产维护记录实体
 * @author JackH
 *
 */
public class MaintenanceRecord {

	private String maintenancerecordId; //主键 维护记录编号
	private String assetId; //外键  资产编号
	private String recordPeople; // 检修成员
	private String recordInfo; //检修性质
	private Timestamp repairTime; //检修日期
	private String repairExstatus; //检修前状态
	private String repairContent; //检修内容
	private String repairAftstatus; //检修后状态
	private String acceptancePerson; //验收人
	private Timestamp recordTime; //记录时间
	private String acceptanceEvaluation; //验收评价
	
	
	public String getMaintenancerecordId() {
		return maintenancerecordId;
	}
	public void setMaintenancerecordId(String maintenancerecordId) {
		this.maintenancerecordId = maintenancerecordId;
	}
	public String getAssetId() {
		return assetId;
	}
	public void setAssetId(String assetId) {
		this.assetId = assetId;
	}
	public String getRecordPeople() {
		return recordPeople;
	}
	public void setRecordPeople(String recordPeople) {
		this.recordPeople = recordPeople;
	}
	public String getRecordInfo() {
		return recordInfo;
	}
	public void setRecordInfo(String recordInfo) {
		this.recordInfo = recordInfo;
	}
	public Timestamp getRepairTime() {
		return repairTime;
	}
	public void setRepairTime(Timestamp repairTime) {
		this.repairTime = repairTime;
	}
	public String getRepairExstatus() {
		return repairExstatus;
	}
	public void setRepairExstatus(String repairExstatus) {
		this.repairExstatus = repairExstatus;
	}
	public String getRepairContent() {
		return repairContent;
	}
	public void setRepairContent(String repairContent) {
		this.repairContent = repairContent;
	}
	public String getRepairAftstatus() {
		return repairAftstatus;
	}
	public void setRepairAftstatus(String repairAftstatus) {
		this.repairAftstatus = repairAftstatus;
	}
	public String getAcceptancePerson() {
		return acceptancePerson;
	}
	public void setAcceptancePerson(String acceptancePerson) {
		this.acceptancePerson = acceptancePerson;
	}
	public Timestamp getRecordTime() {
		return recordTime;
	}
	public void setRecordTime(Timestamp recordTime) {
		this.recordTime = recordTime;
	}
	public String getAcceptanceEvaluation() {
		return acceptanceEvaluation;
	}
	public void setAcceptanceEvaluation(String acceptanceEvaluation) {
		this.acceptanceEvaluation = acceptanceEvaluation;
	}
}
