package kr.ac.kopo.reply.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.reply.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public void insert(ReplyVO replyVO) {
		sqlSession.insert("reply.dao.ReplyDAO.insert", replyVO);
	}

	@Override
	public List<ReplyVO> selectAll(int boardNo) {
		
		List<ReplyVO> replyList 
				= sqlSession.selectList("reply.dao.ReplyDAO.selectAll", boardNo);
		
		return replyList;
	}

	@Override
	public void delete(int replyNo) {
		
		sqlSession.delete("reply.dao.ReplyDAO.delete", replyNo);
		
	}

	@Override
	public int selectBoardNo(int replyNo) {
		int boardNo = sqlSession.selectOne("reply.dao.ReplyDAO.selectBoardNo", replyNo);
		return boardNo;
	}

}







