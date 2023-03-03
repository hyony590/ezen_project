package toystory.utils.file;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import toystory.common.goods.model.GoodsModel;
import toystory.common.notice.model.NoticeModel;
import toystory.common.review.model.ReviewModel;

//parseUpdateFileInfo 메소드는 수정 필요함 화면 보고 어떻게 할지 정하고 작업하기로...
@Component("fileUtils")
public class FileUtils {

	Logger log = Logger.getLogger(this.getClass());
	private static final String FILE_PATH = "/resources/assets/img/image/";

	public List<AttachFileModel> parseInsertFileInfo(AttachFileModel uploadFile, HttpServletRequest request)
			throws Exception {

		String realPath = "";
		String savePath = FILE_PATH;

		realPath = request.getRealPath(savePath);

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		Iterator<String> iterator = multipartRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null; // 확장자
		String storedFileName = null;

		List<AttachFileModel> list = new ArrayList<>();

//		String boardIdx = (String)map.get("IDX");

		File file = new File(realPath);

		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = multipartRequest.getFile(iterator.next());

			if (multipartFile.isEmpty() == false) {

				// 업로드한 파일의 이름 구하기
				originalFileName = multipartFile.getOriginalFilename();

				// 업로드한 파일의 확장자만 구하기
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

				// 저장용 파일 이름 만들기
				storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;

				file = new File(realPath + storedFileName);

				// 파일로 저장
				multipartFile.transferTo(file);

				// DB 저장용 데이터 Model 담아서 필요한 서비스로 보내기
				AttachFileModel fileModel = new AttachFileModel();

				if (multipartFile.getName().equals("mainImage")) {
					fileModel.setF_main_yn("Y");
				} else {
					fileModel.setF_main_yn("N");
				}

				fileModel.setF_jtkey(uploadFile.getF_jtkey());
				fileModel.setF_ogname(originalFileName);
				fileModel.setF_svname(storedFileName);
				fileModel.setF_size(multipartFile.getSize());

				if (uploadFile instanceof GoodsModel) {
					fileModel.setF_jtname("G");
					fileModel.setF_jtkey(((GoodsModel) uploadFile).getG_id());
				} else if (uploadFile instanceof ReviewModel) {
					fileModel.setF_jtname("R");
					fileModel.setF_jtkey(((ReviewModel) uploadFile).getR_num());
				} else if (uploadFile instanceof NoticeModel) {
					fileModel.setF_jtname("N");
					fileModel.setF_jtkey(((NoticeModel) uploadFile).getN_num());
				} else {
					fileModel.setF_jtname("W");
				}

				list.add(fileModel);

			}

		}

		for (int i = 0; i < list.size(); i++) {
			log.info("파일유틸 리전 전 출력 : " + list.size());
			log.info("파일유틸 리전 전 출력 : " + list.get(i).toString());

		}

		return list;
	}

	public List<AttachFileModel> parseUpdateFileInfo(AttachFileModel uploadFile, HttpServletRequest request)
			throws Exception {

		String realPath = "";
		String savePath = FILE_PATH;

		realPath = request.getRealPath(savePath);

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		Iterator<String> iterator = multipartRequest.getFileNames();

		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null; // 확장자
		String storedFileName = null;

		// 글만 수정 시 필요한 애들
		String requestName = null;
		String idx = null;

		List<AttachFileModel> list = new ArrayList<>();

		File file = new File(realPath);

		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = multipartRequest.getFile(iterator.next());

			// 파일이 있으면
			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;

				multipartFile.transferTo(new File(FILE_PATH + storedFileName));

				// DB 저장용 데이터 Model 담아서 필요한 서비스로 보내기
				AttachFileModel fileModel = new AttachFileModel();

				fileModel.setF_ogname(originalFileName);
				fileModel.setF_svname(storedFileName);
				fileModel.setF_size(multipartFile.getSize());
				fileModel.setF_del_yn("Y");

				list.add(fileModel);

				// 파일이 없다면 (글만 수정한다면)
				/*
				 * } else { requestName = multipartFile.getName(); idx = "IDX_" +
				 * requestName.substring(requestName.indexOf("_") + 1); if (uploadFile.getF_idx
				 * == true && uploadFile.getF_idx != null) {
				 * 
				 * AttachFileModel fileModel = new AttachFileModel();
				 * 
				 * list.add(listMap); } }
				 */
			}

		}
		return list;
	}

	public List<AttachFileModel> mainUpdateFileInfo(int g_id, List<AttachFileModel> uploadFile,
			HttpServletRequest request) throws Exception {
		String realPath = "";
		String savePath = FILE_PATH;
		realPath = request.getRealPath(savePath);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null; // 확장자
		String storedFileName = null;
		List<AttachFileModel> list = new ArrayList<>();
		File file = new File(realPath);
		if (file.exists() == false) {
			file.mkdirs();
		}
		while (iterator.hasNext()) {
			multipartFile = multipartRequest.getFile(iterator.next());
			if (multipartFile.isEmpty() == false) {
				// 업로드한 파일의 이름 구하기
				originalFileName = multipartFile.getOriginalFilename();
				// 업로드한 파일의 확장자만 구하기
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				// 저장용 파일 이름 만들기
				storedFileName = UUID.randomUUID().toString().replaceAll("-", "") + originalFileExtension;
				file = new File(realPath + storedFileName);
				// 파일로 저장
				multipartFile.transferTo(file);
				// DB 저장용 데이터 Model 담아서 필요한 서비스로 보내기
				AttachFileModel fileModel = new AttachFileModel();
				if (multipartFile.getName().equals("mainImage")) {
					fileModel.setF_jtkey(uploadFile.get(0).getF_jtkey());
					fileModel.setF_ogname(originalFileName);
					fileModel.setF_svname(storedFileName);
					fileModel.setF_size(multipartFile.getSize());
					fileModel.setF_jtname("G");
					fileModel.setF_jtkey(g_id);
					list.add(fileModel);
				}
			}
		}
		return list;
	}

}
