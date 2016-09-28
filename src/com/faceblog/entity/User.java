package com.faceblog.entity;

public class User {
	private String user_name;
	private int user_id=-1;
	private String user_pwd;
	private String user_questionid;
	private String user_question;
	private String user_answer;
	private String user_motto;
	private String user_job;
	private String user_homtown;
	private String user_tele;
	private String user_email;
	private String user_intro;
	private String user_icon;
	private String user_visitor;
	public String getUser_question() {
		return user_question;
	}

	public void setUser_question(String user_question) {
		this.user_question = user_question;
	}
	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_questionid() {
		return user_questionid;
	}

	public void setUser_questionid(String user_question) {
		this.user_questionid = user_question;
	}

	public String getUser_answer() {
		return user_answer;
	}

	public void setUser_answer(String user_answer) {
		this.user_answer = user_answer;
	}

	public String getUser_motto() {
		return user_motto;
	}

	public void setUser_motto(String user_motto) {
		this.user_motto = user_motto;
	}

	public String getUser_job() {
		return user_job;
	}

	public void setUser_job(String user_job) {
		this.user_job = user_job;
	}

	public String getUser_homtown() {
		return user_homtown;
	}

	public void setUser_homtown(String user_homtown) {
		this.user_homtown = user_homtown;
	}

	public String getUser_tele() {
		return user_tele;
	}

	public void setUser_tele(String user_tele) {
		this.user_tele = user_tele;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_intro() {
		return user_intro;
	}

	public void setUser_intro(String user_intro) {
		this.user_intro = user_intro;
	}

	public String getUser_icon() {
		return user_icon;
	}

	public void setUser_icon(String user_icon) {
		this.user_icon = user_icon;
	}
	public String toString() {
		return "my name is "+this.getUser_name()+"\nmy motto is "+this.getUser_motto() ;
	}

	public String getUser_visitor() {
		return user_visitor;
	}

	public void setUser_visitor(String user_visitor) {
		this.user_visitor = user_visitor;
	}

}
