/* 작성자: 강승현
   작성일: 22/11/25
   용도: reviewModel
 */

package toystory.common.review.model;

import java.util.Date;

import lombok.Data;
import toystory.utils.file.AttachFileModel;

@Data
public class ReviewModel extends AttachFileModel{

	private int r_num;
	private String r_title;
	private String r_content;
	private int o_num;
	private int m_num;
	private Date r_regdate;
	private String r_del_yn;
	private String r_answer_yn;
	private String r_star;
	private int rownum;
	private int comment_yn;
	private String type;
	private String m_name;
	private String g_name;
	private String r_comment;
	private int g_id;
	private String o_option;
	private int o_count;

	
	

}
