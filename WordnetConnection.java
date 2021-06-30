package com.bridge;


import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import edu.smu.tspell.wordnet.Synset;
import edu.smu.tspell.wordnet.WordNetDatabase;

public class WordnetConnection
{
	WordNetDatabase database;
	public WordnetConnection()
	{
		try
		{
			Properties prop=new Properties();
			FileInputStream fis=new FileInputStream(new File("webapps/Bridging/diction.properties"));
			prop.load(fis);
			String path=prop.getProperty("dictpath");
			System.setProperty("wordnet.database.dir",path.trim());
			database = WordNetDatabase.getFileInstance();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public String processWordnet(String word)
	{
		String str="";
		Synset[] synsets = database.getSynsets(word);
        
		if (synsets.length > 0)
		{
			for (int i = 0; i < synsets.length; i++)
			{
				String[] wordForms = synsets[i].getWordForms();
				for (int j = 0; j < wordForms.length; j++)
				{
					if(j==0)
					{
						str=wordForms[j];
					}
					else
					{
						if(!str.contains(wordForms[j]))
							str=str+"*"+wordForms[j];
					}
				}
			}
		}
		return str.trim();
	}
}