package com.nh.biz.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipOutputStream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.nh.biz.controller.ApprovalController;
import com.nh.biz.dao.impl.ResourceInfoDao;
import com.nh.biz.domain.ResourceInfo;
import com.nh.core.page.Pagination;
import com.nh.core.utils.FileUtil;

@Service
public class ResourceInfoService {

	private static Logger logger  = LoggerFactory.getLogger(ResourceInfoService.class);
	
	
	public ResourceInfo getResourceInfo(Integer id){
		return resourceInfoDao.findById(id);
	}
	

	public List<ResourceInfo> getResourceInfoList(Integer titleId,Integer pid,Integer deptId){
		return resourceInfoDao.findByMap(new String[]{"titleid","pid","departmentid"}, 
								  new Object[]{titleId,pid,deptId});
	}
	
	//��ȡ���˲ݸ��ĵ��б�
	public List<ResourceInfo> getMyActResourceInfoListByStatus(String userId, Integer approvalstatus) {
		return resourceInfoDao.findByMap(new String[]{"creatorid","approvalstatus"}, new Object[]{userId,approvalstatus});
	}
	
	//��ȡ�ļ����µ��ĵ��б�
	public List<ResourceInfo> getResourceInfoListByParent(ResourceInfo directory){
		if (directory.getIsdir()){
			return getResourceInfoList(directory.getTitleid(),directory.getId(),directory.getDepartmentid());
		}else{
			logger.error("{} is not a directory!",directory.getFilename());
			throw new ServiceException(directory.getFilename()+"is not a directory!");
		}
	}
	
	//����
	public  List<ResourceInfo> search(Map searchParamMap) {
		return resourceInfoDao.findByMap(searchParamMap);
	}
	
	//���� ��ҳ��ʾ
	public  Pagination<ResourceInfo> searchByPage(Map searchParamMap,int pageSize, int pageNo) {
		return resourceInfoDao.lgcPageQueryBy(searchParamMap, pageSize, pageNo);
	}
	
	//�����ļ���Ϣ
	public Integer insertResourceInfo(ResourceInfo resourceinfo) {
		try {
			return (Integer)resourceInfoDao.insert(resourceinfo);
		} catch (Exception e) {
			logger.error("�����ļ���Ϣ����", e);
			throw new ServiceException("�����ļ���Ϣ����",e);
		}
	}
	
	//�����ļ���Ϣ
	public void updateResourceInfo(ResourceInfo resourceinfo) {
		try {
			resourceInfoDao.update(resourceinfo);
		} catch (Exception e) {
			logger.error("�����ļ���Ϣ����", e);
			throw new ServiceException("�����ļ���Ϣ����",e);
		}
	}
	
	
	//�ϴ��ļ�
	@Transactional
	public Integer insertResource(ResourceInfo resourceinfo, MultipartFile file) {
		Integer id = insertResourceInfo(resourceinfo);
		storeFiletoDisk(resourceinfo, file);
		return id;
	}

   //�����ĵ�
	@Transactional
	public void updateResource(ResourceInfo resourceInfo, MultipartFile file) {
		updateResourceInfo(resourceInfo);
		storeFiletoDisk(resourceInfo, file);
	}
	
