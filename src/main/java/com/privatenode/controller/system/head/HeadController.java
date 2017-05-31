package com.privatenode.controller.system.head;

import com.privatenode.controller.base.BaseController;
import com.privatenode.util.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="/head")
public class HeadController extends BaseController {
	
//	@Resource(name="userService")
//	private UserService userService;	
//	@Resource(name="appuserService")
//	private AppuserService appuserService;
	
	/**
	 * ��ȡͷ����Ϣ
	 */
	@RequestMapping(value="/getUname")
	@ResponseBody
	public Object getList(HttpServletRequest request) {
		PageData pd = new PageData();
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			pd = this.getPageData();
			List<PageData> pdList = new ArrayList<PageData>();

			//shiro�����session
//			Subject currentUser = SecurityUtils.getSubject();
//			Session session = currentUser.getSession();

			HttpSession session = request.getSession();
			PageData pds = new PageData();
			pds = (PageData)session.getAttribute("userpds");

			if(null == pds){
//				String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();	//��ȡ��ǰ��¼��loginname
				String USERNAME = "99";	//��ȡ��ǰ��¼��loginname
				pd.put("USERNAME", USERNAME);
//				pds = userService.findByUId(pd);
				session.setAttribute("userpds", pds);
			}

			pdList.add(pds);
			map.put("list", pdList);
		} catch (Exception e) {
			logger.error(e.toString(), e);
		} finally {
			logAfter(logger);
		}
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * ����Ƥ��
	 */
	@RequestMapping(value="/setSKIN")
	public void setSKIN(HttpServletRequest request, PrintWriter out){
		PageData pd = new PageData();
		try{
			pd = this.getPageData();

			//shiro�����session
//			Subject currentUser = SecurityUtils.getSubject();
//			Session session = currentUser.getSession();
			HttpSession session = request.getSession();

			String USERNAME = session.getAttribute(Const.SESSION_USERNAME).toString();//��ȡ��ǰ��¼��loginname
			pd.put("USERNAME", USERNAME);
//			userService.setSKIN(pd);
			session.removeAttribute(Const.SESSION_userpds);
			session.removeAttribute(Const.SESSION_USERROL);
			out.write("success");
			out.close();
		} catch(Exception e){
			logger.error(e.toString(), e);
		}

	}

