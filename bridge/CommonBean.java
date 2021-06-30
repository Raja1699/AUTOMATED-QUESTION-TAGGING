package com.bridge;

import java.util.LinkedHashMap;

public class CommonBean
{
	String ques,quessnip,answer,date,expertname,quesdomain,path,ans;
	public LinkedHashMap<String,String> linkmonthmap=new LinkedHashMap<String,String>();
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getQues() {
		return ques;
	}

	public void setQues(String ques) {
		this.ques = ques;
	}

	public String getQuessnip() {
		return quessnip;
	}

	public void setQuessnip(String quessnip) {
		this.quessnip = quessnip;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getExpertname() {
		return expertname;
	}

	public void setExpertname(String expertname) {
		this.expertname = expertname;
	}

	public String getQuesdomain() {
		return quesdomain;
	}

	public void setQuesdomain(String quesdomain) {
		this.quesdomain = quesdomain;
	}
	public void setsecond(String ans)
	{
		this.ans = ans;
	}
	
	public CommonBean()
	{
		linkmonthmap.put("01","Jan");
		linkmonthmap.put("02","Feb");
		linkmonthmap.put("03","Mar");
		linkmonthmap.put("04","Apr");
		linkmonthmap.put("05","May");
		linkmonthmap.put("06","Jun");
		linkmonthmap.put("07","July");
		linkmonthmap.put("08","Aug");
		linkmonthmap.put("09","Sep");
		linkmonthmap.put("10","Oct");
		linkmonthmap.put("11","Nov");
		linkmonthmap.put("12","Dec");
	}
}