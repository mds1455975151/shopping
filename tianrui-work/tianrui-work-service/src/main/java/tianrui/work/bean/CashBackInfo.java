package tianrui.work.bean;

public class CashBackInfo {
	private String id;
	private String cashBackId;
	private String memberId;
	private String memberName;
	private Double backAmount;
	private Double backMoney;
	private Double backRatio;
	private String backRemark;
	private String creater;
	private Long createTime;
	private String modify;
	private Long modifyTime;
	private String desc1;
	private String desc2;
	private String desc3;
	private String desc4;

	private Long createTimeBegin;
	private Long createTimeEnd;

	private Integer pageNo;
	private Integer pageSize;
	private String pageSort;

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public String getPageSort() {
		return pageSort;
	}

	public void setPageSort(String pageSort) {
		this.pageSort = pageSort;
	}

	public void setPageSort(String sordName, String sord) {
		if (sordName == null)
			return;

		if (sord == null)
			sord = "desc";

		if (pageSort == null)
			pageSort = sordName + " " + sord;
		else
			pageSort = ", " + sordName + " " + sord;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id == null ? null : id.trim();
	}

	public String getCashBackId() {
		return cashBackId;
	}

	public void setCashBackId(String cashBackId) {
		this.cashBackId = cashBackId == null ? null : cashBackId.trim();
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId == null ? null : memberId.trim();
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName == null ? null : memberName.trim();
	}

	public Double getBackAmount() {
		return backAmount;
	}

	public void setBackAmount(Double backAmount) {
		this.backAmount = backAmount;
	}

	public Double getBackMoney() {
		return backMoney;
	}

	public void setBackMoney(Double backMoney) {
		this.backMoney = backMoney;
	}

	public Double getBackRatio() {
		return backRatio;
	}

	public void setBackRatio(Double backRatio) {
		this.backRatio = backRatio;
	}

	public String getBackRemark() {
		return backRemark;
	}

	public void setBackRemark(String backRemark) {
		this.backRemark = backRemark == null ? null : backRemark.trim();
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater == null ? null : creater.trim();
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public String getModify() {
		return modify;
	}

	public void setModify(String modify) {
		this.modify = modify == null ? null : modify.trim();
	}

	public Long getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Long modifyTime) {
		this.modifyTime = modifyTime;
	}

	public String getDesc1() {
		return desc1;
	}

	public void setDesc1(String desc1) {
		this.desc1 = desc1 == null ? null : desc1.trim();
	}

	public String getDesc2() {
		return desc2;
	}

	public void setDesc2(String desc2) {
		this.desc2 = desc2 == null ? null : desc2.trim();
	}

	public String getDesc3() {
		return desc3;
	}

	public void setDesc3(String desc3) {
		this.desc3 = desc3 == null ? null : desc3.trim();
	}

	public String getDesc4() {
		return desc4;
	}

	public void setDesc4(String desc4) {
		this.desc4 = desc4 == null ? null : desc4.trim();
	}

	public Long getCreateTimeBegin() {
		return createTimeBegin;
	}

	public void setCreateTimeBegin(Long createTimeBegin) {
		this.createTimeBegin = createTimeBegin;
	}

	public Long getCreateTimeEnd() {
		return createTimeEnd;
	}

	public void setCreateTimeEnd(Long createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}

}