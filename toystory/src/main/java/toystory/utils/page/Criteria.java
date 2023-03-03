/*작성자 : 남재욱, 이효원
 *작성일 : 2022.12.15
 *용도 : 페이징
*/
package toystory.utils.page;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString

public class Criteria {
	
		private int pageNum; //페이지 번호
		private int amount; //한 페이지 당 보여줄 데이터 수
		private String type;
		private String keyword;
		
		// 한 페이지에서 보여줄 데이터 개수 : 12
		public Criteria() {
			this(1, 12);
		}
		
		// 변수에 저장
		public Criteria(int pageNum, int amount) {
			this.pageNum = pageNum;
			this.amount = amount;
		}
		
		public String[] getTypeArr() {
			return type == null ? new String[] {} : type.split(""); 
		}
		
		// Uri 추가 메소드
		public String getListLink() {
			UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
			return builder.toUriString();
		}
}
