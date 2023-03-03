/*작성자 : 남재욱, 이효원
 *작성일 : 2022.11.27
 *용도 : 파일 관련 메소드들을 정의한 Mapper
*/

package toystory.common.file.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import toystory.utils.file.AttachFileModel;

public interface FileMapper {

//	   public int fileModify(GodModel godModel);
	   
	   public void fileRegister(AttachFileModel model);
	   
	   public void mainCheck(int f_num);
	   
	   public List<AttachFileModel> imageList(Map<String, Object> map);
	   
	   public void mainUpdate(
			   @Param("f_ogname")String f_ogname, @Param("f_svname")String f_svname,
			   @Param("f_size")Long f_size, @Param("f_jtkey")int g_id);
	   
	   public void fileDelete(int f_num);
	   
	   public void fileAdd(AttachFileModel model);

	   
	   
	   
}