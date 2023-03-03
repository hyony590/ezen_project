package toystory.common.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import toystory.common.file.mapper.FileMapper;
import toystory.common.goods.mapper.GoodsMapper;
import toystory.common.goods.model.GoodsModel;
import toystory.utils.file.AttachFileModel;
import toystory.utils.file.FileUtils;

@Log4j
@Service
@AllArgsConstructor
public class AdminGoodsServiceImpl implements AdminGoodsService {

	private GoodsMapper goodsMapper;
	private FileMapper fileMapper;

	@Resource(name = "fileUtils")
	private FileUtils fileUtils;

	// 관리자 - 전체 상품 리스트 출력 / 12.15 페이징(매개변수) 추가
	@Override
	public List<GoodsModel> goodsAllList(int amount, int pageNum) {
		return goodsMapper.goodsAllList(amount, pageNum);
	}

	/** 최창선 : 상품등록에 이미지 등록 추가 */
	@Override
	public void goodsRegister(GoodsModel goodsModel, HttpServletRequest request) throws Exception {

		goodsModel.setG_option(goodsModel.getG_option().trim());
		goodsMapper.goodsRegister(goodsModel);
//		goodsModel.setF_jtkey(goodsModel.getG_id());

		List<AttachFileModel> list = fileUtils.parseInsertFileInfo(goodsModel, request);

		for (int i = 0, size = list.size(); i < size; i++) {

			fileMapper.fileRegister(list.get(i));
//			fileMapper.mainCheck(list.get(i).getF_num());
			log.info("서비스 모델 출력" + list.get(i).toString());

		}

	}

	/*
	 * @Override public void goodsRegister(GoodsModel goodsModel, HttpServletRequest
	 * request) {
	 * 
	 * goodsMapper.goodsRegister(goodsModel);
	 * 
	 * }
	 */
	@Override //12/26 request, multipart추가함
	   public boolean goodsModify(int g_id, GoodsModel goodsModel, HttpServletRequest request) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("f_jtkey", g_id);
		map.put("f_jtname", "G");
	      List<AttachFileModel> uploadFile = fileMapper.imageList(map);
	      List<AttachFileModel> list = fileUtils.parseInsertFileInfo(goodsModel, request);

	      for (int i = 0, size = list.size(); i < size; i++) {
	         if(list.get(i).getF_main_yn().equals("N")) {
	            fileMapper.fileRegister(list.get(i));
	         }
	      }
	      
	      if(fileUtils.mainUpdateFileInfo(g_id, uploadFile, request).size() > 0) {
	         fileMapper.mainUpdate(fileUtils.mainUpdateFileInfo(g_id, uploadFile, request).get(0).getF_ogname(),
	               fileUtils.mainUpdateFileInfo(g_id, uploadFile, request).get(0).getF_svname(),
	               fileUtils.mainUpdateFileInfo(g_id, uploadFile, request).get(0).getF_size(),
	               g_id);
	         return goodsMapper.goodsModify(goodsModel) == 1;// 정상적으로 수정되면 1이 반환됨
	      }else {
	         return goodsMapper.goodsModify(goodsModel) == 1;// 정상적으로 수정되면 1이 반환됨
	      }
	   }

	@Override
	public void goodsDelete(int g_Id) {
		goodsMapper.goodsDelete(g_Id);
	}

	@Override
	public List<GoodsModel> goodsRegisterNumber() {
		return goodsMapper.goodsRegisterNumber();
	}

	// 12.15 게시글 전체 개수 계산 메소드 추가
	@Override
	public int goodsListTotalCountAll() {
		return goodsMapper.goodsListTotalCountAll();
	}
	
	//12.27 기존 이미지 삭제
		@Override
		public void fileDelete(int f_num) {
			fileMapper.fileDelete(f_num);
		}

}