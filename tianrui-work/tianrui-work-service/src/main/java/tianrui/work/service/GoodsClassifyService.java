package tianrui.work.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import tianrui.work.api.IGoodsClassifyService;
import tianrui.work.bean.GoodsClassify;
import tianrui.work.mapper.java.GoodsClassifyMapper;
import tianrui.work.req.goods.GoodsClassifyFindReq;
import tianrui.work.req.goods.GoodsClassifyReq;
import tianrui.work.resp.goods.GoodsClassifyFindResp;
import tianrui.work.vo.PageTool;
import tianrui.work.vo.Result;

/**
 * 商品分类信息
 * 
 * @author Joe
 *
 */
@Service
public class GoodsClassifyService implements IGoodsClassifyService {

	@Autowired
	GoodsClassifyMapper goodsClassifyMapper;

	@Override
	public Result addGoodsClassify(GoodsClassifyReq req) throws Exception {
		Result rs = Result.getSuccessful();
		GoodsClassify record = new GoodsClassify();
		PropertyUtils.copyProperties(record, req);
		goodsClassifyMapper.insert(record);
		return rs;
	}

	@Override
	public Result editGoodsClassify(GoodsClassifyReq req) throws Exception {
		Result rs = Result.getSuccessful();
		GoodsClassify record = new GoodsClassify();
		PropertyUtils.copyProperties(record, req);
		goodsClassifyMapper.updateByPrimaryKey(record);
		return rs;
	}

	@Override
	public GoodsClassifyFindResp queryGoodsClassify(GoodsClassifyReq req) throws Exception {
		return null;
	}

	@Override
	public PageTool<GoodsClassifyFindResp> queryGoodsClassifyByList(GoodsClassifyFindReq req) throws Exception {
		PageTool<GoodsClassifyFindResp> page = new PageTool<GoodsClassifyFindResp>();
		GoodsClassify find = new GoodsClassify();
		if (req.getPageNo() != null) {
			find.setPageNo(req.getPageSize() * req.getPageNo());
			find.setPageSize(req.getPageSize());
			page.setPageNo(req.getPageNo());
			page.setPageSize(req.getPageSize());
		}

		find.setClassifyName(req.getClassifyName());

		List<GoodsClassify> list = goodsClassifyMapper.selectByGoodsClassify(find);
		long a = goodsClassifyMapper.selectBycount(find);

		List<GoodsClassifyFindResp> resp = new ArrayList<GoodsClassifyFindResp>();
		for (GoodsClassify bean : list) {
			GoodsClassifyFindResp sp = new GoodsClassifyFindResp();
			PropertyUtils.copyProperties(sp, bean);
			resp.add(sp);
		}

		page.setList(resp);
		page.setTotal(a);

		return page;
	}

}