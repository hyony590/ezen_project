package toystory.common.order.service;


import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.file.mapper.FileMapper;
import toystory.common.god.mapper.GodMapper;
import toystory.common.order.dao.OrderDAO;
import toystory.common.order.mapper.OrderMapper;
import toystory.common.order.model.OrderModel;
import toystory.common.review.model.ReviewModel;
import toystory.utils.file.AttachFileModel;
import toystory.utils.file.FileUtils;

@Log4j
@Service
@AllArgsConstructor
public class OrderServiceImpl implements OrderService{
	
	private OrderMapper orderMapper;
	private GodMapper godMapper;
	private FileMapper fileMapper;
	
	@Resource(name="orderDAO")
	private OrderDAO orderDAO;
	
	@Resource(name = "fileUtils")
	private FileUtils fileUtils;
	
	@Override
	public int buy(OrderModel orderModel) {

		
		  orderModel.setO_pw("");
		  
		  if(orderModel.getO_price() * orderModel.getO_count() >= 30000) {
		  orderModel.setO_dfeeYN("N");
		  
		  }else { orderModel.setO_dfeeYN("Y");
		  
		  }
		  
		  int totalPrice = orderModel.getO_price() * orderModel.getO_count();
		
		return orderMapper.buy(orderModel);
	}

	@Override
	public List<OrderModel> myOrderList(Map<String, Object> map) {
		return orderMapper.myOrderList(map);
	}
	
	/*
	 * 작성자: 강승현, 장한원
	 */
	// 마이페이지-주문내역 확인 구매확정 버튼을 통한 리뷰 작성 폼 띄움
	@Override
	public ReviewModel reviewRegister(int o_num) {
		return godMapper.reviewRegister(o_num);
	}

	// 마이페이지-주문내역 확인 구매확정 버튼을 통한 리뷰 작성 처리
	@Override
	public void reviewRegisterPro(ReviewModel reviewModel, HttpServletRequest request, MultipartHttpServletRequest multirequest) throws Exception {
		godMapper.reviewRegisterPro(reviewModel);

		reviewModel.setF_jtkey(reviewModel.getR_num());

		List<AttachFileModel> list = fileUtils.parseInsertFileInfo(reviewModel, request);

		for (int i = 0, size = list.size(); i < size; i++) {
			fileMapper.fileRegister(list.get(i));
		}
	}
	
	@Override
	public List<Map<String,Object>> orderStart(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return orderDAO.orderStart(map);
	}

	@Override
	public int confirmOrder(OrderModel orderModel) {
		
		return orderMapper.updateDelivery(orderModel);
	}

	@Override
	public int myOrderCount(Map<String, Object> map) {
		
		return orderMapper.myOrderCount(map);
	}
	
	
	@Override
	public Map<String, Object> loginCheck(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return orderDAO.selectId(map);
	}
	
	@Override
	public int buy(Map<String, Object> map) {
		// TODO Auto-generated method stub
		int i= orderDAO.buy(map);
		
		return i;
	}

	
	//invoice 에 넣을값 구하기... 사실 이건 주문번호이고 송장번호는 나중에 넣는거지만 송장번호 없으니 이걸로 대체...
	@Override
	public String getOrderNum() {
		int result = orderMapper.getOrderNum();
		String code = String.format("%04d", result);
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		String orderNum = sdf.format(date) + code;
		
		log.info("생성된 주문번호 : " + orderNum);
		log.info("생성된 주문번호 : " + orderNum);
		log.info("생성된 주문번호 : " + orderNum);
		log.info("생성된 주문번호 : " + orderNum);
		log.info("생성된 주문번호 : " + orderNum);
		
		return orderNum;
	}

}

