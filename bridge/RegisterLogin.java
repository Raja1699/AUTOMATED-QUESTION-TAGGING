 package com.bridge;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.TreeSet;
import java.util.Vector;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

public class RegisterLogin extends ActionSupport implements SessionAware,CommonInter
{
	String username,password,conpass,mailid,mobno,city,radioreg,radiologin,expertid;
	String contpath="webapps/Bridging";
	SessionMap sessionmap;
	Vector vecques=new Vector();
	Vector vecquesanssnip=new Vector();
	
	public String getExpertid() {
		return expertid;
	}

	public void setExpertid(String expertid) {
		this.expertid = expertid;
	}

	public Vector getVecquesanssnip() {
		return vecquesanssnip;
	}

	public void setVecquesanssnip(Vector vecquesanssnip) {
		this.vecquesanssnip = vecquesanssnip;
	}

	public Vector getVecques() {
		return vecques;
	}

	public void setVecques(Vector vecques) {
		this.vecques = vecques;
	}

	public void setSession(Map map)
	{
		sessionmap=(SessionMap<String,String>) map;
	}
	
	public String getRadiologin() {
		return radiologin;
	}

	public void setRadiologin(String radiologin) {
		this.radiologin = radiologin;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConpass() {
		return conpass;
	}

	public void setConpass(String conpass) {
		this.conpass = conpass;
	}

	public String getMailid() {
		return mailid;
	}

	public void setMailid(String mailid) {
		this.mailid = mailid;
	}

	public String getMobno() {
		return mobno;
	}

	public void setMobno(String mobno) {
		this.mobno = mobno;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRadioreg() {
		return radioreg;
	}

	public void setRadioreg(String radioreg) {
		this.radioreg = radioreg;
	}

	public String execute()
	{
		String status="success";
		try
		{
			Vector v=new Vector();
			v.add("1");
			v.add("2");
			v.add("3");
			v.add("4");
			v.add("5");
			v.add("6");
			v.add("7");
			v.add("8");
			v.add("9");
			v.add("0");
			v.add("!");
			v.add("@");
			v.add("#");
			v.add("$");
			v.add("%");
			v.add("^");
			v.add("&");
			v.add("*");
			v.add("(");
			v.add(")");
			boolean bool=false;
			
			for(int i=0;i<v.size();i++)
			{
				if(password.contains(v.get(i).toString()))
				{
					bool=true;
					break;
				}
			}
			
			if(bool)
			{
				if(radioreg.equalsIgnoreCase("Expert"))
				{
					if(expertid.equalsIgnoreCase("doc123"))
					{
						bool=true;
					}
					else
					{
						bool=false;
					}
				}
				if(bool)
				{
					File f=new File(contpath+"/Ser");
					f.mkdir();
					LinkedHashMap<String,String> linkregmap=readRegSer();
					if(linkregmap.containsKey(username))
					{
						addActionError("Give a unique username!");
						status="error";
					}
					else
					{
						linkregmap.put(username,password+","+mailid+","+radioreg);
						writeRegSer(linkregmap);
						addActionError("Registered Successfully!");
					}
				}
				else
				{
					addActionError("Registration Failed!");
				}
			}
			else
			{
				addActionError("Passwords must contains atleast one special characters!");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	
	public String loginUser()
	{
		String status="success";
		try
		{
			if(radiologin.equals("admin"))
			{
				if(username.equals("admin") && password.equals("admin"))
				{
					status="successadmin";
				}
				else
				{
					addActionMessage("Login Failed!");
					status="error";
				}
			}else if(radiologin.equals("student")){
				if(!veccatques.isEmpty())
				{
					int noti1=0;
					LinkedHashMap<String,String> linkregmap1=readRegSer();
					if(linkregmap1.containsKey(username))
					{
						String passarr[]=linkregmap1.get(username).toString().split(",");
						if(passarr[0].equals(password) && passarr[2].equals(radiologin))
						{
							LinkedHashMap<String,String> quesmap=new UserSearch().readQuesSer();
								Iterator it=quesmap.keySet().iterator();
								while(it.hasNext())
								{
									String que=it.next().toString();
									String val=quesmap.get(que);
									String spl[]=val.split("\\&");
									if(spl[0].equals(username))
									{
										String spll[]=val.split("&");
										if(spll.length==4)
										{
											noti1=noti1+1;
										}
									}
								}
								
								Vector vv=(Vector)veccatques.clone();
								vecques=new Vector(new TreeSet(vv));
								status="successstudent";
							
							sessionmap.put("noti",noti1);
							sessionmap.put("user",username);
						}
						else
						{
							addActionMessage("Login Failed!");
							status="error";
						}
						}
						
					}
				}
			else if(radiologin.equals("expert")||radiologin.equals("user")){
			
				if(!veccatques.isEmpty()){
					int noti=0;
					LinkedHashMap<String,String> linkregmap=readRegSer();
					if(linkregmap.containsKey(username))
					{
						String passarr[]=linkregmap.get(username).toString().split(",");
						if(passarr[0].equals(password) && passarr[2].equals(radiologin))
						{
							if(radiologin.equals("expert"))
							{
								LinkedHashMap<String,String> quesmap=new UserSearch().readQuesSer();
								Iterator it=quesmap.keySet().iterator();
								while(it.hasNext())
								{
									String que=it.next().toString();
									String val=quesmap.get(que);
									String spl[]=val.split("&");
									if(spl.length==3)
									{
										CommonBean com=new CommonBean();
										com.setQues(que);
										com.setExpertname(spl[0]);
										com.setQuesdomain(spl[1]);
										com.setQuessnip(spl[2]);
										vecquesanssnip.add(com);
									}
								}
								status="successexpert";
							}
							else
							{
								LinkedHashMap<String,String> quesmap=new UserSearch().readQuesSer();
								Iterator it=quesmap.keySet().iterator();
								while(it.hasNext())
								{
									String que=it.next().toString();
									String val=quesmap.get(que);
									String spl[]=val.split("\\&");
									if(spl[0].equals(username))
									{
										String spll[]=val.split("&");
										if(spll.length==4)
										{
											noti=noti+1;
										}
									}
								}
								
								Vector vv=(Vector)veccatques.clone();
								vecques=new Vector(new TreeSet(vv));
								status="successuser";
							}
							sessionmap.put("noti",noti);
							sessionmap.put("user",username);
						}
						else
						{
							addActionMessage("Login Failed!");
							status="error";
						}
					}
					else
					{
						addActionMessage("Login Failed!");
						status="error";
					}
				}
				else
				{
					addActionMessage("Do Admin Process!");
					status="error";
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}	
	
	public String logOut()
	{
		String status="success";
		try
		{
			sessionmap.invalidate();
			addActionMessage("Logged Out!");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	//==================================Register - Login Ser===========================================
	
	public LinkedHashMap<String,String> readRegSer()
	{
		LinkedHashMap<String,String> linkregmap=new LinkedHashMap<String,String>();
		try
		{
			File fch=new File(contpath+"/Ser/register.ser");
			if(fch.exists())
			{
				FileInputStream fileIn =new FileInputStream(contpath+"/Ser/register.ser");	
				ObjectInputStream in = new ObjectInputStream(fileIn);
				linkregmap=(LinkedHashMap<String,String>)in.readObject();
				in.close();
				fileIn.close();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return linkregmap;
	}
	
	public void writeRegSer(LinkedHashMap<String,String> linkregmap)
	{
		try
		{
			FileOutputStream fileOut=new FileOutputStream(contpath+"/Ser/register.ser");
		    ObjectOutputStream out =new ObjectOutputStream(fileOut);
		    out.writeObject(linkregmap);
		    out.close();
		    fileOut.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}
