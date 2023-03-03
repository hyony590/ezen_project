/*작성자 : 남재욱, 이효원
 *작성일 : 2022.11.23
 *용도 : 상품 테이블의 컬럼과 일치하는 모델
*/
package toystory.common.goods.model;

import java.util.Date;

import lombok.Data;
import toystory.utils.file.AttachFileModel;

@Data
public class GoodsModel extends AttachFileModel {
	private int g_id;
	private String g_name;
	private String g_option;
	private int g_price;
	private int g_stock;
	private Date g_date;
	private String g_category;
	private String g_brand;
	private int g_sold;
	private int g_sale;
	private String g_bestnew;
	private String g_del_yn;

	private String keyword;

	@Override
	public String toString() {
		return "GoodsModel [g_id=" + g_id + ", g_name=" + g_name + ", g_option=" + g_option + ", g_price=" + g_price
				+ ", g_stock=" + g_stock + ", g_date=" + g_date + ", g_category=" + g_category + ", g_brand=" + g_brand
				+ ", g_sold=" + g_sold + ", g_sale=" + g_sale + ", g_bestnew=" + g_bestnew + ", g_del_yn=" + g_del_yn
				+ ", keyword=" + keyword + ", getF_num()=" + getF_num() + ", getF_jtname()=" + getF_jtname()
				+ ", getF_jtkey()=" + getF_jtkey() + ", getF_ogname()=" + getF_ogname() + ", getF_svname()="
				+ getF_svname() + ", getF_size()=" + getF_size() + ", getF_regdate()=" + getF_regdate()
				+ ", getF_del_yn()=" + getF_del_yn() + ", getF_main_yn()=" + getF_main_yn() + ", toString()="
				+ super.toString() + ", getClass()=" + getClass() + "]";
	}
	
	
	


	// 파일 모델

}