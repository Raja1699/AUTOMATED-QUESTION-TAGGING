package com.bridge;


import net.didion.jwnl.*;
import net.didion.jwnl.data.*;
import net.didion.jwnl.dictionary.*;

import java.io.*;
import java.util.Vector;
import java.util.HashMap;
import java.util.List;

public class Stemmer
{
	private int MaxWordLength = 50;
	private Dictionary dic;
	private MorphologicalProcessor morph;
	private boolean IsInitialized = false;
	public HashMap AllWords = null;
    
	public Stemmer()
	{
		AllWords = new HashMap();
		try
		{
			JWNL.initialize(new FileInputStream("webapps/Bridging/JWNLproperties.xml"));
			dic = Dictionary.getInstance();
			morph = dic.getMorphologicalProcessor();
			IsInitialized = true;
		}
	    catch(Exception e)
	    {
	    	e.printStackTrace();
	    }
	}
    
	public void Unload ()
	{
	    dic.close();
	    Dictionary.uninstall();
	    JWNL.shutdown();
	}

	public String StemWordWithWordNet ( String word )
	{
		if ( !IsInitialized )
			return word;
		if ( word == null ) return null;
		if ( morph == null ) morph = dic.getMorphologicalProcessor();

			IndexWord w;
		try
		{
			w = morph.lookupBaseForm( POS.VERB, word );
			//System.out.println("===== "+w);
			if ( w != null )
			{
				//System.out.println("1."+word);
				return w.getLemma().toString ();
			}
      
			w = morph.lookupBaseForm( POS.NOUN, word );
			if ( w != null )
			{
				//System.out.println("2."+word);
				return w.getLemma().toString();
	        }
			w = morph.lookupBaseForm( POS.ADJECTIVE, word );
			if ( w != null )
			{
				//System.out.println("3."+word);
				return w.getLemma().toString();
	        }
			w = morph.lookupBaseForm( POS.ADVERB, word );
			if( w != null )
			{
				//System.out.println("4."+word);
				return w.getLemma().toString();
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}

	public String Stem( String word )
	{
		// check if we already know the word
		String stemmedword = (String)AllWords.get( word );
		if(stemmedword != null)
			return stemmedword; // return it if we already know it

		// 	don't check words with digits in them
		//    if ( containsNumbers (word) == true )
		//      	stemmedword = null;
		else  // unknown word: try to stem it
			stemmedword = StemWordWithWordNet (word);

		if ( stemmedword != null )
		{
	      // word was recognized and stemmed with wordnet:
	      // add it to hashmap and return the stemmed word
			AllWords.put( word, stemmedword );
			return stemmedword;
		}
    // word could not be stemmed by wordnet,
    // thus it is no correct english word
    // just add it to the list of known words so
    // we won't have to look it up again
//    AllWords.put( word, word );
		return "";
	}

	public Vector Stem ( Vector words )
	{
		if ( !IsInitialized )
			return words;

		for ( int i = 0; i < words.size(); i++ )
		{
			words.set( i, Stem( (String)words.get( i ) ) );
		}
		return words;
	}


	public Vector processStem(String wor)
	{
		Vector v=new Vector();
		v.add(wor);
        Vector wrds=Stem(v);
		//System.out.println("out wrds + " +wrds );
		return wrds;
    }
}