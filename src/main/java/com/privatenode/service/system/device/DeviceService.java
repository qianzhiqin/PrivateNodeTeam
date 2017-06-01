package com.privatenode.service.system.device;

import com.privatenode.dao.DaoSupport;
import com.privatenode.entity.Page;
import com.privatenode.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by qianzhiqin on 2017/5/31.
 */
@SuppressWarnings("all")
@Service("deviceService")
public class DeviceService {

    @Resource(name = "daoSupport")
    private DaoSupport dao;


    /*
    *列表(全部)
    */
    public List<PageData> listAll(Page page) throws Exception {
        return (List<PageData>) dao.findForList("DeviceMapper.listPageAllDevice", page);
    }

    /*
    *根据条件查询 列表
    */
    public List<PageData> list(Page page) throws Exception {
        return (List<PageData>) dao.findForList("DeviceMapper.listPageAllDevice", page);
    }

    /*
    *根据keyWord查询 列表
    */
    public List<PageData> listByKey(Page page) throws Exception {
        return (List<PageData>) dao.findForList("DeviceMapper.listPageDeviceByKey", page);
    }

    /*
     *根据 id 查询实体
     */
    public PageData findById(String owerID) throws Exception {
        return (PageData) dao.findForObject("DeviceMapper.findDeviceById", owerID);
    }

    /*
    *取最大的ID
    */
    public PageData findMaxId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("DeviceMapper.findMaxDeviceId", pd);
    }


    /*
    *保存u_user
    */
    public void saveDevice(PageData pd) throws Exception {
        dao.save("DeviceMapper.saveDevice", pd);
    }

    /*
    * 删除
    */
    public void delete(String id) throws Exception {
        dao.delete("DeviceMapper.deleteDevice", id);
    }


    /*
     * 批量删除
     */
    public void deleteAll(String[] ids) throws Exception {
        dao.delete("DeviceMapper.deleteAllDevice", ids);
    }

    /*
     *更新user
     */
    public void updateDevice(PageData pd) throws Exception {
        dao.update("DeviceMapper.updateDevice", pd);
    }


}