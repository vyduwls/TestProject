package com.disappear.order.vo;

import org.springframework.web.multipart.MultipartFile;

public class Menus {

    private String mseq;
    private String sseq;
    private String category;
    private String menuname;
    private String engmenuname;
    private String menuinfo;
    private int price;
    private String img;
    private MultipartFile imgFile;

    public String getMseq() {
        return mseq;
    }

    public void setMseq(String mseq) {
        this.mseq = mseq;
    }

    public String getSseq() {
        return sseq;
    }

    public void setSseq(String sseq) {
        this.sseq = sseq;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getMenuname() {
        return menuname;
    }

    public void setMenuname(String menuname) {
        this.menuname = menuname;
    }

    public String getEngmenuname() {
        return engmenuname;
    }

    public void setEngmenuname(String engmenuname) {
        this.engmenuname = engmenuname;
    }

    public String getMenuinfo() {
        return menuinfo;
    }

    public void setMenuinfo(String menuinfo) {
        this.menuinfo = menuinfo;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public MultipartFile getImgFile() {
        return imgFile;
    }

    public void setImgFile(MultipartFile imgFile) {
        this.imgFile = imgFile;
    }

}
