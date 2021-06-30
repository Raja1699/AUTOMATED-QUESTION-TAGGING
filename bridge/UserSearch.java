package com.bridge;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.URL;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

//import org.apache.lucene.index.IndexWriterConfig;
//import org.apache.lucene.search.spell.Dictionary;
//import org.apache.lucene.search.spell.JaroWinklerDistance;
//import org.apache.lucene.search.spell.NGramDistance;
//import org.apache.lucene.search.spell.PlainTextDictionary;
//import org.apache.lucene.search.spell.SpellChecker;
//import org.apache.lucene.store.Directory;
//import org.apache.lucene.store.FSDirectory;
//import org.apache.lucene.util.Version;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import chartapi.Main;

//import com.indexer.IndexItem;
import com.indexer.Normalization;
import com.indexer.PdfGlobalSearchDelegate;
import com.indexer.PdfGlobalSearchService;
//import com.indexer.PDFSearcher;
import com.opensymphony.xwork2.ActionSupport;

import edu.stanford.nlp.ling.HasWord;
import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.ling.TaggedWord;
import edu.stanford.nlp.tagger.maxent.MaxentTagger;

public class UserSearch extends ActionSupport implements SessionAware,CommonInter
{
	SessionMap sessionmap;
	static String query;
	String date;
	String csvpath="webapps/bridgingfiles/CSV";
	String respath="webapps/bridgingfiles/ResourcesPdf";
	String serpath="webapps/Bridging/Ser";
	String contpath="webapps/Bridging";
	String view,from,sort;	
	SimpleDateFormat sfd=new SimpleDateFormat("MM/dd/yy HH:mm:ss");
	Vector vecques=new Vector();
	Vector vecquesanssnip=new Vector();
	Vector vecglobal=new Vector();
	String domainques;
	String anshid;
	Admin ad=new Admin();
	public String getAnshid() {
		return anshid;
	}

	public void setAnshid(String anshid) {
		this.anshid = anshid;
	}

	public String getDomainques() {
		return domainques;
	}

	public void setDomainques(String domainques) {
		this.domainques = domainques;
	}

	Vector vecfinalaptans=new Vector();
	
	public Vector getVecfinalaptans() {
		return vecfinalaptans;
	}

	public void setVecfinalaptans(Vector vecfinalaptans) {
		this.vecfinalaptans = vecfinalaptans;
	}

	public Vector getVecglobal() {
		return vecglobal;
	}

