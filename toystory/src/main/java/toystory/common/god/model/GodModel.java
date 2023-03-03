/*작성자 : 남재욱, 이효원
 *작성일 : 2022.11.25
 *용도 : 각 model들을 전부 담는 가장 큰model
*/
package toystory.common.god.model;

import toystory.common.basket.model.BasketModel;
import toystory.common.comment.model.CommentModel;
import toystory.common.file.model.FileModel;
import toystory.common.goods.model.GoodsModel;
import toystory.common.member.model.MemberModel;
import toystory.common.notice.model.NoticeModel;
import toystory.common.order.model.OrderModel;
import toystory.common.qna.model.QnaModel;
import toystory.common.review.model.ReviewModel;

public class GodModel {
   
   private MemberModel memberModel;
   private GoodsModel goodsModel;
   private FileModel fileModel;
   private OrderModel orderModel;
   private BasketModel basketModel;
   private NoticeModel noticeModel;
   private ReviewModel reviewModel;
   private CommentModel commentModel;
   private QnaModel qnaModel;
   
   
}