package kr.ac.kopo.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import kr.ac.kopo.MyConfig;
import kr.ac.kopo.vo.BoardVO;

public class BoardDAO {

	private SqlSession session;
	
	public BoardDAO() {
		this.session = new MyConfig().getInstance();
		System.out.println(session);
	}
	
	public void work() {
		
//		insert();
//		select();
//		selectOne();
//		selectWhere();
//		selectWhere2();
//		selectNos();
//		selectMap();
		selectMap2();
	}
	
	@Test
	private void selectMap2() {
		// 49번 게시물 조회 
		Map<String, Object> map = session.selectOne("dao.BoardDAO.selectMap2", 49);
		Set<String> keys = map.keySet();
		for(String key : keys) {
			System.out.println(key + " : " + map.get(key));
		}
		
	}
	private void selectMap() {
		// 제목이 '삽입연습...', 작성자가 'yngie' 인 게시물 조회
		Map<String, String> map = new HashMap<>();
		map.put("title", "삽입연습...");
		map.put("writer", "yngie");
		
		List<BoardVO> list = session.selectList("dao.BoardDAO.selectMap", map);
		for(BoardVO board : list) {
			System.out.println(board);
		}
	}
	
	private void selectNos() {
		// nos 에 속하는 게시물을 조회하고싶다. 
		int[] nos = {1, 3, 43, 39, 5};
		
		// 멤버변수에 nos 를 추가해 set 해주고 파라미터로 넘겨줌 
		BoardVO vo = new BoardVO();
		vo.setNos(nos);
		
//		List<BoardVO> list = session.selectList("dao.BoardDAO.selectNos", vo);
//		List<BoardVO> list = session.selectList("dao.BoardDAO.selectNos2", nos);
		List<BoardVO> list = session.selectList("dao.BoardDAO.selectNos3", nos);
		for(BoardVO board : list) {
			System.out.println(board);
		}
	}
	
	private void selectWhere2() {
		// 제목이 '삽입'으로 시작하는 게시글 조회 
		BoardVO vo = new BoardVO();
		vo.setTitle("삽입");
		
		List<BoardVO> list = session.selectList("dao.BoardDAO.selectWhere2", vo);
		for(BoardVO board : list) {
			System.out.println(board);
		}
	}
	private void selectWhere() {
		BoardVO vo = new BoardVO();
		// 방법1. 제목이 "삽입연습...", 작성자가 "yngie"인 게시물 조회
//		vo.setTitle("삽입연습...");
//		vo.setWriter("yngie");
		
		// 방법2. 작성자가 "yngie"인 게시물 조회 
		vo.setWriter("yngie");
		
		// 방법3. 제목이 "삽입연습..." 인 게시물 조회 
//		vo.setTitle("삽입연습...");
		
		List<BoardVO> list = session.selectList("dao.BoardDAO.selectWhere", vo);
		for(BoardVO board : list) {
			System.out.println(board);
		}
	}
	private void selectOne () {
		// 50번글 조회 
		// 직접 글 번호 넘겨주기 
//		BoardVO board = session.selectOne("dao.BoardDAO.selectByNo", 50);
		
		// 글 번호를 vo 객체에 묶어 넘겨주기 
		BoardVO vo = new BoardVO();
		vo.setNo(50);
//		BoardVO board = session.selectOne("dao.BoardDAO.selectByNo2", vo);
		BoardVO board = session.selectOne("dao.BoardDAO.selectByNo3", vo);
		
		System.out.println(board);
	}
	
	private void select() {
		List<BoardVO> list = session.selectList("dao.BoardDAO.selectBoard"); // 명시적 형변환 안해도 됨. resultType을 BoardVO로 만들어놨기 떄문.       
		
		for(BoardVO board : list) {
			System.out.println(board);
		}
	}
	
	private void insert() {
		
		BoardVO board = new BoardVO();
		board.setTitle("삽입연습...");
		board.setWriter("yngie");
		board.setContent("VO이용하여 삽입...");
		
		session.insert("dao.BoardDAO.insertBoard", board);
		session.commit();
		
		System.out.println("삽입완료...");
	}
}
