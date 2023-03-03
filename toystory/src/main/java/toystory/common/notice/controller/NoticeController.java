package toystory.common.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;
import toystory.common.notice.service.NoticeService;
import toystory.utils.page.Criteria;
import toystory.utils.page.PageDTO;

@Controller
@AllArgsConstructor
public class NoticeController {

	private NoticeService noticeService;

	@GetMapping("/register")
	public void register() {

	}

	// 작성자 : 이효원, 남재욱 - 12.15 페이징(매개변수) 추가
		@GetMapping("/notice/list.toy")
		public String noticeList(Model model, Criteria cri) {
			
			int amount = cri.getAmount();
		    int pageNum = cri.getPageNum();
		    int total = noticeService.noticeListTotalCount();
			
			model.addAttribute("list", noticeService.selectNotice(amount, pageNum));
			model.addAttribute("pageMaker", new PageDTO(cri, total));
			
			
			return "notice/noticeList";
		}

	// 게시글 조회
	@GetMapping("/notice/detail.toy")
	public String noticeDetail(@RequestParam("n_num") int n_num, Model model) {

		model.addAttribute("detail", noticeService.noticeDetail(n_num));

		return "notice/noticeDetail";
	}

//   @RequestMapping(value = "/notice/detail.toy")
//   public String detail(@RequestParam("n_num") int n_num, NoticeModel noticeModel, Model model) {
//      
//     noticeService.upNoticeHitCount(noticeModel.getN_num());
//     
//     List<NoticeModel> list = noticeService.noticeDetail(noticeModel.getN_num());
//     
//      model.addAttribute("detail", list);
//     
//      
//      return "notice/noticeDetail";
//}
//}
}