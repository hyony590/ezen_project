//작성자 : 이은정, 김용주
//작성일 : 2022/11/23
//용도 : ordermodel

package toystory.common.order.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import toystory.utils.file.AttachFileModel;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderModel extends AttachFileModel implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int f_num;
	private String g_name;
	private int o_num;
	private int g_id;
	private int m_num;
	private String m_email;
	private String o_option;
	private int o_count;
	private int o_price;
	private int o_tprice;
	private String o_name;
	private String o_mobile;
	private String o_tel;
	private String o_zipcode;
	private String o_address1;
	private String o_address2;
	private Date o_date;
	private String o_delivery;
	private String o_invoice;
	 private String o_dfeeYN; 
	private String o_pw;
	private String o_request;
	private String fullAddress;
	private String totalPrice;
	private String o_email;
	private String f_svname;
	

}