	//�־û��ļ�
	private void storeFiletoDisk(ResourceInfo resourceinfo, MultipartFile file) {
		try {
		    String filepath = resourceinfo.getFiledir()+resourceinfo.getFilerealname();
			FileUtil.createFile(filepath);
			file.transferTo(new File(filepath));
			logger.info("["+file.getOriginalFilename()+"] �ϴ��ɹ���");
		} catch (Exception e) {
			logger.error("�ϴ��ļ����ݳ���"+e);
			throw new ServiceException("�ϴ��ļ����ݳ���"+e);
		}
	}
	
	
	/**���ص����ĵ�**/
	public void downloadFile(Integer resourceId,HttpServletResponse response){
		ResourceInfo resourceInfo = this.getResourceInfo(resourceId);
		String fileName = resourceInfo.getFilename();
		if ("xls".equals(resourceInfo.getFiletype()) && fileName.length() > 16)
			fileName = fileName.substring(0,12) + ".xls";
		FileUtil.downLoad(resourceInfo.getFullPath(),fileName, response);
	}
	
	
	/**�������**
	 * @throws Exception */
	public void packageDownLoadFile(Integer[] resourceIds,String username,HttpServletResponse response) {
		List<ResourceInfo> resources = resourceInfoDao.findByIds(Arrays.asList(resourceIds));
		File filepath = new File(downloadtemp);
		if(!filepath.exists()) filepath.mkdirs();
		FileOutputStream fosm = null ;
		ZipOutputStream zosm = null;
		try{
		    fosm = new FileOutputStream(downloadtemp+username+".zip"); //ѹ�����ļ���;
		    zosm = new ZipOutputStream(fosm);
			for (ResourceInfo resourceInfo : resources){
				compressionStream(zosm,resourceInfo,"");
			}
			zosm.setEncoding("GBK");
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				zosm.closeEntry();
				zosm.close();
				fosm.close();
			} catch (IOException e) {
				// TODO �Զ����� catch ��
				e.printStackTrace();
			}	
		}
		FileUtil.downLoad(downloadtemp+username+".zip", username+".zip", response);
	}
	

	/**���ѹ���ļ�**/
	private  void compressionStream(final ZipOutputStream zosm, ResourceInfo resource, String basePath) throws IOException {
		
		if (resource.getIsdir()){   //�ļ���
			List<ResourceInfo> subResources = this.getResourceInfoListByParent(resource);
			try {
				zosm.putNextEntry(new ZipEntry(basePath + "/"));
			} catch (IOException e) {
				e.printStackTrace();
			}
			basePath = basePath + (basePath.length() == 0 ? "" : "/") + resource.getFilealiasname();
			for (ResourceInfo subResource : subResources) {
				compressionStream(zosm, subResource, basePath);
			}
		}else {          //�ļ�
			byte[] bytes = new byte[1024];
			basePath = basePath + (basePath.length() == 0 ? "" : "/") + resource.getFilealiasname();
			zosm.putNextEntry(new ZipEntry(basePath));
			BufferedInputStream  bism = new BufferedInputStream(FileUtil.getFileInputStream(resource.getFullPath()), 1024);
			BufferedOutputStream bosm = new BufferedOutputStream(zosm);
			int count;
			  
			while ((count = bism.read(bytes, 0, 1024)) != -1) {
				bosm.write(bytes, 0, count);
			}
			if (bism != null) bism.close();
			bosm.flush();
		}
	}	
	
	/**ɾ���ļ���Ϣ���ļ����������ļ����µ������ļ� **/
	@Transactional
	public void deleteResourceInfo(ResourceInfo resourceInfo) {
		try {
			resourceInfoDao.deleteById(resourceInfo.getId());
			if(resourceInfo.getIsdir()){
				for(ResourceInfo subResourceInfo:getResourceInfoListByParent(resourceInfo)){
					deleteResourceInfo(subResourceInfo);
				}
			}else
				//ɾ��ʵ���ļ�
				removeFile(resourceInfo);
			    //����ɾ���ļ��Ǵ����״̬����ɾ���������
				if(resourceInfo.getApprovalstatus().equals(ResourceApprovalService.APPROVALSTATUS_SENT)){
					resourceApprovalService.removeApprovalRequest(resourceInfo.getId());
				}
		} catch (Exception e) {
			throw new ServiceException(e);
		}	
	}
	
	/**ɾ��ʵ���ļ�**/
	private void removeFile(ResourceInfo resourceInfo){
		String path = resourceInfo.getFullPath();
		File file = new File(path);
		file.delete();
		logger.info("[{}] ɾ���ɹ���",resourceInfo.getFilealiasname());
	}
	
	/**�ƶ��ļ�**/
	public void move(List<Integer> ids, Integer pid) {
		if(ids.contains(pid)) ids.remove(pid);
		try {
			resourceInfoDao.updateByIdsMap(ids, new String[]{"pid"}, new Object[]{pid});
		} catch (Exception e) {
			throw new ServiceException(e.getMessage());
		}
	}
	
	@Value("${web.downloadtemp}")  
	private String downloadtemp ;
	
	@Resource
	private ResourceInfoDao resourceInfoDao;
	@Resource
	private ResourceApprovalService resourceApprovalService;
	

}