	/**
	 * ȥ�༭����ҳ��
	 */
	@RequestMapping(value="/editEmail")
	public ModelAndView editEmail() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/head/edit_email");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * ȥ���Ͷ���ҳ��
	 */
	@RequestMapping(value="/goSendSms")
	public ModelAndView goSendSms() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/head/send_sms");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * ���Ͷ���
	 */
	@RequestMapping(value="/sendSms")
	@ResponseBody
	public Object sendSms(){
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> map = new HashMap<String,Object>();
		String msg = "ok";		//����״̬
		int count = 0;			//ͳ�Ʒ��ͳɹ�����
		int zcount = 0;			//��������


		List<PageData> pdList = new ArrayList<PageData>();

		String PHONEs = pd.getString("PHONE");					//�Է�����
		String CONTENT = pd.getString("CONTENT");				//����
		String isAll = pd.getString("isAll");					//�Ƿ��͸�ȫ���Ա yes or no
		String TYPE = pd.getString("TYPE");						//���� 1�����Žӿ�1   2�����Žӿ�2
		String fmsg = pd.getString("fmsg");						//�ж���ϵͳ�û����ǻ�Ա "appuser"Ϊ��Ա�û�


		if("yes".endsWith(isAll)){
			try {
				List<PageData> userList = new ArrayList<PageData>();

//				userList = "appuser".equals(fmsg) ? appuserService.listAllUser(pd):userService.listAllUser(pd);

				zcount = userList.size();
				try {
					for(int i=0;i<userList.size();i++){
						if(Tools.checkMobileNumber(userList.get(i).getString("PHONE"))){			//�ֻ��Ÿ�ʽ���Ծ�����
							if("1".equals(TYPE)){
//								SmsUtil.sendSms1(userList.get(i).getString("PHONE"), CONTENT);		//���÷����ź���1
							}else{
//								SmsUtil.sendSms2(userList.get(i).getString("PHONE"), CONTENT);		//���÷����ź���2
							}
							count++;
						}else{
							continue;
						}
					}
					msg = "ok";
				} catch (Exception e) {
					msg = "error";
				}

			} catch (Exception e) {
				msg = "error";
			}
		}else{
			PHONEs = PHONEs.replaceAll("��", ";");
			PHONEs = PHONEs.replaceAll(" ", "");
			String[] arrTITLE = PHONEs.split(";");
			zcount = arrTITLE.length;
			try {
				for(int i=0;i<arrTITLE.length;i++){
					if(Tools.checkMobileNumber(arrTITLE[i])){			//�ֻ���ʽ���Ծ�����
						if("1".equals(TYPE)){
//							SmsUtil.sendSms1(arrTITLE[i], CONTENT);		//���÷����ź���1
						}else{
//							SmsUtil.sendSms2(arrTITLE[i], CONTENT);		//���÷����ź���2
						}
						count++;
					}else{
						continue;
					}
				}
				msg = "ok";
			} catch (Exception e) {
				msg = "error";
			}
		}
		pd.put("msg", msg);
		pd.put("count", count);						//�ɹ���
		pd.put("ecount", zcount-count);				//ʧ����
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * ȥ���͵����ʼ�ҳ��
	 */
	@RequestMapping(value="/goSendEmail")
	public ModelAndView goSendEmail() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("system/head/send_email");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * ���͵����ʼ�
	 */
	@RequestMapping(value="/sendEmail")
	@ResponseBody
	public Object sendEmail(){
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> map = new HashMap<String,Object>();
		String msg = "ok";		//����״̬
		int count = 0;			//ͳ�Ʒ��ͳɹ�����
		int zcount = 0;			//��������

		String strEMAIL = Tools.readTxtFile(Const.EMAIL);		//��ȡ�ʼ�����

		List<PageData> pdList = new ArrayList<PageData>();

		String toEMAIL = pd.getString("EMAIL");					//�Է�����
		String TITLE = pd.getString("TITLE");					//����
		String CONTENT = pd.getString("CONTENT");				//����
		String TYPE = pd.getString("TYPE");						//����
		String isAll = pd.getString("isAll");					//�Ƿ��͸�ȫ���Ա yes or no

		String fmsg = pd.getString("fmsg");						//�ж���ϵͳ�û����ǻ�Ա "appuser"Ϊ��Ա�û�

		if(null != strEMAIL && !"".equals(strEMAIL)){
			String strEM[] = strEMAIL.split(",fh,");
			if(strEM.length == 4){
				if("yes".endsWith(isAll)){
					try {
						List<PageData> userList = new ArrayList<PageData>();

//						userList = "appuser".equals(fmsg) ? appuserService.listAllUser(pd):userService.listAllUser(pd);

						zcount = userList.size();
						try {
							for(int i=0;i<userList.size();i++){
								if(Tools.checkEmail(userList.get(i).getString("EMAIL"))){		//�����ʽ���Ծ�����
//									SimpleMailSender.sendEmail(strEM[0], strEM[1], strEM[2], strEM[3], userList.get(i).getString("EMAIL"), TITLE, CONTENT, TYPE);//���÷����ʼ�����
									count++;
								}else{
									continue;
								}
							}
							msg = "ok";
						} catch (Exception e) {
							msg = "error";
						}

					} catch (Exception e) {
						msg = "error";
					}
				}else{
					toEMAIL = toEMAIL.replaceAll("��", ";");
					toEMAIL = toEMAIL.replaceAll(" ", "");
					String[] arrTITLE = toEMAIL.split(";");
					zcount = arrTITLE.length;
					try {
						for(int i=0;i<arrTITLE.length;i++){
							if(Tools.checkEmail(arrTITLE[i])){		//�����ʽ���Ծ�����
//								SimpleMailSender.sendEmail(strEM[0], strEM[1], strEM[2], strEM[3], arrTITLE[i], TITLE, CONTENT, TYPE);//���÷����ʼ�����
								count++;
							}else{
								continue;
							}
						}
						msg = "ok";
					} catch (Exception e) {
						msg = "error";
					}
				}
			}else{
				msg = "error";
			}
		}else{
			msg = "error";
		}
		pd.put("msg", msg);
		pd.put("count", count);						//�ɹ���
		pd.put("ecount", zcount-count);				//ʧ����
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * ȥϵͳ����ҳ��
	 */
	@RequestMapping(value="/goSystem")
	public ModelAndView goEditEmail() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("YSYNAME", Tools.readTxtFile(Const.SYSNAME));	//��ȡϵͳ����
		pd.put("COUNTPAGE", Tools.readTxtFile(Const.PAGE));		//��ȡÿҳ����
		String strEMAIL = Tools.readTxtFile(Const.EMAIL);		//��ȡ�ʼ�����
		String strSMS1 = Tools.readTxtFile(Const.SMS1);			//��ȡ����1����
		String strSMS2 = Tools.readTxtFile(Const.SMS2);			//��ȡ����2����
		String strFWATERM = Tools.readTxtFile(Const.FWATERM);	//��ȡ����ˮӡ����
		String strIWATERM = Tools.readTxtFile(Const.IWATERM);	//��ȡͼƬˮӡ����
		pd.put("Token", Tools.readTxtFile(Const.WEIXIN));		//��ȡ΢������

		if(null != strEMAIL && !"".equals(strEMAIL)){
			String strEM[] = strEMAIL.split(",fh,");
			if(strEM.length == 4){
				pd.put("SMTP", strEM[0]);
				pd.put("PORT", strEM[1]);
				pd.put("EMAIL", strEM[2]);
				pd.put("PAW", strEM[3]);
			}
		}

		if(null != strSMS1 && !"".equals(strSMS1)){
			String strS1[] = strSMS1.split(",fh,");
			if(strS1.length == 2){
				pd.put("SMSU1", strS1[0]);
				pd.put("SMSPAW1", strS1[1]);
			}
		}

		if(null != strSMS2 && !"".equals(strSMS2)){
			String strS2[] = strSMS2.split(",fh,");
			if(strS2.length == 2){
				pd.put("SMSU2", strS2[0]);
				pd.put("SMSPAW2", strS2[1]);
			}
		}

		if(null != strFWATERM && !"".equals(strFWATERM)){
			String strFW[] = strFWATERM.split(",fh,");
			if(strFW.length == 5){
				pd.put("isCheck1", strFW[0]);
				pd.put("fcontent", strFW[1]);
				pd.put("fontSize", strFW[2]);
				pd.put("fontX", strFW[3]);
				pd.put("fontY", strFW[4]);
			}
		}

		if(null != strIWATERM && !"".equals(strIWATERM)){
			String strIW[] = strIWATERM.split(",fh,");
			if(strIW.length == 4){
				pd.put("isCheck2", strIW[0]);
				pd.put("imgUrl", strIW[1]);
				pd.put("imgX", strIW[2]);
				pd.put("imgY", strIW[3]);
			}
		}

		mv.setViewName("system/head/sys_edit");
		mv.addObject("pd", pd);

		return mv;
	}

	/**
	 * ����ϵͳ����1
	 */
	@RequestMapping(value="/saveSys")
	public ModelAndView saveSys() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Tools.writeFile(Const.SYSNAME,pd.getString("YSYNAME"));	//д��ϵͳ����
		Tools.writeFile(Const.PAGE,pd.getString("COUNTPAGE"));	//д��ÿҳ����
		Tools.writeFile(Const.EMAIL,pd.getString("SMTP")+",fh,"+pd.getString("PORT")+",fh,"+pd.getString("EMAIL")+",fh,"+pd.getString("PAW"));	//д���ʼ�����������
		Tools.writeFile(Const.SMS1,pd.getString("SMSU1")+",fh,"+pd.getString("SMSPAW1"));	//д�����1����
		Tools.writeFile(Const.SMS2,pd.getString("SMSU2")+",fh,"+pd.getString("SMSPAW2"));	//д�����2����
		mv.addObject("msg","OK");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * ����ϵͳ����2
	 */
	@RequestMapping(value="/saveSys2")
	public ModelAndView saveSys2() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Tools.writeFile(Const.FWATERM,pd.getString("isCheck1")+",fh,"+pd.getString("fcontent")+",fh,"+pd.getString("fontSize")+",fh,"+pd.getString("fontX")+",fh,"+pd.getString("fontY"));	//����ˮӡ����
		Tools.writeFile(Const.IWATERM,pd.getString("isCheck2")+",fh,"+pd.getString("imgUrl")+",fh,"+pd.getString("imgX")+",fh,"+pd.getString("imgY"));	//ͼƬˮӡ����
		Watermark.fushValue();
		mv.addObject("msg","OK");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * ����ϵͳ����3
	 */
	@RequestMapping(value="/saveSys3")
	public ModelAndView saveSys3() throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Tools.writeFile(Const.WEIXIN,pd.getString("Token"));	//д��΢������
		mv.addObject("msg","OK");
		mv.setViewName("save_result");
		return mv;
	}

	/**
	 * ȥ����������ҳ��
	 */
	@RequestMapping(value="/goProductCode")
	public ModelAndView goProductCode() throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/head/productCode");
		return mv;
	}
	
}
