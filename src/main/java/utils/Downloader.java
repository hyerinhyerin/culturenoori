package utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import common.CNPath;

public class Downloader {

	private String saveRealPath;

	public Downloader(String realPath) {
		this.saveRealPath = realPath;
		// System.out.println("[Downloader.Downloader] saveRealPath : " + saveRealPath);
	}
	
    private void createDirs(String strPath) {
    	
        Path path = Paths.get(strPath);

		try {
            Files.createDirectories(path);
    		System.out.println("[Downloader.createDirs] created strPath : " + strPath);

        } catch (IOException e) {
    		System.out.println("[Downloader.createDirs] strPath : " + strPath);
            System.err.println("[Downloader.createDirs] Failed : " + e.getMessage());
        }
    }
    
    public void reloadPoster(String realPath, String rootPath, String fileName, String detailId) throws IOException {
    	reload(realPath, rootPath, fileName, detailId, "http://www.kopis.or.kr/upload/pfmPoster/");
	}
    
    public void reloadStory(String realPath, String rootPath, String fileName, String detailId) throws IOException {
    	reload(realPath, rootPath, fileName, detailId, "http://www.kopis.or.kr/upload/pfmIntroImage/");
	}
    
    private void reload(String realPath, String rootPath, String fileName, String detailId, String posterBaseURL) throws IOException {

		String[] fileNameSplit = fileName.split("_");
		String imagepath = realPath + CNPath.IMG_ROOT + fileNameSplit[1] + "/" + fileName;
		
        if(!Files.exists(Paths.get(imagepath))) {
			String posterURL = posterBaseURL + fileName;

			System.err.println("[PerformDAO.reloadPoster] imagepath : " + imagepath);
    		System.err.println("[PerformDAO.reloadPoster] 다운로드해요 targetURL : " + posterURL);
			
    		Downloader downloader = new Downloader(realPath);
			downloader.download(posterURL, CNPath.IMG_ROOT + detailId + "/");
        }
	}
	
	public String download(String targetURL, String path) throws IOException {

		System.out.println("[Downloader.download] targetURL : " + targetURL);
		System.out.println("[Downloader.download] path : " + path);
		
		String strPath = saveRealPath + path;
		
		createDirs(strPath);

		// URL 객체 생성
		// URL 연결
		// 입력 스트림 생성
		URL url = new URL(targetURL);
		URLConnection connection = url.openConnection();
		InputStream inputStream = connection.getInputStream();
		
		// 파일 이름 추출
		// 파일 출력 스트림 생성
		String fileName = targetURL.substring(targetURL.lastIndexOf("/") + 1);
		System.out.println("[Downloader.download] fileName : " + fileName);
		FileOutputStream outputStream = new FileOutputStream(new File(strPath + fileName));
		
		// 버퍼를 사용하여 파일 저장
		byte[] buffer = new byte[1024];
		int bytesRead = -1;
		while ((bytesRead = inputStream.read(buffer)) != -1) {
			outputStream.write(buffer, 0, bytesRead);
		}
		
		// 스트림 닫기
		inputStream.close();
		outputStream.close();

		System.out.println("[Downloader.download] done");

		return fileName;
	}
}


























