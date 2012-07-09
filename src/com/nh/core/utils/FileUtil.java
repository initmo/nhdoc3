package com.nh.core.utils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;


import javax.servlet.http.HttpServletResponse;


import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;




public class FileUtil {
	private static Logger log  = LoggerFactory.getLogger(FileUtil.class);

	public static String FILE ="FILE_" ;
	/** 
	 * @param filePath 
	 */
	public static void createDir(String filePath) {
		if (!new File(filePath).mkdirs())
			log.error("createDir  fail");
		else
			log.warn("createDir  success");
	}

	/**
	 * @param file
	 * @throws Exception
	 */
	public static void createFile(String file) throws Exception {
		File f = new File(file);
		if (f.exists()) {
			log.debug("file :" +file+ f.getAbsolutePath());
			log.debug("file :" +file + f.length());
		} else {
			f.getParentFile().mkdirs();
			f.createNewFile();
		}
	}

	
	
	/**
	 * @param className
	 * @return
	 */
	public static String getPackage(String className) {
		return className.substring(0, className.lastIndexOf("."));
	}
	
	/**
	 * @param className
	 * @return
	 */
	public static String getClassName(String className) {
		return className.substring( className.lastIndexOf(".")+1);
	}
	
	/**
	 * @param f
	 * @return
	 */
	public static String getExtension(File f) {
        return (f != null) ? getExtension(f.getName()) : "";
    }

    /**
     * @param filename
     * @return
     */
    public static String getExtension(String filename) {
        return getExtension(filename, "");
    }

    /**
     * @param filename
     * @param defExt
     * @return
     */
    public static String getExtension(String filename, String defExt) {
        if ((filename != null) && (filename.length() > 0)) {
            int i = filename.lastIndexOf('.');
            if ((i >-1) && (i < (filename.length() - 1))) {
                return filename.substring(i + 1);
            }
        }
        return defExt;
    }
    
    

    /**
     * @param filename
     * @return
     */
    public static String trimExtension(String filename) {
        if ((filename != null) && (filename.length() > 0)) {
            int i = filename.lastIndexOf('.');
            if ((i >-1) && (i < (filename.length()))) {
                return filename.substring(0, i);
            }
        }
        return filename;
    }
    
	/**
	 * @param fileName
	 * @return
	 */
    public static String renameFile(String prefix,String fileName) {
    	StringBuffer newFileName = new StringBuffer(prefix!=null?prefix:FILE);
		newFileName.append(DateUtil.format(new Date(), "yyyyMMddHHmmssms"))
				.append(".").append(getExtension(fileName));
		return newFileName.toString();
	}
    
    /**
	 * @param fileName
	 * @return
	 */
    public static String renameFile( String fileName) {
		return renameFile(null,fileName);
	}

	/**
	 * 
	 * @param file
	 * @return
	 */
	public static String renameFile(String prefix,File file) {
		StringBuffer newFileName = new StringBuffer(prefix!=null?prefix:FILE);
		newFileName.append(DateUtil.format(new Date(), "yyyyMMddHHmmssms"))
				.append(".").append(getExtension(file));
		return newFileName.toString();
	}



	
	
	public static void downLoad(String filePath,String filename, HttpServletResponse response){
		FileUtil.downLoad(new File(filePath),filename,response);
	}
	
	public static void downLoad(File file,String filename,HttpServletResponse response){
		try {
			if(!file.exists()){
				response.sendError(404,"File not found!");
				return;
			}
			BufferedInputStream br = new BufferedInputStream(new FileInputStream(file));
			byte[] buf = new byte[1024];
			int len = 0;
	
			String downloadname = StringUtils.isEmpty(filename) ? file.getName() : filename;
			response.reset(); 
			response.setContentType("application/x-msdownload"); 
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(downloadname, "UTF-8")); 
	
			OutputStream out = response.getOutputStream();
			while((len = br.read(buf)) >0)
			out.write(buf,0,len);
			br.close();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static InputStream getFileInputStream(String filePath){
		File diskFile = new File(filePath); 
		InputStream  is = null;
		try {
			is =  new FileInputStream(diskFile);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return is;
	}
	
	
	public static void main(String[] args) throws Exception {
		String className = "ims.tools.web.action.taskAction";
		log.debug(DateUtil.getNowTime());
		log.debug(renameFile("abc.txt.xls"));
//		System.out.println(fileName);
//		FileUtils.createFile("D:/"+ fileName);
	}
}
