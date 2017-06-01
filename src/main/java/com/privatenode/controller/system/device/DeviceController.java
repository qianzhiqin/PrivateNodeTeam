package com.privatenode.controller.system.device;

import com.privatenode.controller.base.BaseController;
import com.privatenode.entity.Page;
import com.privatenode.service.system.device.DeviceService;
import com.privatenode.util.AppUtil;
import com.privatenode.util.PageData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
@RequestMapping(value = "/device")
public class DeviceController extends BaseController {

    @Resource(name = "deviceService")
    private DeviceService deviceService;


    @RequestMapping(value = "/test")
    public ModelAndView test(Page page) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        page.setPd(pd);
//        List<PageData> varList = deviceService.listAll(page);
        PageData pd1 = new PageData();
        pd1.put("id", "1");
        pd1.put("name", "1123");
        List<PageData> varList = new ArrayList<>();
        varList.add(pd1);
        mv.setViewName("system/device/device_list");
        mv.addObject("pd", pd);
        mv.addObject("varList", varList);
        mv.addObject("page", page);
        return mv;
    }

    /**
     * 访问登录页
     *
     * @return
     */
    @RequestMapping(value = "/listAll")
    public ModelAndView toLogin(Page page) throws Exception {
        logBefore(logger, "列表owner");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        page.setPd(pd);
        List<PageData> varList = deviceService.listAll(page);
        mv.setViewName("system/device/device_list");
        mv.addObject("pd", pd);
        mv.addObject("varList", varList);
        mv.addObject("page", page);
        return mv;
    }

    /**
     * 列表
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) {
        logBefore(logger, "列表device");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        try {
            pd = this.getPageData();

            String keyWord = pd.getString("keyword").trim();
            List<PageData> varList = new ArrayList<PageData>();
            page.setPd(pd);
            if (keyWord.length() == 0) {
                varList = deviceService.list(page);
            } else {
                varList = deviceService.listByKey(page);
            }

            mv.setViewName("system/device/device_list");
            mv.addObject("varList", varList);
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 批量删除
     */
    @RequestMapping(value = "/deleteAll")
    @ResponseBody
    public Object deleteAll() {
        logBefore(logger, "批量删除device");
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        String msg = "";
        try {
            pd = this.getPageData();
            List<PageData> pdList = new ArrayList<PageData>();
            String DATA_IDS = pd.getString("DATA_IDS");
            if (null != DATA_IDS && !"".equals(DATA_IDS)) {
                String[] ArrayDATA_IDS = DATA_IDS.split(",");
//				String ids = "(" + DATA_IDS + ")";
                //删除用户
                deviceService.deleteAll(ArrayDATA_IDS);
                msg = "success";
                pd.put("msg", "success");
            } else {
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
    @RequestMapping(value = "/delete")
    public void delete(PrintWriter out) {
        logBefore(logger, "删除device");
        PageData pd = new PageData();
        try {
            pd = this.getPageData();
            String id = pd.getString("id");
            deviceService.delete(id);
            out.write("success");
            out.close();
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
    }

    /**
     * 去修改页面
     */
    @RequestMapping(value = "/goEdit")
    public ModelAndView goEdit() {
        logBefore(logger, "去修改device页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        String id = pd.getString("id");
        try {
            pd = deviceService.findById(id);
            mv.setViewName("system/device/device_edit");
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
    @RequestMapping(value = "/edit")
    public ModelAndView edit(
            HttpServletRequest request,
            @RequestParam(value = "name") String name,
            @RequestParam(value = "mine") String mine,
            @RequestParam(value = "type") String type,
            @RequestParam(value = "num") String num,
            @RequestParam(value = "cardtype") String cardtype,
            @RequestParam(value = "status") String status,
            @RequestParam(value = "inexpress") String inexpress,
            @RequestParam(value = "outexpress") String outexpress,
            @RequestParam(value = "repairdate") String repairdate,
            @RequestParam(value = "updatedate") String updatedate,
            @RequestParam(value = "description") String description,
            @RequestParam(value = "operator") String operator) throws Exception {
        logBefore(logger, "修改device");
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        Page page = new Page();
        page.setPd(pd);
        try {
            //获取参数
            pd.put("name", name);
            pd.put("mine", mine);
            pd.put("type", type);
            pd.put("num", num);
            pd.put("cardtype", cardtype);
            pd.put("status", status);
            pd.put("inexpress", inexpress);
            pd.put("outexpress", outexpress);
            pd.put("repairdate", repairdate);
            pd.put("updatedate", updatedate);
            pd.put("description", description);
            pd.put("operator", operator);

            deviceService.updateDevice(pd);
            List<PageData> varList = deviceService.list(page);
            mv.addObject("varList", varList);
            mv.setViewName("system/device/device_list");
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
    @RequestMapping(value = "/goAdd")
    public ModelAndView goAdd() {
        logBefore(logger, "去新增device页面");
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        try {
            mv.setViewName("system/device/device_add");
            mv.addObject("pd", pd);
        } catch (Exception e) {
            logger.error(e.toString(), e);
        }
        return mv;
    }

    /**
     * 新增用户
     */
    @RequestMapping(value = "/add")
    public ModelAndView add(
            HttpServletRequest request,
            @RequestParam(value = "name") String name,
            @RequestParam(value = "mine") String mine,
            @RequestParam(value = "type") String type,
            @RequestParam(value = "num") String num,
            @RequestParam(value = "cardtype") String cardtype,
            @RequestParam(value = "status") String status,
            @RequestParam(value = "inexpress") String inexpress,
            @RequestParam(value = "outexpress") String outexpress,
            @RequestParam(value = "repairdate") String repairdate,
//            @RequestParam(value = "updatedate") String updatedate,
            @RequestParam(value = "description") String description,
            @RequestParam(value = "operator") String operator  ) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd =  this.getPageData();
        try {
            pd.put("mine", mine);
            pd.put("type", type);
            pd.put("num", num);
            pd.put("cardtype", cardtype);
            pd.put("status", status);
            pd.put("inexpress", inexpress);
            pd.put("outexpress", outexpress);
            pd.put("repairdate", repairdate);
//            pd.put("updatedate", updatedate);
            pd.put("description", description);
            pd.put("operator", operator);
            deviceService.saveDevice(pd);


            Page page = new Page();
            List<PageData> varList = deviceService.list(page);
            mv.addObject("varList", varList);
            mv.setViewName("system/device/device_list");
            mv.addObject("pd", pd);
            mv.addObject("page", page);
        } catch (Exception e) {
            logger.error(e.toString(), e);
            mv.addObject("msg", "failed");
        }
        return mv;
    }


}
