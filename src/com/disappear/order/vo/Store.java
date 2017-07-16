package com.disappear.order.vo;

import org.springframework.web.multipart.MultipartFile;

public class Store {

    private String seq;
    private String writer;
    private String storeNumber;
    private String storeName;
    private String address;
    private String phoneNumber;
    private String images;
    private String regDate;
    private String storeType;
    private MultipartFile imgFile;

    public Store() {
    }

    public Store(String seq, String writer, String storeNumber, String storeName, String address, String phoneNumber, String images, String regDate) {
        super();
        this.seq = seq;
        this.writer = writer;
        this.storeNumber = storeNumber;
        this.storeName = storeName;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.images = images;
        this.regDate = regDate;
    }

    public String getSeq() {
        return seq;
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getStoreNumber() {
        return storeNumber;
    }

    public void setStoreNumber(String storeNumber) {
        this.storeNumber = storeNumber;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
    

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public MultipartFile getImgFile() {
        return imgFile;
    }

    public void setImgFile(MultipartFile imgFile) {
        this.imgFile = imgFile;
    }

    @Override
    public String toString() {
        return "Store [seq=" + seq + ", writer=" + writer + ", storeNumber=" + storeNumber + ", storeName=" + storeName + ", address=" + address + ", phoneNumber=" + phoneNumber + ", images=" + images
                + ", regDate=" + regDate + "]";
    }

}
