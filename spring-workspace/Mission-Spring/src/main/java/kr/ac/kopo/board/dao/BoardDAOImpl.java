package kr.ac.kopo.board.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.board.vo.BoardVO;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public List<BoardVO> selectAll() {
		List<BoardVO> list = sqlSession.selectList("board.dao.BoardDAO.selectAll");
		return list;
	}
	@Override
	public void insert(BoardVO board) {
		
	}
	@Override
	public BoardVO selectByNo(int no) {
		BoardVO board = sqlSession.selectOne("board.dao.BoardDAO.selectByNo", no);
		return board;
	}
	@Override
	public void incrementReplyCnt(int no) {
		sqlSession.update("board.dao.BoardDAO.incrementReplyCnt", no);
	}
	@Override
	public void reduceReplyCnt(int no) {
		sqlSession.update("board.dao.BoardDAO.reduceReplyCnt", no);
		
	}
	
	
}
