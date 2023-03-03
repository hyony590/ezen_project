/*작성자 : 남재욱, 이효원
 *작성일 : 2022.11.23
 *용도 : 파일 테이블의 컬럼과 일치하는 모델
*/

package toystory.common.file.model;

import java.util.Date;

import lombok.Data;

@Data
public class FileModel {
   private int f_num;
   private String f_jtname;
   private int f_jtkey;
   private String f_ogname;
   private String f_svname;
   private int f_size;
   private Date f_regdate;
   private String f_del_yn;
   private String f_is_new;
   
}