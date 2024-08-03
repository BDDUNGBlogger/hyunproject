package kr.co.soldesk.beans;

public class PageBean {
	
    // 최소 페이지 번호
	private int min;
	// 최대 페이지 번호
	private int max;
	// 이전 버튼의 페이지 번호
	private int prevPage;
	// 다음 버튼의 페이지 번호
	private int nextPage;
	// 전체 페이지 개수
	private int pageCnt;
	// 현재 페이지 번호
	private int currentPage;
	
	//contentCnt : 전체글 개수, currentPage: 현재 글 번호 
	//contentPageCnt:페이지당 글의 개수, paginationCnt: 페이지 버튼 개수
	public PageBean(int contentCnt, int currentPage, int contentPageCnt, int paginationCnt) {
		
		//현재 페이지 번호
		this.currentPage = currentPage;
		
		//전체 페이지 개수
		pageCnt = contentCnt / contentPageCnt;
		
		//533/10=53 ... 3 53+1=54
		if(contentCnt % contentPageCnt > 0) {
			pageCnt++;
		}//if
		
		/*
		 1~10(글 최소 번호1 부터 최대 번호 10) : 1
		 11~20 : 최소 시작 번호 11
		 21~30 : 최소 시작 번호 21
		 
		 // 데이터 베이스의 글 번호 범위 (0부터 시작)
		   0~9 : 0
		 10~19 : 10
		 20~29 : 20
		 
		 // 페이지 번호와 데이터베이스의 글 번호 범위를 맞추기 위해 계산
		   페이지 번호 1 : (1-1) * 10 = 0
		   페이지 번호 2 : (2-1) * 10 = 10
		   페이지 번호 3 : (3-1) * 10 = 20
		 
		 // +1을 적용하여 실제 글 번호 범위로 맞추기
		   페이지 번호 1 : 0 + 1 = 1 (글 번호 1부터 시작)
		   페이지 번호 2 : 10 + 1 = 11 (글 번호 11부터 시작)
		   페이지 번호 3 : 20 + 1 = 21 (글 번호 21부터 시작)
		 */
		
		min=((currentPage-1)/contentPageCnt)*contentPageCnt+1;
		max=min+paginationCnt -1; //1+10=11 -1
		
		//64개 => 6페이지(10개) 7페이지(4)
		if(max > pageCnt) {
			max = pageCnt;
		}
		prevPage=min-1;
		nextPage=max+1;
		
		//마지막 페이지를 넘어가지 않도록
		if(nextPage > pageCnt) {	
			nextPage=pageCnt;
		}
		
	}//pageBean
	
	public int getMin() {
		return min;
	}
	public int getMax() {
		return max;
	}
	public int getPrevPage() {
		return prevPage;
	}
	public int getNextPage() {
		return nextPage;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public int getCurrentPage() {
		return currentPage;
	}

}
