package kr.ac.kopo;

import static org.junit.Assert.assertNotNull;

import java.util.List;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.ac.kopo.board.dao.BoardDAO;
import kr.ac.kopo.board.service.BoardService;
import kr.ac.kopo.board.vo.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/spring/spring-mvc.xml"})
public class MyBatisTest {

	@Autowired
	private DataSource ds;
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private BoardDAO boardDAO;

	@Autowired
	private BoardService boardService;
	
	@Ignore
	@Test
	public void ds테스트() throws Exception {
		// ds가 널이 아니면 성공 
		assertNotNull(ds);
		// ds가 널이면 성공
//		assertNull(ds);
	}
	@Ignore
	@Test
	public void sqlSession테스트() throws Exception {
		assertNotNull(session);
	}
	@Ignore
	@Test
	public void 전체게시글조회테스트() throws Exception {
//		List<BoardVO> list = session.selectList("board.dao.BoardDAO.selectAll");
//		List<BoardVO> list = boardDAO.selectAll();
		List<BoardVO> list = boardService.selectAllBoard();
		for(BoardVO board : list) {
			System.out.println(board);
		}
	}
	
	@Test
	public void 게시판상세Test() throws Exception {
//		BoardVO board = boardDAO.selectByNo(50);
		BoardVO board = boardService.selectBoardByNo(50);
		System.out.println(board);
	}
}
