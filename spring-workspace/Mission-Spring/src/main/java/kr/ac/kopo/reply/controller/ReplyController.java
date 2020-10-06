package kr.ac.kopo.reply.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.ac.kopo.reply.service.ReplyService;
import kr.ac.kopo.reply.vo.ReplyVO;

@CrossOrigin
@RestController
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@PostMapping("/reply")
	public void addReply(ReplyVO replyVO) {
		replyService.insertReply(replyVO);
	}
	
	@GetMapping("/reply/{boardNo}")
	public List<ReplyVO> getList(@PathVariable("boardNo") int boardNo) {
		
		List<ReplyVO> replyList = replyService.selectAllByBoardNo(boardNo);
		
		return replyList;
	}
	
//	@RequestMapping(value="/reply/{replyNo}", method=RequestMethod.DELETE)
	@DeleteMapping("/reply/{replyNo}")
	public void delteteReply(@PathVariable("replyNo") int replyNo) {
//		System.out.println("삭제할 댓글 번호 : " + replyNo);
		replyService.removeReply(replyNo);
	}

	@DeleteMapping("/reply/{replyNo}/{boardNo}")
	public void deleteReply(@PathVariable("replyNo") int replyNo
							, @PathVariable("boardNo") int boardNo) {
		ReplyVO replyVO = new ReplyVO();
		replyVO.setNo(replyNo);
		replyVO.setBoardNo(boardNo);
		
		replyService.removeReply(replyVO);
	}
}












