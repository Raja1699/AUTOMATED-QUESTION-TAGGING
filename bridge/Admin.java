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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.search.spell.Dictionary;
import org.apache.lucene.search.spell.JaroWinklerDistance;
import org.apache.lucene.search.spell.NGramDistance;
import org.apache.lucene.search.spell.PlainTextDictionary;
import org.apache.lucene.search.spell.SpellChecker;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;

import com.indexer.Normalization;
import com.indexer.PdfGlobalSearchDelegate;
import com.indexer.PdfGlobalSearchService;
import com.opensymphony.xwork2.ActionSupport;
import edu.stanford.nlp.ling.HasWord;
import edu.stanford.nlp.ling.Sentence;
import edu.stanford.nlp.ling.TaggedWord;
import edu.stanford.nlp.tagger.maxent.MaxentTagger;

public class Admin extends ActionSupport implements SessionAware,CommonInter
{
	SpellChecker spellChecker;
	String csvpath="webapps/bridgingfiles/CSV";
	String respath="webapps/bridgingfiles/ResourcesPdf";
	String serpath="webapps/Bridging/Ser";
	String contpath="webapps/Bridging";
	SessionMap sessionmap;
	SimpleDateFormat sfd=new SimpleDateFormat("MM/dd/yy HH:mm:ss");
	
	public void setSession(Map map)
	{
		sessionmap=(SessionMap<String,String>) map;
	}
	
