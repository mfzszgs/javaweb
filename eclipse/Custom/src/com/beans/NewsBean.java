package com.beans;

public class NewsBean {
	private int Id;
	private String title;
	private int authorId;
	private int publishId;
	private String keyWords;
	private String inputDate;//日期型的变量
	private int columnId;
	private int pictrueId;
	private String fullText;
	
	public int getID() {
		return Id;
	}
	public void setID(int Id) {
		this.Id = Id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getAuthorId() {
		return authorId;
	}
	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}
	public int getPublishId() {
		return publishId;
	}
	public void setPublishId(int publishId) {
		this.publishId = publishId;
	}
	public String getKeyWords() {
		return keyWords;
	}
	public void setKeyWords(String keyWords) {
		this.keyWords = keyWords;
	}
	public String getInputDate() {
		return inputDate;
	}
	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}
	public int getColumnId() {
		return columnId;
	}
	public void setColumnId(int columnId) {
		this.columnId = columnId;
	}
	public int getPictrueId() {
		return pictrueId;
	}
	public void setPictrueId(int pictrueId) {
		this.pictrueId = pictrueId;
	}
	public String getFullText() {
		return fullText;
	}
	public void setFullText(String fullText) {
		this.fullText = fullText;
	}
}
