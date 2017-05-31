package com.privatenode.controller.system.device;

import com.privatenode.controller.base.BaseController;
import com.privatenode.entity.Page;
import com.privatenode.service.system.device.DeviceService;
import com.privatenode.util.AppUtil;
import com.privatenode.util.PageData;
import com.privatenode.util.UuidUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by qianzhiqin on 2017/5/31.
 */
@Controller
@RequestMapping(value="/device")
public class DeviceController extends BaseController {

    @Resource(name = "deviceService")
    private DeviceService deviceService;

    /**
     * 访问登录页
     *
     * @return
     */
    @RequestMapping(value = "/listAll")
    public ModelAndView toLogin(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        page.setPd(pd);
        List<PageData> varList = deviceService.listAll(page);
        mv.setViewName("system/owner/owner_list");
        mv.addObject("pd", pd);
        mv.addObject("varList", varList);
        mv.addObject("page", page);
        return mv;
    }

    /**
     * 列表
     */
    @RequestMapping(value="/list")
    public ModelAndView list(Page page){
        logBefore(logger, "列表owner");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try{
            pd = this.getPageData();

            String keyWord = pd.getString("keyword").trim();
            List<PageData>	varList = new ArrayList<PageData>();
            page.setPd(pd);
            if(keyWord.length()==0){
                varList = deviceService.list(page);
            }else{
                varList = deviceService.listByKey(page);
            }

            mv.setViewName("system/owner/owner_list");
            mv.addObject("varList", varList);
            mv.addObject("pd", pd);
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 批量删除
     */
    @RequestMapping(value="/deleteAll")
    @ResponseBody
    public Object deleteAll() {
        logBefore(logger, "批量删除owner");
        PageData pd = new PageData();
        Map<String,Object> map = new HashMap<String,Object>();
        String msg = "";
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();
            String DATA_IDS = pd.getString("DATA_IDS");
            if(null != DATA_IDS && !"".equals(DATA_IDS)){
                String[] ArrayDATA_IDS = DATA_IDS.split(",");
//				String ids = "(" + DATA_IDS + ")";
                //删除用户
                deviceService.deleteAll(ArrayDATA_IDS);
                msg = "success";
                pd.put("msg", "success");
            }else{
                pd.put("msg", "error");
                msg = "error";
            }
            pdList.add(pd);
            map.put("list", pdList);
            map.put("result", msg);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        } finally {
            logAfter(logger);
        }
        return AppUtil.returnObject(pd, map);
    }

    /**
     * 删除单个用户
     */
    @RequestMapping(value="/delete")
    public void delete(PrintWriter out){
        logBefore(logger, "删除owner");
        PageData pd = new PageData();
        try{
            pd = this.getPageData();
            String id = pd.getString("id");
            deviceService.delete(id);
            out.write("success");
            out.close();
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
    }

    /**
     * 去修改页面
     */
    @RequestMapping(value="/goEdit")
    public ModelAndView goEdit(){
        logBefore(logger, "去修改owner页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String owerID = pd.getString("id");
        try {
            pd = deviceService.findById(owerID);
            String userheadImage = pd.get("user_headImage")==null ? "": pd.getString("user_headImage").replace("/opt", "");
            pd.put("user_headImage",userheadImage);
            mv.setViewName("system/owner/owner_edit");
            mv.addObject("msg", "edit");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 修改
     */
    @RequestMapping(value="/edit")
    public ModelAndView edit(
            @RequestParam(value = "upload", required = false) MultipartFile file,
            HttpServletRequest request,
            @RequestParam(value = "ownerID") String ownerID,
            @RequestParam(value = "driverName") String driverName,
            @RequestParam(value = "accountTelephone") String accountTelephone,
            @RequestParam(value = "idCard") String idCard,
            @RequestParam(value = "address") String address,
            @RequestParam(value = "openAccountBank") String openAccountBank,
            @RequestParam(value = "accountNumber") String accountNumber,
            @RequestParam(value = "type") String type,
            @RequestParam(value = "balance") String balance,
            @RequestParam(value = "imageUrl") String imageUrl,
            @RequestParam(value = "isHaveCar") String isHaveCar,
            @RequestParam(value = "isVip") String isVip,
            @RequestParam(value = "carModel") String carModel,
            @RequestParam(value = "carNumPlate") String carNumPlate
    )
            throws Exception {
        logBefore(logger, "修改owner");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Page page = new Page();
        page.setPd(pd);
        try {

            String files = file.getOriginalFilename();
            String userHeadImage = "";
            if(files.length()==0){
                userHeadImage = imageUrl;
            }else{
//                userHeadImage = FileUpload.userImageUpload(request, file);
            }

            //获取参数
            pd.put("ownerID", ownerID);
            pd.put("driverName", driverName);
            pd.put("userHeadImage", userHeadImage);
            pd.put("accountTelephone", accountTelephone);
            pd.put("idCard", idCard);
            pd.put("address", address);
            pd.put("openAccountBank", openAccountBank);
            pd.put("accountNumber", accountNumber);
            pd.put("balance", balance);
            pd.put("type", type);
            pd.put("isHaveCar", isHaveCar);
            pd.put("isVip", isVip);
            pd.put("carModel", carModel);
            pd.put("carNumPlate", carNumPlate);

            deviceService.updateUser(pd);
            List<PageData> varList = deviceService.list(page);
            mv.addObject("varList", varList);
            mv.setViewName("system/owner/owner_list");
            mv.addObject("pd", pd);
            mv.addObject("page", page);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 去新增页面
     */
    @RequestMapping(value="/goAdd")
    public ModelAndView goAdd(){
        logBefore(logger, "去新增owner页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            mv.setViewName("system/owner/owner_add");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 新增用户
     */
    @RequestMapping(value="/add")
    public ModelAndView add(
            @RequestParam(value = "upload", required = false) MultipartFile file,
            HttpServletRequest request,
            @RequestParam(value = "driverName") String driverName,
            @RequestParam(value = "accountTelephone") String accountTelephone,
            @RequestParam(value = "idCard") String idCard,
            @RequestParam(value = "address") String address,
            @RequestParam(value = "openAccountBank") String openAccountBank,
            @RequestParam(value = "accountNumber") String accountNumber,
            @RequestParam(value = "type") String type,
            @RequestParam(value = "isHaveCar") String isHaveCar,
            @RequestParam(value = "isVip") String isVip,
            @RequestParam(value = "carModel") String carModel,
            @RequestParam(value = "carNumPlate") String carNumPlate
    )throws Exception{
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try{
//            String userHeadImage = FileUpload.userImageUpload(request, file);


            String owerID = UuidUtil.get32UUID();
            String loginPassword = "";
            String token = "";
            String scoring = "0";
            String balance = "0";
            String telephoneNum = pd.getString("accountTelephone");

            pd.put("owerID", owerID);
            pd.put("loginPassword", loginPassword);
//            pd.put("userHeadImage", userHeadImage);
            pd.put("token", token);
            pd.put("scoring", scoring);
            pd.put("totalScoring", "0");
            pd.put("balance", balance);
            pd.put("telephoneNum", telephoneNum);
//            pd.put("createTime", DateUtil.getUnixTime());

            //获取参数
            pd.put("driverName", driverName);
            pd.put("accountTelephone", accountTelephone);
            pd.put("idCard", idCard);
            pd.put("address", address);
            pd.put("openAccountBank", openAccountBank);
            pd.put("accountNumber", accountNumber);
            pd.put("type", type);
            pd.put("isHaveCar", isHaveCar);
            pd.put("isVip", isVip);
            pd.put("carModel", carModel);
            pd.put("carNumPlate", carNumPlate);
            deviceService.saveUowner(pd);


            Page page = new Page();
            List<PageData> varList = deviceService.list(page);
            mv.addObject("varList", varList);
            mv.setViewName("system/owner/owner_list");
            mv.addObject("pd", pd);
            mv.addObject("page", page);
        } catch(Exception e){
            logger.error(e.toString(), e);
            mv.addObject("msg","failed");
        }
        return mv;
    }
    /**
     * 去新增页面
     */
    @RequestMapping(value="/recharge")
    public ModelAndView recharge(Page page){
        logBefore(logger, "去owner充值页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        page.setPd(pd);

        try {
            List<PageData> varList = deviceService.listRecharge(page);
            mv.setViewName("system/owner/owner_recharge");
            mv.addObject("pd", pd);
            mv.addObject("varList", varList);
            mv.addObject("page", page);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }
    /**
     * 删除单个用户
     */
    @RequestMapping(value="/deleteRecharge")
    public void deleteRecharge(PrintWriter out){
        logBefore(logger, "删除Recharge");
        PageData pd = new PageData();
        try{
            pd = this.getPageData();
            String id = pd.getString("id");

            deviceService.deleteRecharge(id);
            out.write("success");
            out.close();
        } catch(Exception e){
            logger.error(e.toString(), e);
        }
    }


}
