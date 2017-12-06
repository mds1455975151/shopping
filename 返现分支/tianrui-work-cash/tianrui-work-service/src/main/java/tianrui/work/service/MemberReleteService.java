package tianrui.work.service;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tianrui.work.api.IMemberReleteService;
import tianrui.work.bean.MemberInfo;
import tianrui.work.bean.MemberRelated;
import tianrui.work.mapper.java.MemberInfoMapper;
import tianrui.work.mapper.java.MemberRelatedMapper;
import tianrui.work.req.related.MemberRelatedReq;
import tianrui.work.resp.related.MemberRelatedResp;
import tianrui.work.vo.PageTool;
import tianrui.work.vo.Result;
import tianrui.work.vo.UUIDUtil;

@Service
public class MemberReleteService implements IMemberReleteService {

	@Autowired
	MemberRelatedMapper memberRelatedMapper;
	@Autowired
	MemberInfoMapper memberInfoMapper;

	@Override
	public PageTool<MemberRelatedResp> select(MemberRelatedReq req) throws Exception {
		PageTool<MemberRelatedResp> page = new PageTool<MemberRelatedResp>();
		MemberRelated query = new MemberRelated();
		if(req.getPageNo()!=null){
			query.setPageNo(req.getPageNo()*req.getPageSize());
			query.setPageSize(req.getPageSize());
			page.setPageNo(req.getPageNo());
			page.setPageSize(req.getPageSize());
		}
		long a = memberRelatedMapper.selectByCount(query);
		page.setTotal(a);
		List<MemberRelated> list = memberRelatedMapper.selectByCoudition(query);
		page.setList(copyProperties2(list));
		return page;
	}
	private List<MemberRelatedResp> copyProperties2(List<MemberRelated> list)
			throws IllegalAccessException, InvocationTargetException, NoSuchMethodException {
		List<MemberRelatedResp> resp = new ArrayList<MemberRelatedResp>();
		for(MemberRelated rel : list){
			MemberRelatedResp sp = new MemberRelatedResp();
			PropertyUtils.copyProperties(sp, rel);
			resp.add(sp);
		}
		return resp;
	}
	@Override
	public Result saveMemberRelete(String fatherId, String memberId) {
		Result rs = Result.getSuccessful();
		//删除用户原有关系
		deleteMemberRelete(memberId);
		MemberInfo m = memberInfoMapper.selectByPrimaryKey(memberId);
		MemberInfo f = memberInfoMapper.selectByPrimaryKey(fatherId);
		MemberRelated save = new MemberRelated();
		save.setId(UUIDUtil.getUUID());
		save.setCreatetime(System.currentTimeMillis());
		//子类
		save.setMember(memberId);
		save.setMemberImg(m.getWechatImg());
		save.setMemberName(m.getWechatName());
		//父类
		save.setMemberFather(fatherId);
		save.setFatherImg(f.getWechatImg());
		save.setFatherName(f.getWechatName());
		memberRelatedMapper.insertSelective(save);
		return rs;
	}
	private void deleteMemberRelete(String memberId) {
		MemberRelated query = new MemberRelated();
		query.setMember(memberId);
		List<MemberRelated> list = memberRelatedMapper.selectByCoudition(query);
		for(MemberRelated bean : list){
			memberRelatedMapper.deleteByPrimaryKey(bean.getId());
		}
	}

}
