package com.disappear.order.vo;

public class NComment {
	private String nseq;
	private String seq;
	private String mid;
	private String comments;
	private int likeup;
	private int unlikeup;
	private String regdate;
	private int counts;
	
	public int getCounts() {
		return counts;
	}
	public void setCounts(int counts) {
		this.counts = counts;
	}
	public String getNseq() {
		return nseq;
	}
	public void setNseq(String nseq) {
		this.nseq = nseq;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public int getLikeup() {
		return likeup;
	}
	public void setLikeup(int likeup) {
		this.likeup = likeup;
	}
	public int getUnlikeup() {
		return unlikeup;
	}
	public void setUnlikeup(int unlikeup) {
		this.unlikeup = unlikeup;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}
