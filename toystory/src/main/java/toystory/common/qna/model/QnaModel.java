/*
작성자: 강승현
작성일: 22/11/25
용도: 문의 모델
*/
package toystory.common.qna.model;

import java.util.Date;

import lombok.Data;


@Data
public class QnaModel {

	private int q_num;
	private String q_title;
	private String q_content;
	private int g_id;
	private int m_num;
	private Date q_regdate;
	private String q_del_yn;
	private String q_comment; //댓글
	private String m_name; //작성자
	private String g_name; //상품명
	
}
