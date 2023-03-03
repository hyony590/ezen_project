/*
작성자: 강승현
작성일: 22/11/25
용도: 공지사항 모델
*/
package toystory.common.notice.model;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import toystory.utils.file.AttachFileModel;

@Data
public class NoticeModel extends AttachFileModel {

	private int rownum;
	private int n_num;
	private String n_title;
	private Date n_regdate;
	private String n_content;
	private int n_count;
	private String n_del_yn;
	private String n_type;

}
