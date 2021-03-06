package tianrui.work.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tianrui.work.api.ICreditorService;
import tianrui.work.bean.Creditor;
import tianrui.work.mapper.java.CreditorMapper;
import tianrui.work.req.creditor.CreditorFindReq;
import tianrui.work.req.creditor.CreditorSaveReq;
import tianrui.work.req.creditor.CreditorUpdateReq;
import tianrui.work.resp.creditor.CreditorFindResp;
import tianrui.work.vo.DateChangeUtil;
import tianrui.work.vo.PageTool;
import tianrui.work.vo.Result;
import tianrui.work.vo.UUIDUtil;
@Service
public class CreditorService implements ICreditorService{

	@Autowired
	CreditorMapper creditorMapper;
	
	public Result creditorSave(CreditorSaveReq req) throws Exception{
		Result rs = Result.getSuccessful();
		Creditor record = new Creditor();
		PropertyUtils.copyProperties(record, req);
		record.setId(UUIDUtil.getUUID());
		//1正常 0禁用
		record.setCreditorStatus("1");
		record.setDebtTime(DateChangeUtil.changeStr(req.getDebtTimeStr(), "yyyy-MM-dd"));
		record.setCreatorTime(System.currentTimeMillis());
		creditorMapper.insertSelective(record);
		return rs;
	}

	public Result creditorUpdate(CreditorUpdateReq req) throws Exception {
		Result rs = Result.getSuccessful();
		Creditor record = new Creditor();
		PropertyUtils.copyProperties(record, req);
		record.setUpdateTime(System.currentTimeMillis());
		creditorMapper.updateByPrimaryKeySelective(record);
		return rs;
	}

	public Result creditorDelete(String id)throws Exception  {
		Result rs = Result.getSuccessful();
		Creditor bean = creditorMapper.selectByPrimaryKey(id);
		if(bean != null){
			Creditor upt = new Creditor();
			upt.setId(bean.getId());
			if(bean.getCreditorStatus().equals("1")){
				upt.setCreditorStatus("0");
			}else {
				upt.setCreditorStatus("1");
			}
			creditorMapper.updateByPrimaryKeySelective(upt);
		}else{
			rs.setCode("1");
			rs.setError("数据异常");
		}
		return rs;
	}

	public PageTool<CreditorFindResp> creditorFind(CreditorFindReq req)throws Exception  {
		PageTool<CreditorFindResp> page = new PageTool<CreditorFindResp>();
		Creditor find = new Creditor();
		if(req.getPageNo() != null){
			find.setPageNo(req.getPageSize()*req.getPageNo());
			find.setPageSize(req.getPageSize());
			page.setPageNo(req.getPageNo());
			page.setPageSize(req.getPageSize());
		}
		find.setCreditorIdcard(req.getCreditorIdcard());
		find.setCreditorStatus(req.getCreditorStatus());
		List<Creditor> list = creditorMapper.selectByCondition(find);
		long a = creditorMapper.selectBycount(find);
		page.setList(copyProperties2(list));
		page.setTotal(a);
		return page;
	}
	
	protected List<CreditorFindResp> copyProperties2(List<Creditor> list)throws Exception{
		List<CreditorFindResp> resp = new ArrayList<CreditorFindResp>();
		for(Creditor bean : list){
			CreditorFindResp sp = new CreditorFindResp();
			PropertyUtils.copyProperties(sp, bean);
			resp.add(sp);
		}
		return resp;
	}
}
