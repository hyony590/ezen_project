package toystory.utils.file;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data

public class AttachFileModel {

	   private int f_num;
	   private String f_jtname;
	   private int f_jtkey;
	   private String f_ogname;
	   private String f_svname;
	   private long f_size;
	   private Date f_regdate;
	   private String f_del_yn;
	   private String f_main_yn;
	   
	   
}