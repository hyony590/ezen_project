/*
작성자: 강승현
작성일: 22/11/25
용도:댓글테이블과 일치한 컬럼들을 정리한 모델
*/
package toystory.common.comment.model;

import java.util.Date;

import lombok.Data;


@Data
public class CommentModel {

	private int c_num;
	private int p_num;
	private String c_type;
	private Date c_regdate;
	private String c_content;
}
