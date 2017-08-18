package com.tianrui.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.tianrui.web.util.LoggerUtils;
import com.tianrui.web.util.StringUtils;

import tianrui.work.api.IAdInfoService;
import tianrui.work.api.IGoodsClassifyService;
import tianrui.work.api.IGoodsInfoService;
import tianrui.work.api.IShoppingCartService;
import tianrui.work.bean.MemberInfo;
import tianrui.work.req.ad.AdInfoReq;
import tianrui.work.req.goods.GoodsClassifyReq;
import tianrui.work.req.goods.GoodsInfoFindReq;
import tianrui.work.req.goods.GoodsInfoReq;
import tianrui.work.req.shoppingcart.ShoppingCartReq;
import tianrui.work.resp.ad.AdInfoResp;
import tianrui.work.resp.goods.GoodsClassifyFindResp;
import tianrui.work.resp.goods.GoodsInfoFindResp;
import tianrui.work.vo.Result;

@Controller
@RequestMapping("/wechat/shop/goods")
public class GoodsInfoAction {
	private Logger log = Logger.getLogger(getClass());

	@Autowired
	IGoodsInfoService goodsInfoService;
	@Autowired
	IGoodsClassifyService goodsClassifyService;
	@Autowired
	IAdInfoService adInfoService;
	@Autowired
	IShoppingCartService shoppingCartService;

	/** 跳转商品首页页面 */
	@RequestMapping("goodshome")
	public ModelAndView goodsHome(GoodsInfoReq req) throws Exception {
		LoggerUtils.info(log, "---------- [/wechat/shop/goods/goodshome]");
		String goodsType = req.getGoodsType();
		if (StringUtils.isNull(goodsType))
			throw new Exception("");

		String viewName = "";
		if (goodsType.equals("1"))
			viewName = "shop/goods/ordinaryhome";
		else if (goodsType.equals("2"))
			viewName = "shop/goods/redpackethome";
		else
			throw new Exception("");

		ModelAndView view = new ModelAndView();
		view.addObject("goodsType", goodsType);

		AdInfoReq adInfoReq = new AdInfoReq(goodsType);
		List<AdInfoResp> adInfoList = adInfoService.getAdInfoList(adInfoReq);
		view.addObject("adInfoList", adInfoList);

		GoodsClassifyReq goodsClassifyReq = new GoodsClassifyReq(goodsType);
		List<GoodsClassifyFindResp> classifyList = goodsClassifyService.getGoodsClassifyList(goodsClassifyReq);
		view.addObject("classifyList", classifyList);

		view.setViewName(viewName);
		return view;
	}

	/** 跳转商品列表页面 */
	@RequestMapping("goodslist")
	public ModelAndView goodsList(GoodsInfoFindReq req) throws Exception {
		LoggerUtils.info(log, "---------- [/wechat/shop/goods/goodslist]");
		req.setGoodsStatus("1");

		if (req.getPageNo() == null) {
			req.setPageNo(0);
			req.setPageSize(2);
		}

		ModelAndView view = new ModelAndView();
		view.addObject("classifyId", req.getClassifyId());
		view.addObject("goodsType", req.getGoodsType());
		view.addObject("sifting", req.getSifting());

		GoodsClassifyReq goodsClassifyReq = new GoodsClassifyReq(req.getGoodsType());
		List<GoodsClassifyFindResp> classifyList = goodsClassifyService.getGoodsClassifyList(goodsClassifyReq);
		view.addObject("classifyList", classifyList);

		List<GoodsInfoFindResp> goodsList = goodsInfoService.getGoodsInfoList(req);
		view.addObject("goodsList", goodsList);

		view.setViewName("shop/goods/goodslist");
		return view;
	}

	/** 加载商品数据 */
	@RequestMapping("toloadgoodslist")
	@ResponseBody
	public Result toLoadGoodsList(GoodsInfoFindReq req) throws Exception {
		LoggerUtils.info(log, "---------- [/wechat/shop/goods/toloadgoodslist]");
		List<GoodsInfoFindResp> goodsList = goodsInfoService.getGoodsInfoList(req);
		Result rs = Result.getSuccessful();
		rs.setData(goodsList);
		return rs;
	}