	public String execute()
	{
		String status="success";
		try
		{
			Normalization norm=new Normalization();
			Calendar cal=Calendar.getInstance();
			Timestamp tttf=new Timestamp(new Date(sfd.format(cal.getTime())).getTime());
			cal.add(Calendar.MONTH,-7);
			Timestamp tttt=new Timestamp(new Date(sfd.format(cal.getTime())).getTime());
			FileOutputStream fout=null;
			
			FileReader fr=new FileReader(contpath+"/names.txt");
			BufferedReader br=new BufferedReader(fr);
			String strline="";
			while((strline=br.readLine())!=null)
			{
				vecnames.add(strline.trim());
			}
			
			File fch=new File(serpath+"/datequesid.csv");
			fch.delete();
			File f=new File(csvpath);
			File farr[]=f.listFiles();
			StringBuffer sb=new StringBuffer();
			int count=0;
			for(int i=0;i<farr.length;i++)
			{
				strline="";
				System.out.println(farr[i].getAbsolutePath());
				fr=new FileReader(farr[i].getAbsolutePath());
				br=new BufferedReader(fr);
				int cou=0;
				while((strline=br.readLine())!=null)
				{
					if(cou>=2)
					{
						count++;
						long diff = tttt.getTime() - tttf.getTime() + 1;
						Date d=new Date(tttf.getTime() + (long) (Math.random() * diff));
						String datestring=sfd.format(d);
						
						String spl[]=strline.split("\\,");
						Vector v=new Vector();
						v.add(spl[2].trim());
						v.add(spl[3].trim());
						v.add(spl[4].trim());						
//						String val=v.toString().replace("[","").replace("]","").replace("*",",").trim();
						String val=v.get(0).toString()+","+v.get(1).toString().replace("[","").replace("]","").replace("*",",").trim();
						String domainnam=norm.normalize(val);
						String vecval=spl[2].trim()+"&"+spl[3].trim()+"&"+spl[4].trim();
						linkquesallvecmap.put(domainnam+count,v);
						linkquesmap.put(domainnam+count,spl[2].trim()+"&"+spl[3].trim());							
						
						if(!veccatques.contains(domainnam.trim()))
						{
							veccatques.add(domainnam.trim());
						}
						
						if(!fch.exists())
						{
							File fser=new File(serpath);
							fser.mkdir();
							fout=new FileOutputStream(serpath+"/datequesid.csv");
					        sb.append(("date,time,uid,domainnameid,value\n"));
				        }
						sb.append((datestring.split(" ")[0]+","+datestring.split(" ")[1]+","+vecnames.get(new Random().nextInt(vecnames.size()))+","+domainnam+count+","+vecval+"\n"));
					}
					cou++;
				}
			}
			fout.write(sb.toString().getBytes());
			fout.close();
			
			fr=new FileReader(serpath+"/datequesid.csv");
			br=new BufferedReader(fr);
			strline="";
			while((strline=br.readLine())!=null)
			{
				if(!strline.startsWith("date,time"))
				{
					String spl[]=strline.split(",");
					linkquestimeallmap.put(spl[3],spl[0]+"="+spl[2]+"="+spl[4]);
				}
			}
			System.out.println("Csv Process Finished...");
			System.out.println("Csv Process Finished... "+linkquesmap.size());
			addActionMessage("Csv Process Finished...");
			norm.api.Close();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String resPdf()
	{
		String status="success";
		try
		{
			String servers=commonProp();
			final String spl[]=servers.split("\\,");
			for(int i=0;i<spl.length;i++)
			{
				if(!spl[i].equals("") && spl[i].contains(":"))
				{
					URL baseUrl = com.indexer.PdfGlobalSearchService.class.getResource(".");
					URL url;
					url = new URL(baseUrl,"http://"+spl[i].trim()+"/BridgeGlobalWebServer/PdfGlobalSearchPort?wsdl");
					PdfGlobalSearchService readservice=new PdfGlobalSearchService(url);
					PdfGlobalSearchDelegate readdele=readservice.getPdfGlobalSearchPort();
					readdele.pdfindex();					
				}
			}
			System.out.println("PDF Indexing Finished...");
			addActionMessage("PDF Indexing Finished...");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String adminNlp()
	{
		String status="success";
		try
		{
			LinkedHashMap<String,Vector> linknlp=readSerNlp();
			if(linknlp.isEmpty())
			{
				LinkedHashMap<String,Vector> linknlpmap=new LinkedHashMap<String,Vector>();
				if(linkquesmap!=null)
				{
					if(!linkquesmap.isEmpty())
					{
						FileOutputStream fwr=new FileOutputStream("taggerpoutput.txt",true);
						loadDictionary();
						Iterator it=linkquesmap.keySet().iterator();
						while(it.hasNext())
						{
							String key=it.next().toString();
							String val=linkquesmap.get(key).replace("*",",").replace("&"," . ");
							
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
						    
						    Stemmer stemm=new Stemmer();
						    WordnetConnection wordnet=new WordnetConnection();
						    Pattern p = Pattern.compile("[^a-z0-9 ]", Pattern.CASE_INSENSITIVE);
							Matcher m;
							
							Vector vecnewstr=new Vector();
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
											m=p.matcher(wor);
									        boolean b=m.find();
								        	if(!b)
								        	{
								        		String checkd=performSpellCheck(wor);
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
//							        						vecnewstr.add(splword[wd].trim().toLowerCase());
										        		}
							        				}
							        			}
								        	}
										}
									}									
								}
							}
						    linknlpmap.put(key,vecnewstr);
						    fwr.write(sbuf.toString().getBytes());
						}
						fwr.close();
						writeSerNlp(linknlpmap);
						new UserSearch().writeMap(linknlpmap,"linknlp.txt");
						System.out.println("NLP Process Finished...");
						System.out.println("NLP Process Finished... "+linknlpmap.size());
					    addActionMessage("NLP Process Finished...");
					}
					else
					{
						System.out.println("Complete the CSV Process...");
						addActionMessage("Complete the CSV Process...");
					}
				}
				else
				{
					System.out.println("Complete the CSV Process...");
					addActionMessage("Complete the CSV Process...");
				}
			}
			else
			{
				System.out.println("NLP Process Finished...");
			    addActionMessage("NLP Process Finished...");
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String cleanSer()
	{
		String status="success";
		try
		{
			System.out.println("Cleaning Ser...");
			File f=new File("webapps/Bridging/Ser/questions.ser");
			f.delete();
			f=new File("webapps/Bridging/Ser/rev.txt");
			f.delete();
			f=new File("webapps/Bridging/Ser/datequesid.csv");
			f.delete();
			System.out.println("Finish Cleaning...");
		    addActionMessage("Finish Cleaning...");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public String cleanNlpSer()
	{
		String status="success";
		try
		{
			System.out.println("Cleaning Nlp Ser...");
			File f=new File("webapps/Bridging/Ser/linknlpmap.ser");
			f.delete();
			f=new File("webapps/bridgingfiles/CSV/Questions and Answers regarding Z.csv");
			f.delete();
			System.out.println("Finish Cleaning Nlp...");
		    addActionMessage("Finish Cleaning Nlp...");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return status;
	}
	
	public void loadDictionary()
	{
		try
		{
			File dir = new File("spellchecker/");
            Directory directory = FSDirectory.open(dir);
            spellChecker = new SpellChecker(directory);
            JaroWinklerDistance jw=new JaroWinklerDistance();
            NGramDistance ng=new NGramDistance();
            spellChecker.setStringDistance(jw);
            Dictionary dictionary = new PlainTextDictionary(new File("webapps/Bridging/fulldictionary.txt"));
            IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_4_9, null);
            spellChecker.indexDictionary(dictionary, config, false);
		}
		catch(Exception e)
		{
            e.printStackTrace();
        }
    }
	
	public String performSpellCheck(String word)
	{
		String str="";
		try
		{
			if(spellChecker.exist(word))
			{
				str=word.trim();
			}
			else
			{
	            String[] suggestions = spellChecker.suggestSimilar(word,3);
	            if(suggestions.length > 0)
	            {
	            	if(spellChecker.exist(suggestions[0]))
	    			{
	            		str=suggestions[0].trim();
	    				return str;
	    			}
	            }
	            if(suggestions.length > 1)
	            {
	            	if(spellChecker.exist(suggestions[1]))
	    			{
	    				str=suggestions[1].trim();
	    				return str;
	    			}
	            }
	            if(suggestions.length > 2)
	            {
	            	if(spellChecker.exist(suggestions[2]))
	    			{
	    				str=suggestions[2].trim();
	    				return str;
	    			}
	            }
			}
        }
		catch (Exception e)
		{
            e.printStackTrace();
        }
		return str;
    }	
	
	public LinkedHashMap<String,Vector> readSerNlp()
	{
		LinkedHashMap<String,Vector> linknlpmap=new LinkedHashMap<String, Vector>();
		try
		{
			File fch=new File(serpath+"/linknlpmap.ser");
			if(fch.exists())
			{
				FileInputStream fileIn =new FileInputStream(serpath+"/linknlpmap.ser");	
				ObjectInputStream in = new ObjectInputStream(fileIn);
				linknlpmap=(LinkedHashMap<String,Vector>)in.readObject();
				in.close();
				fileIn.close();
			}
		}
		catch (Exception e)
		{
            e.printStackTrace();
        }
		return linknlpmap;
	}
	
	public void writeSerNlp(LinkedHashMap<String,Vector> linknlpmap)
	{
		try
		{
			FileOutputStream fileOut=new FileOutputStream(serpath+"/linknlpmap.ser");
		    ObjectOutputStream out =new ObjectOutputStream(fileOut);
		    out.writeObject(linknlpmap);
		    out.close();
		    fileOut.close();
		}
		catch (Exception e)
		{
            e.printStackTrace();
        }
	}
	
	public String commonProp()
	{
		String servers="";
		try
		{
			String pat="webapps/Bridging/webserversys.properties";
			File f=new File(pat);
			if(f.isFile())
			{
				Properties prop=new Properties();
		        FileInputStream fis=new FileInputStream(pat);
		        prop.load(fis);
		        servers=prop.getProperty("servers").trim();
			}
			else
			{
				System.out.println("Webserversys property file!");
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return servers;
	}
}