package com.disappear.order.vo;

import org.springframework.web.multipart.MultipartFile;

public class Comment {

    private String cseq;
    private String coseq;
    private String cmid;
    private String content;
    private int likes;
    private String regDate;
    private String images;
    private MultipartFile imgFile;
    
    
    public String getImages() {
		return images;
	}

	public void setImages(String images) {
		this.images = images;
	}

	public MultipartFile getImgFile() {
		return imgFile;
	}

	public void setImgFile(MultipartFile imgFile) {
		this.imgFile = imgFile;
	}

	public String getCseq() {
        return cseq;
    }

    public void setCseq(String cseq) {
        this.cseq = cseq;
    }

    public String getCoseq() {
        return coseq;
    }

    public void setCoseq(String coseq) {
        this.coseq = coseq;
    }

    public String getCmid() {
        return cmid;
    }

    public void setCmid(String cmid) {
        this.cmid = cmid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getLikes() {
        return likes;
    }

    public void setLikes(int likes) {
        this.likes = likes;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

}
