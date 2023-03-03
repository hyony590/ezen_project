//작성자 : 이은정, 김용주
//작성일 : 2022/11/23
//용도 : basketmodel

package toystory.common.basket.model;

import lombok.Data;

@Data
public class BasketModel {
	
	private int b_num;
	private int g_id;
	private int m_num;
	private String b_option;
	private int b_count;
	private int b_price;
	private String b_temp;
	
	//장바구니 필요 변수
	private int f_num;
	private String g_name;
	private int g_price;
	private int totalPrice;
	private int g_sale;
	private String f_svname;
	private String m_email;

}
