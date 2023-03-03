/* 작성자: 강승현
   작성일: 22/11/25
   작성용도: 댓글관련 메소드들을 정의한 mapper
 */
package toystory.common.comment.mapper;

import toystory.common.comment.model.CommentModel;

public interface CommentMapper {
	
	public int commentRegister(CommentModel vo);

}
