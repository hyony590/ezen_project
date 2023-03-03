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
public class Criteria3 {
	
		private int QpageNum; //페이지 번호
		private int Qamount; //한 페이지 당 보여줄 데이터 수
		
		
		// 한 페이지에서 보여줄 데이터 개수 : 5
		public Criteria3() {
			this(1, 5);
		}
		
		// 변수에 저장
		public Criteria3(int pageNum, int amount) {
			this.QpageNum = pageNum;
			this.Qamount = amount;
		}
		
		// Uri 추가 메소드
		public String getListLink() {
			UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
					.queryParam("QpageNum", this.QpageNum);
			return builder.toUriString();
		}
}
