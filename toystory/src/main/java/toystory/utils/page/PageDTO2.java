/*작성자 : 장한원, 강승현
 *작성일 : 2022.12.22
 *용도 : 상품 상세보기에서 리뷰/문의에 대한 페이징
*/
package toystory.utils.page;

import lombok.Data;

@Data
public class PageDTO2 {
   
   private int startPage; //시작페이지
   private int endPage; //끝페이지
   private boolean prev, next; //이전,다음
   private int total; //총 데이터 개수
   private Criteria2 cri; // Criteria 선언
   private String sort; //정렬
   
   public PageDTO2(Criteria2 cri, int total) { //pageMaker
      this.cri = cri;
      this.total = total; //전체 페이지 
      this.endPage = (int)(Math.ceil(cri.getPageNum() / 5.0)) * 5; //페이지 끝 번호
      this.startPage = this.endPage -4; //페이지 시작 번호
      int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount())); //진짜 끝 페이지
      if(realEnd < this.endPage) {
         this.endPage = realEnd; //끝페이지가 진짜끝페이지보다 크다면, 끝페이지는 진짜끝페이지가 되야함
      }
      
      this.prev = this.startPage > 1; //이전
      this.next = this.endPage < realEnd; //다음
   }
}