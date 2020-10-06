package kr.ac.kopo.reply.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.board.dao.BoardDAO;
import kr.ac.kopo.reply.dao.ReplyDAO;
import kr.ac.kopo.reply.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyDAO replyDao;
	@Autowired
	private BoardDAO boardDao;
	
	/*
	 * 댓글 추가
	 * 1. DB에 t_board에 해당 레코드의 댓글 카운트 컬럼값을 1증가
	 * 2. DB에 t_reply에 새로운 댓글 추가
	 */
	@Transactional
	@Override
	public void insertReply(ReplyVO replyVO) {
		boardDao.incrementReplyCnt(replyVO.getBoardNo());
		replyDao.insert(replyVO);
	}

	@Override
	public List<ReplyVO> selectAllByBoardNo(int boardNo) {
		
		List<ReplyVO> replyList = replyDao.selectAll(boardNo);
		
		return replyList;
	}

	/*
	 * 0. DB에서 삭제할 댓글의 게시물 번호 조회(t_reply)
	 * 1. DB에서 해당 댓글 삭제(t_reply)
	 * 2. DB에서 해당 게시물의 댓글 카운트 감소(t_board)
	 */
	@Transactional
	@Override
	public void removeReply(int replyNo) {
		int boardNo = replyDao.selectBoardNo(replyNo);
		replyDao.delete(replyNo);
		boardDao.reduceReplyCnt(boardNo);
	}

	/*
	 * 1. DB에서 해당 댓글 삭제(t_reply)
	 * 2. DB에서 해당 게시물의 댓글 카운트 감소(t_board) 
	 */
	@Transactional
	@Override
	public void removeReply(ReplyVO replyVO) {
		replyDao.delete(replyVO.getNo());
		boardDao.reduceReplyCnt(replyVO.getBoardNo());
	}

}







