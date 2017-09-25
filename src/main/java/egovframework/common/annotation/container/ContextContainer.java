package egovframework.common.annotation.container;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.lang.reflect.Method;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.common.annotation.InnerPage;

@Service
public class ContextContainer {
	Logger logger = LoggerFactory.getLogger(ContextContainer.class.getName());

	public List<InnerPageVO> getInnerPage(String pkg) {
		List<InnerPageVO> vl = new ArrayList<>();
		try {
			Set<Class<?>> list = getClasses(pkg);
			for (Class<?> clz : list) {
				if(!clz.isInterface() && !clz.isMemberClass() && !clz.isLocalClass() && !clz.isEnum() && !clz.isAnnotation()) {
					List<InnerPageVO> result = invokeInnerPageAnnotation(clz);
					if(result != null) {
						vl.addAll(result);
					}
				}
			}
			logger.debug("inner page: {}", vl);
			return vl;
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InstantiationException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 매개변수로 받은 클래스의 InnerPage annotation 값을 반환합니다.
	 * 
	 * @param <T>
	 * 
	 * @param clazz
	 * @param <T>
	 * @return
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	private <T> List<InnerPageVO> invokeInnerPageAnnotation(Class<T> clazz)
			throws IllegalAccessException, InstantiationException {
		try {
			Object obj = clazz.newInstance();
			Method[] methods = obj.getClass().getDeclaredMethods();
			List<InnerPageVO> vl = new ArrayList<>();
			if (obj.getClass().getAnnotation(Controller.class) != null) {
				for (Method method : methods) {
					InnerPage innerPage = method.getAnnotation(InnerPage.class);
					if (innerPage != null) {
						RequestMapping rm = method.getAnnotation(RequestMapping.class);
						if (rm != null) {
							InnerPageVO vo = new InnerPageVO();
							vo.setName(innerPage.name());
							vo.setId(innerPage.id());
							vo.setUrl(rm.value()[0]);
							vl.add(vo);
						}
					}
				}
			}
			return vl;
		} catch (Exception e) {
			return null;
		}
	}

	private Set<Class<?>> getClasses(String pack) {

		// 첫 번째 class 같은 집합
		Set<Class<?>> classes = new LinkedHashSet<Class<?>>();
		// 혹시 순환 반복
		boolean recursive = true;
		// 가방 처벌해야 가져오는 이름 바꾸기
		String packageName = pack;
		String packageDirName = packageName.replace('.', '/');
		// 정의 한 열거형 집합 처벌해야 순환 처리할 이 목록 아래에서 things
		Enumeration<URL> dirs;
		try {
			dirs = Thread.currentThread().getContextClassLoader().getResources(packageDirName);
			// 순환 반복 내려가다
			while (dirs.hasMoreElements()) {
				// 다음 원소 가져오기
				URL url = dirs.nextElement();
				// 프로토콜 이름 받다
				String protocol = url.getProtocol();
				// 만약 이 파일 형식으로 저장합니다. 서버에
				if ("file".equals(protocol)) {
//					System.err.println("file 형식 검색");
					// 가방 물리적 경로 가져오기
					String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
					// 파일 검색 방식 으로 전체 패키지 다음 파일을 추가하는 중 고 집합
					findAndAddClassesInPackageByFile(packageName, filePath, recursive, classes);
				} else if ("jar".equals(protocol)) {
					// 만약 jar 가방 파일
					// 한 JarFile 정의
//					System.err.println("jar 형식 검색");
					JarFile jar;
					try {
						// jar 가져오기
						jar = ((JarURLConnection) url.openConnection()).getJarFile();
						// 이때부터 jar 가방 하나 숫자 종류 받다
						Enumeration<JarEntry> entries = jar.entries();
						// 같은 진행 순환 반복
						while (entries.hasMoreElements()) {
							// jar 안의 한 항목 가져오기 수 목록 및 일부 jar 가방 안에 다른 파일 등 META-INF 등 파일
							JarEntry entry = entries.nextElement();
							String name = entry.getName();
							// 만약 은 / 시작하는
							if (name.charAt(0) == '/') {
								// 다음 문자열 가져오기
								name = name.substring(1);
							}
							// 만약 전반 부분 및 정의 가방 같다
							if (name.startsWith(packageDirName)) {
								int idx = name.lastIndexOf('/');
								// 만약 이 " /" 끝 한 봉지
								if (idx != -1) {
									// 가져오기 가방 그 " /" 바꾸기 되다"."
									packageName = name.substring(0, idx).replace('/', '.');
								}
								// 만약 수 있다 고 반복 못 한 봉지
								if ((idx != -1) || recursive) {
									// 만약 한 것도 아니고.class 파일 디렉터리
									if (name.endsWith(".class") && !entry.isDirectory()) {
										// 뒤에 " 버리다;.class" 진정한 类名 가져오기
										String className = name.substring(packageName.length() + 1, name.length() - 6);
										try {
											// classes 추가하기
											classes.add(Class.forName(packageName + '.' + className));
										} catch (ClassNotFoundException e) {
											// log
											// .error("사용자 정의 보기 클래스 추가 오류 찾을 수 있는.class 이런 파일");
											e.printStackTrace();
										}
									}
								}
							}
						}
					} catch (IOException e) {
						// log.error("지금 스캔 사용자 정의 보기 때 부터 가방 가져오는 중 오류 발생 jar 파일");
						e.printStackTrace();
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return classes;
	}

	private void findAndAddClassesInPackageByFile(String packageName, String packagePath, final boolean recursive,
			Set<Class<?>> classes) {
		// 이 가방 목록을 가져오는 수립을 위한 File
		File dir = new File(packagePath);
		// 만약 존재하지 않거나 디렉터리를 되돌려줍니다 아니고 그냥
		if (!dir.exists() || !dir.isDirectory()) {
			// log.warn("사용자 정의 가방 " + packageName + " 다음 아무 파일");
			return;
		}
		// 만약 존재 곧 가져오기 가방 아래 모든 파일 디렉터리 포함
		File[] dirfiles = dir.listFiles(new FileFilter() {
			// 사용자 필터 규칙 수 있다면 순환 (하위 디렉터리) 또는 은.class 끝 파일 (빌드 좋은 java 클래스 파일)
			public boolean accept(File file) {
				return (recursive && file.isDirectory()) || (file.getName().endsWith(".class"));
			}
		});
		// 순환 모든 파일
		for (File file : dirfiles) {
			// 만약 디렉터리 은 계속 검색
			if (file.isDirectory()) {
				findAndAddClassesInPackageByFile(packageName + "." + file.getName(), file.getAbsolutePath(), recursive,
						classes);
			} else {
				// 만약 java 클래스 파일 빼고 뒤에.class 남기고 类名
				String className = file.getName().substring(0, file.getName().length() - 6);
				try {
					// 추가하는 중 가서 집합
					// classes.add(Class.forName(packageName + '.' + className));
					// 경과를 답장 학생 알림, 이 forName 좀 안 좋아 할 트리거 static 방법이 없다, classLoader 사용할 load 깨끗하다
					classes.add(
							Thread.currentThread().getContextClassLoader().loadClass(packageName + '.' + className));
				} catch (ClassNotFoundException e) {
					// log.error("사용자 정의 보기 클래스 추가 오류 찾을 수 있는.class 이런 파일");
					e.printStackTrace();
				}
			}
		}
	}
}
