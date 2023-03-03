/*작성자 : 장한원, 강승현
 *작성일 : 2022.12.22
 *용도 : 상품 상세보기에서 리뷰/문의에 대한 페이징
*/
package toystory.utils.page;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Criteria2 {
	
		private int pageNum; //페이지 번호
		private int amount; //한 페이지 당 보여줄 데이터 수
		
		
		// 한 페이지에서 보여줄 데이터 개수 : 5
		public Criteria2() {
			this(1, 5);
		}
		
		// 변수에 저장
		public Criteria2(int pageNum, int amount) {
			this.pageNum = pageNum;
			this.amount = amount;
		}
		
		// Uri 추가 메소드
		public String getListLink() {
			UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
					.queryParam("RpageNum", this.pageNum);
			return builder.toUriString();
		}
}