	/** 跳转商品详情页面 */
	@RequestMapping("goodsdetails")
	public ModelAndView goodsDetails(GoodsInfoReq req) throws Exception {
		LoggerUtils.info(log, "---------- [/wechat/shop/goods/goodsdetails]");
		GoodsInfoFindResp goodsInfo = goodsInfoService.queryGoodsInfoByOne(req.getGoodsId());

		// 更新浏览记录数
		req.setBrowseNum(goodsInfo.getBrowseNum() + 1);
		goodsInfoService.editGoodsInfo(req);

		ModelAndView view = new ModelAndView();
		view.addObject("goodsInfo", goodsInfo);
		view.addObject("goodsImgList", analysisImg(goodsInfo.getGoodsImg()));
		view.addObject("goodsDetailsList", analysisImg(goodsInfo.getGoodsDetails()));
		view.addObject("goodsParamList", analysisParam(goodsInfo.getGoodsParam()));
		view.setViewName("shop/goods/goodsdetails");
		return view;
	}

	/** 添加商品到购物车 */
	@RequestMapping("addgoods")
	@ResponseBody
	public Result addGoods(HttpServletRequest request, ShoppingCartReq req) throws Exception {
		LoggerUtils.info(log, "---------- [/wechat/shop/goods/addgoods]");
		// TODO
		// MemberInfo member = SessionManage.getSessionManage(request);
		MemberInfo member = getMemberInfo();
		GoodsInfoFindResp goodsInfoFindResp = goodsInfoService.queryGoodsInfoByOne(req.getGoodsId());

		// 添加购物车
		req.setMemberId(member.getMemberId());
		req.setCreationTime(System.currentTimeMillis());
		req.setGoodsName(goodsInfoFindResp.getGoodsName());
		req.setGoodsImg(goodsInfoFindResp.getFirstGoodsImg());
		req.setGoodsPrice(goodsInfoFindResp.getGoodsPrice());
		req.setGoodsRedPacket(goodsInfoFindResp.getRedPacket());
		req.setGoodsType(goodsInfoFindResp.getGoodsType());
		req.setShoppingCartStatus("1");// 购物车商品状态:1-已添加;2-已购买;3-已删除
		Result rs = shoppingCartService.addShoppingCart(req);

		// 更新商品库存和销量
		Integer inventory = goodsInfoFindResp.getInventory() - req.getGoodsNum();// 库存
		Integer salesvolume = goodsInfoFindResp.getSalesvolume() + req.getGoodsNum();// 销量
		Integer buyNum = goodsInfoFindResp.getBuyNum() + req.getGoodsNum(); // 购买数量
		GoodsInfoReq goodsInfoReq = new GoodsInfoReq();
		goodsInfoReq.setGoodsId(goodsInfoFindResp.getGoodsId());
		goodsInfoReq.setInventory(inventory);
		goodsInfoReq.setSalesvolume(salesvolume);
		goodsInfoReq.setBuyNum(buyNum);
		rs = goodsInfoService.editGoodsInfo(goodsInfoReq);

		return rs;
	}

	public MemberInfo getMemberInfo() {
		MemberInfo memberInfo = new MemberInfo();
		memberInfo.setMemberId("123456789");
		return memberInfo;
	}

	/** 解析图片字段 */
	private List<String> analysisImg(String reqStr) {
		List<String> rspList = null;
		if (!StringUtils.isNull(reqStr)) {
			rspList = new ArrayList<>();
			String[] arr = reqStr.split("[|]");
			for (int i = 0; i < arr.length; i++) {
				rspList.add(arr[i]);
			}
		}
		return rspList;
	}

	/** 解析商品参数 */
	private List<Map<String, String>> analysisParam(String reqStr) {
		List<Map<String, String>> rspList = null;
		if (!StringUtils.isNull(reqStr)) {
			rspList = new ArrayList<Map<String, String>>();
			String[] arr = reqStr.split("[|]");
			for (int i = 0; i < arr.length; i++) {
				String[] a = arr[i].split(":");
				Map<String, String> map = new HashMap<String, String>();
				map.put("key", a[0]);
				map.put("value", a[1]);
				rspList.add(map);
			}
		}
		return rspList;
	}

}