	public void setVecglobal(Vector vecglobal) {
		this.vecglobal = vecglobal;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
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

	public String getView() {
		return view;
	}

	public void setView(String view) {
		this.view = view;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	public void setSession(Map map)
	{
		sessionmap=(SessionMap<String,String>) map;
	}
	
	public String execute()
	{
		String status="success";
		try
		{
			vecquesanssnipinter.clear();
			System.out.println("Query====>"+query);
			MaxentTagger tagger = new MaxentTagger(contpath+"/english-left3words-distsim.tagger");
			FileOutputStream fosrev=new FileOutputStream(serpath+"/rev.txt");
			fosrev.write(query.getBytes());
			fosrev.close();
			List<List<HasWord>> sentences = MaxentTagger.tokenizeText(new BufferedReader(new FileReader(serpath+"/rev.txt")));
			StringBuffer sbuf=new StringBuffer();
		    for(List<HasWord> sentence : sentences)
		    {
		    	ArrayList<TaggedWord> tSentence = tagger.tagSentence(sentence);
		    	sbuf.append(Sentence.listToString(tSentence,false).trim()).append("\n");
		    }
		    
		    System.out.println("NLP====>"+sbuf);
		    ad.loadDictionary();
		    Stemmer stemm=new Stemmer();
		    WordnetConnection wordnet=new WordnetConnection();
		    Pattern p = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
			Matcher m;
			
			HashSet vecnewstrset=new HashSet();
			HashSet hs=new HashSet();
			
		    String spl[]=sbuf.toString().split("\n");
		    for(int i=0;i<spl.length;i++)
		    {
		    	String splspace[]=spl[i].trim().split(" ");
				for(int k=0;k<splspace.length;k++)
				{
					if(splspace[k].split("\\/").length==2)
					{
						if(splspace[k].split("\\/")[1].trim().equals("NNP") || splspace[k].split("\\/")[1].trim().equals("NNS") || splspace[k].split("\\/")[1].trim().equals("NN") || splspace[k].split("\\/")[1].trim().equals("VB") || splspace[k].split("\\/")[1].trim().equals("JJ") || splspace[k].split("\\/")[1].trim().equals("VBD") || splspace[k].split("\\/")[1].trim().equals("VBG") || splspace[k].split("\\/")[1].trim().equals("VBN") || splspace[k].split("\\/")[1].trim().equals("VBP") || splspace[k].split("\\/")[1].trim().equals("VBZ"))
						{
							String wor=splspace[k].split("\\/")[0].trim();
							hs.add(wor);
							m=p.matcher(wor);
					        boolean b=m.find();
				        	if(!b)
				        	{
				        		String checkd=ad.performSpellCheck(wor);
			        			String sstr=wordnet.processWordnet(checkd);
			        			if(!sstr.trim().equals(""))
			        			{
			        				String splword[]=sstr.split("\\*");
			        				for(int wd=0;wd<splword.length;wd++)
			        				{
			        					if(!splword[wd].trim().equals("") && !vecnewstrset.contains(splword[wd].trim().toLowerCase()))
			        					{
			        						String stemmedwrds=stemm.processStem(splword[wd].trim()).toString().replace("[","").replace("]","").trim();
			        						if(!stemmedwrds.equals(""))
			        							vecnewstrset.add(stemmedwrds.trim().toLowerCase());
//			        						vecnewstrset.add(splword[wd].trim().toLowerCase());
			        					}
			        				}
			        			}
				        	}
						}
					}
				}
			}
		    
		    System.out.println("NLP Vector====>"+vecnewstrset);
		    Vector vecqueskeywrd=new Vector(hs);
		    Vector vecnewstr=new Vector(vecnewstrset);
		    
		    System.out.println("Original Words ==> "+vecqueskeywrd);
		    Normalization norm=new Normalization();
		    domainques=norm.normalize(query);
		    norm.api.Close();
		    //================================Local Learning================================
		  
		    LinkedHashMap<String,Vector> linkser=new Admin().readSerNlp();
		    LinkedHashMap<String,Integer> linksortvaluemap=new LinkedHashMap<String,Integer>(); 
		    System.out.println(" ================================== "+linkser.size());
		    System.out.println(" ================================== "+linkquesmap.size());
		    Iterator it=linkser.keySet().iterator();
		    while(it.hasNext())
		    {
		    	String key=it.next().toString();
		    	if(key.contains(domainques))
		    	{
		    		Vector vec=linkser.get(key);
			    	int cou=0;
			    	for(int i=0;i<vecnewstr.size();i++)
			    	{
			    		if(vec.contains(vecnewstr.get(i)))
			    		{
			    			cou=cou+1;
			    			linksortvaluemap.put(key,cou);
			    		}
			    	}
		    	}
		    }
		    
		    System.out.println("Sorted Map===>"+linksortvaluemap);
		    
		    LinkedList vcol=new LinkedList();
		    it=linksortvaluemap.keySet().iterator();
			while(it.hasNext())
			{
				String key=it.next().toString();
				int value=Integer.parseInt(linksortvaluemap.get(key).toString());
				vcol.add(value);
			}
			
			int ar[]=new int[vcol.size()];
			for(int i=0;i<vcol.size();i++)
			{
				ar[i]=(Integer)vcol.get(i);
			}
			int finarr[]=bubble_srt(ar,vcol.size());
			vcol.clear();
			for(int i=0;i<finarr.length;i++)
			{
				vcol.add(finarr[i]);
			}
			
			LinkedHashMap<String,Integer> linksortvaluemapnew=new LinkedHashMap<String,Integer>();
			System.out.println("vcol ===>"+vcol);
			for (int i = vcol.size() - 1; i >= 0; i--)
			{
				int value=Integer.parseInt(vcol.get(i).toString());
				Iterator it2=linksortvaluemap.keySet().iterator();
				while(it2.hasNext())
				{
					String key2=it2.next().toString();
					int value2=Integer.parseInt(linksortvaluemap.get(key2).toString());
					if(value2==value)
					{
						linksortvaluemapnew.put(key2,value2);
					}
				}
			}
			System.out.println("Sorted Map===>"+linksortvaluemapnew);
			LinkedHashMap<String,Integer> finallinksortvaluemap=new LinkedHashMap<String,Integer>();
			LinkedHashMap<String,Integer> relefinallinksortvaluemap=new LinkedHashMap<String,Integer>();
			
			int mapsize=10;
			if(linksortvaluemapnew.size()<10)
			{
				mapsize=linksortvaluemapnew.size();
			}
			int i=1;
			it=linksortvaluemapnew.keySet().iterator();
			while(it.hasNext())
			{
				String key2=it.next().toString();
				int value2=Integer.parseInt(linksortvaluemapnew.get(key2).toString());
				if(i<=mapsize)
				{
					i++;
					String content=linkquesmap.get(key2);
					int matchcount=0;
					for(int j=0;j<vecqueskeywrd.size();j++)
					{
						if(content.contains(vecqueskeywrd.get(j).toString()))
						{
							matchcount=matchcount+1;
						}
					}
					System.out.println(matchcount+"=="+vecqueskeywrd.size());
					if(matchcount>=(vecqueskeywrd.size()-1))
					{
						if(finallinksortvaluemap.size()<1)
						{
							finallinksortvaluemap.put(key2,value2);
							CommonBean com=new CommonBean();
							Vector vec=linkquesallvecmap.get(key2);
							com.setAnswer(vec.get(2).toString().replace("*",","));
							vecfinalaptans.add(com);
						}
						else
						{
							relefinallinksortvaluemap.put(key2,value2);							
							commonMet(key2);
						}
					}
					else
					{
						relefinallinksortvaluemap.put(key2,value2);						
						commonMet(key2);
					}
				}
			}
			
			System.out.println("Fibnal Vector===>"+finallinksortvaluemap);
			System.out.println();
			System.out.println("Final Relevant Vector===>"+relefinallinksortvaluemap);
		    
		    status="localsuccess";
		    
		    if(finallinksortvaluemap.isEmpty())
		    {
		    	if(!vecnewstr.isEmpty())
		    	{
				    String dat=new Date().toString();
				    spl=dat.split(" ");
				    date=spl[1]+" "+spl[2]+","+spl[5];
				    
				    String servers=new Admin().commonProp();
					spl=servers.split("\\,");
					ArrayList arralLi = null;
					for(i=0;i<spl.length;i++)
					{
						if(!spl[i].equals("") && spl[i].contains(":"))
						{
							URL baseUrl = com.indexer.PdfGlobalSearchService.class.getResource(".");
							URL url;
							url = new URL(baseUrl,"http://"+spl[i].trim()+"/BridgeGlobalWebServer/PdfGlobalSearchPort?wsdl");
							PdfGlobalSearchService readservice=new PdfGlobalSearchService(url);
							PdfGlobalSearchDelegate readdele=readservice.getPdfGlobalSearchPort();
							arralLi=(ArrayList)readdele.pdfSearch(vecnewstr.toString().replace("[","").replace("]",""));		
						}
					}
					for(int k=0;k<arralLi.size();k++)
					{
						String vv=arralLi.get(k).toString();
						String spp[]=vv.split("\\*");
		                CommonBean comb=new CommonBean();
		                System.out.println(spp[0].toString());
		    		    comb.setAnswer(spp[0].toString());
		    		    comb.setPath(spp[1].toString());
		    		    vecglobal.add(comb);
					}
				    status="globalsuccess";
		    	}
		    }
		    
		    if(finallinksortvaluemap.isEmpty() && vecglobal.isEmpty())
		    {
		    	LinkedHashMap<String,String> quesmap=new UserSearch().readQuesSer();
		    	quesmap.put(query,sessionmap.get("user")+"&"+domainques+"&"+query);	    	
		    	writeQuesSer(quesmap);
		    	status="globalsuccess";
		    	addActionMessage("Your Question has been Posted!");
		    }
		    //==============================================================================
		    vecques=(Vector)veccatques.clone();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String expertAns()
	{
		String status="success";
		try
		{
			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
	        Date date = new Date();
	        String spldat[]=dateFormat.format(date).toString().split(" ");
	        
			System.out.println("Expe===>"+anshid);
			String spl[]=anshid.split("=");// Ques and Answer
			LinkedHashMap<String,String> quesmap=readQuesSer();
			String vv=quesmap.get(spl[0]);
			System.out.println("VV check ----"+vv);
			String dom=vv.split("\\&")[1];
			System.out.println("dom check ----"+dom);
			vv=vv+"&"+spl[1]+"*"+sessionmap.get("user").toString()+"*"+spldat[0];
			quesmap.put(spl[0],vv);
			System.out.println("QUESMAP-----"+quesmap);
			
			
			
			
			
			writeQuesSer(quesmap);
			writeMap(quesmap,"questmap.txt");
			
			int cc=linkquesallvecmap.size()+1;			
			Vector v=new Vector();
			v.add(spl[0]);
			v.add(vv.split("\\&")[2]);
			v.add(spl[1]);
			linkquesallvecmap.put(dom+cc,v);
			
			System.out.println("linkquesallvecmap-------"+linkquesallvecmap);
			
			linkquesmap.put(dom+cc,spl[0].trim()+"&"+vv.split("\\&")[2].trim());
			System.out.println("linkuesmap-----------"+linkquesmap);
			if(!veccatques.contains((dom+cc).trim()))
			{
				veccatques.add((dom+cc).trim());
			}
			System.out.println("veccatques------------"+veccatques);
			Date dated=new Date();
			SimpleDateFormat sdf=new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
            String Ex_Date=sdf.format(dated);
            StringTokenizer stk=new StringTokenizer(Ex_Date);
            String Dd=stk.nextToken();
            String time=stk.nextToken();
			linkquestimeallmap.put((dom+cc).trim(),Dd+"="+vecnames.get(new Random().nextInt(vecnames.size()))+"="+(spl[0].trim()+"&"+vv.split("\\&")[2].trim()+"&"+spl[1]));
			
//			File f=new File(csvpath+"/Questions and Answers regarding "+vv.split("\\&")[1]+".csv");
			File f=new File(csvpath+"/Questions and Answers regarding Z.csv");
			if(f.exists())
			{
				FileReader fr=new FileReader(csvpath+"/Questions and Answers regarding Z.csv");
				BufferedReader br=new BufferedReader(fr);
				String strline="";
				String dum="";
				while((strline=br.readLine())!=null)
				{
					dum=strline;
				}
				int num=1;
				if(dum.trim().equals(""))
				{
				}
				else
				{
					num=Integer.parseInt(dum.split(",")[0].trim());
					num=num+1;
				}
				
				FileOutputStream fout=new FileOutputStream(csvpath+"/Questions and Answers regarding Z.csv",true);
				fout.write(("\n"+num+",Questions and Answers regarding "+vv.split("\\&")[1]+","+spl[0].replace(",","*")+","+vv.split("\\&")[2]+","+spl[1].replace(",","*")).getBytes());
				fout.close();
			}
			else
			{
				FileOutputStream fout=new FileOutputStream(csvpath+"/Questions and Answers regarding Z.csv");
				fout.write(("Index,Domain,Question,QuesSnippet,Answer\n\n1,Questions and Answers regarding "+vv.split("\\&")[1]+","+spl[0].replace(",","*")+","+vv.split("\\&")[2]+","+spl[1].replace(",","*")).getBytes());
				fout.close();
			}
			
			Iterator it=quesmap.keySet().iterator();
			while(it.hasNext())
			{
				String que=it.next().toString();
				String val=quesmap.get(que);
				spl=val.split("&");
				if(spl.length==2)
				{
					CommonBean com=new CommonBean();
					com.setQues(que);
					com.setExpertname(spl[0]);
					com.setQuesdomain(spl[1]);
					vecquesanssnip.add(com);
					System.out.println("vecquesanssnip-------"+vecquesanssnip);
				}
			}
			
			String val=linkquesmap.get((dom+cc)).replace("*",",").replace("&"," . ");			
			MaxentTagger tagger = new MaxentTagger(contpath+"/english-left3words-distsim.tagger");
			FileOutputStream fosrev=new FileOutputStream(serpath+"/rev.txt");
			fosrev.write(val.getBytes());
			fosrev.close();
			List<List<HasWord>> sentences = MaxentTagger.tokenizeText(new BufferedReader(new FileReader(serpath+"/rev.txt")));
			StringBuffer sbuf=new StringBuffer();
		    for(List<HasWord> sentence : sentences)
		    {
		    	ArrayList<TaggedWord> tSentence = tagger.tagSentence(sentence);
		    	sbuf.append(Sentence.listToString(tSentence,false).trim()).append("\n");
		    }
		    
		    ad.loadDictionary();
		    Stemmer stemm=new Stemmer();
		    WordnetConnection wordnet=new WordnetConnection();
		    Pattern p = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
			Matcher m;
			
			LinkedHashMap<String,Vector> linknlpmap=ad.readSerNlp();
			Vector vecnewstr=new Vector();
			spl=sbuf.toString().split("\n");
			for(int i=0;i<spl.length;i++)
		    {
		    	String splspace[]=spl[i].trim().split(" ");
				for(int k=0;k<splspace.length;k++)
				{
					if(splspace[k].split("\\/").length==2)
					{
						if(splspace[k].split("\\/")[1].trim().equals("NNP") || splspace[k].split("\\/")[1].trim().equals("NNS") || splspace[k].split("\\/")[1].trim().equals("NN") || splspace[k].split("\\/")[1].trim().equals("VB") || splspace[k].split("\\/")[1].trim().equals("JJ") || splspace[k].split("\\/")[1].trim().equals("VBD") || splspace[k].split("\\/")[1].trim().equals("VBG") || splspace[k].split("\\/")[1].trim().equals("VBN") || splspace[k].split("\\/")[1].trim().equals("VBP") || splspace[k].split("\\/")[1].trim().equals("VBZ"))
						{
							String wor=splspace[k].split("\\/")[0].trim();
							m=p.matcher(wor);
					        boolean b=m.find();
				        	if(!b)
				        	{
				        		String checkd=ad.performSpellCheck(wor);
				        		String sstr=wordnet.processWordnet(checkd);
			        			if(!sstr.trim().equals(""))
			        			{
			        				String splword[]=sstr.split("\\*");
			        				for(int wd=0;wd<splword.length;wd++)
			        				{
			        					if(!splword[wd].trim().equals("") && !vecnewstr.contains(splword[wd].trim().toLowerCase()))
			        					{
			        						String stemmedwrds=stemm.processStem(splword[wd].trim()).toString().replace("[","").replace("]","").trim();
			        						if(!stemmedwrds.equals(""))
			        						vecnewstr.add(stemmedwrds.trim().toLowerCase());
//			        						vecnewstr.add(splword[wd].trim().toLowerCase());
						        		}
			        				}
			        			}
				        	}
						}
					}
				}
			}
		    linknlpmap.put((dom+cc),vecnewstr);
		    
		    System.out.println("linknlpmap------------"+linknlpmap);
		    ad.writeSerNlp(linknlpmap);
		    writeMap(linknlpmap,"linknlp.txt");
		    System.out.println("NLP Process Finished...");
		    addActionMessage("NLP Process Finished...");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String userNotification()
	{
		String status="success";
		try
		{
			System.out.println("Coming");
			LinkedHashMap<String,String> quesmap=readQuesSer();
			Iterator it=quesmap.keySet().iterator();
			while(it.hasNext())
			{
				String que=it.next().toString();
				String val=quesmap.get(que);
				String spl[]=val.split("&");
				
				CommonBean comb=new CommonBean();
				comb.setQues(que);
				comb.setQuessnip(spl[2]);
				comb.setAnswer(spl[3].split("\\*")[0]);
				comb.setDate(spl[3].split("\\*")[2]);
				comb.setExpertname(spl[3].split("\\*")[1]);
		        comb.setQuesdomain(spl[1]);
		        vecquesanssnip.add(comb);
			}
			vecques=(Vector)veccatques.clone();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String notSatis()
	{
		String status="globalsuccess";
		try
		{
			Normalization norm=new Normalization();
		    domainques=norm.normalize(query);
		    norm.api.Close();
		    
			LinkedHashMap<String,String> quesmap=readQuesSer();
	    	quesmap.put(query,sessionmap.get("user")+"&"+domainques+"&"+anshid);	    	
	    	writeQuesSer(quesmap);
	    	writeMap(quesmap,"questmap.txt");
	    	System.out.println("Your Question has been Posted!");
	    	addActionMessage("Your Question has been Posted!");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String userAskQuery()
	{
		String status="success";
		try
		{
			String spl[]=anshid.split("\\=");
			Normalization norm=new Normalization();
		    domainques=norm.normalize(spl[0].trim());
		    norm.api.Close();
		    
			LinkedHashMap<String,String> quesmap=readQuesSer();
	    	quesmap.put(spl[0].trim(),sessionmap.get("user")+"&"+domainques+"&"+spl[1].trim());	    	
	    	writeQuesSer(quesmap);
	    	writeMap(quesmap,"questmap.txt");
	    	System.out.println("Your Question has been Posted!");
	    	addActionMessage("Your Question has been Posted!");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	
	public void writeQuesSer(LinkedHashMap<String,String> linkqu)
	{
		try
		{
			FileOutputStream fileOut=new FileOutputStream(serpath+"/questions.ser");
		    ObjectOutputStream out =new ObjectOutputStream(fileOut);
		    out.writeObject(linkqu);
		    out.close();
		    fileOut.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public LinkedHashMap<String,String> readQuesSer()
	{
		LinkedHashMap<String,String> linkregmap=new LinkedHashMap<String,String>();
		try
		{
			File fch=new File(serpath+"/questions.ser");
			if(fch.exists())
			{
				FileInputStream fileIn =new FileInputStream(serpath+"/questions.ser");	
				ObjectInputStream in = new ObjectInputStream(fileIn);
				linkregmap=(LinkedHashMap<String,String>)in.readObject();
				System.out.println("LINKREG MAP====="+linkregmap);
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
	
	public void commonMet(String key2)
	{
		try
		{
			Vector vec=linkquesallvecmap.get(key2.toString());
			CommonBean comb=new CommonBean();
			comb.setQues(vec.get(0).toString().replace("*",","));
			comb.setQuessnip(vec.get(1).toString().replace("*",","));
			comb.setAnswer(vec.get(2).toString().replace("*",","));
			String str=linkquestimeallmap.get(key2.toString());
			String spl[]=str.split("\\=");
			comb.setDate(comb.linkmonthmap.get(spl[0].split("\\/")[0])+" "+spl[0].split("\\/")[1]+","+spl[0].split("\\/")[2]);
			comb.setExpertname(spl[1]);
			String domainname= key2.toString().replaceAll("[^A-Za-z]","");
	        comb.setQuesdomain(domainname.trim());
	        vecquesanssnipinter.add(comb);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public String filterSearch()
	{
		String status="success";
		try
		{
			if(!veccatques.isEmpty())
			{
				int num=0;
				Calendar cal=Calendar.getInstance();
				Timestamp fromtime=new Timestamp(new Date(sfd.format(cal.getTime())).getTime());
				Timestamp totime=null;
				if(from.contains("all"))
				{
					num=6;
					cal.add(Calendar.MONTH,-num);
					totime=new Timestamp(new Date(sfd.format(cal.getTime())).getTime());
				}
				else
				{
					num=Integer.parseInt(from.split(" ")[1]);
					if(from.contains("Month"))
					{
						cal.add(Calendar.MONTH,-num);
						totime=new Timestamp(new Date(sfd.format(cal.getTime())).getTime());
					}
					else
					{
						cal.add(Calendar.WEEK_OF_YEAR,-num);
						totime=new Timestamp(new Date(sfd.format(cal.getTime())).getTime());
					}
				}
				
				Main mm=new Main(serpath+"/datequesid.csv");
				Vector v=mm.getTimeBetweenFilteredData(fromtime,totime,"domainnameid");
				vecques=(Vector)veccatques.clone();
				Vector vecans=new Vector();
				if(view.equalsIgnoreCase("all"))
				{
					vecans=(Vector)v.clone();
				}
				else
				{
					for(int i=0;i<v.size();i++)
					{
						if(v.get(i).toString().contains(view))
						{
							vecans.add(v.get(i));
						}
					}
				}
				
				for(int i=0;i<vecans.size();i++)
				{
					Vector vec=linkquesallvecmap.get(vecans.get(i).toString());
					CommonBean comb=new CommonBean();
					comb.setQues(vec.get(0).toString().replace("*",","));
					comb.setQuessnip(vec.get(1).toString().replace("*",","));
					comb.setAnswer(vec.get(2).toString().replace("*",","));
					String str=linkquestimeallmap.get(vecans.get(i).toString());
					String spl[]=str.split("\\=");
					comb.setDate(comb.linkmonthmap.get(spl[0].split("\\/")[0])+" "+spl[0].split("\\/")[1]+","+spl[0].split("\\/")[2]);
					comb.setExpertname(spl[1]);
					String domainname= vecans.get(i).toString().replaceAll("[^A-Za-z]","");
			        comb.setQuesdomain(domainname.trim());
					vecquesanssnip.add(comb);
				}
			}
			else
			{
				status="error";
				addActionMessage("Do Admin Process");
			}
			vecques=(Vector)veccatques.clone();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String userRelevantQues()
	{
		String status="success";
		try
		{
			vecquesanssnip=(Vector)vecquesanssnipinter.clone();
			vecques=(Vector)veccatques.clone();			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	
	public String userHome()
	{
		String status="success";
		try
		{
			int noti=0;
			LinkedHashMap<String,String> quesmap=new UserSearch().readQuesSer();
			Iterator it=quesmap.keySet().iterator();
			while(it.hasNext())
			{
				String que=it.next().toString();
				String val=quesmap.get(que);
				if(val.contains(sessionmap.get("user").toString()))
				{
					String spll[]=val.split("&");
					if(spll.length==4)
					{
						noti=noti+1;
					}
				}
			}
			sessionmap.put("noti",noti);
			vecques=(Vector)veccatques.clone();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public int[] bubble_srt( int a[], int n )
    {
		int t=0;
        int i, j=0;
        for(i = 0; i < n; i++)
        {
            for(j = 1; j< (n-i); j++)
            {
                if(a[j-1] > a[j])
                {
                    t = a[j-1];
                    a[j-1]=a[j];
                    a[j]=t;
                }
            }
        }
        return a;
    }
	
	//====================================Sample Writer========================
	public void writeMap(LinkedHashMap ppklinkmap,String filename)
	{
		try
		{
			FileOutputStream fos=new FileOutputStream(filename,true);
			Iterator iterr=ppklinkmap.keySet().iterator();
			while(iterr.hasNext())
			{
				String key=iterr.next().toString();
				String val=ppklinkmap.get(key).toString();
				fos.write((key+"  ===   "+val+"\n").getBytes());
			}
			fos.close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
}