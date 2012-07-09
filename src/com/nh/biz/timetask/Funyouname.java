package com.nh.biz.timetask;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class Funyouname {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		while(true){
			
			String name = receiveSomeCharByBufferedReader();
			int hashCode = name.hashCode();
			System.out.println(hashCode);
			System.out.println("your name score is "+ String.valueOf(hashCode % 100));
		}

	}
	
	public static String receiveSomeCharByBufferedReader(){
	    System.out.println("please Enter something:");
	   InputStreamReader in=null;
	   BufferedReader br=null;
	   in=new InputStreamReader(System.in);//该处的System.in是各InputSream类型的；
	   br=new BufferedReader(in);
	   String str="";
	   try {
	   str = br.readLine();//从输入流in中读入一行，并将读取的值赋值给字符串变量str

	   } catch (IOException e) {
	    e.printStackTrace();
	   }
	   return str;
	    }
	



}
