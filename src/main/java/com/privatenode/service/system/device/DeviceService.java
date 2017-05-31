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
        return (List<PageData>) dao.findForList("OwnerMapper.listPageAllMUser", page);
    }

    /*
    *根据条件查询 列表
    */
    public List<PageData> list(Page page) throws Exception {
        return (List<PageData>) dao.findForList("OwnerMapper.listPageAllMUser", page);
    }

    /*
    *根据keyWord查询 列表
    */
    public List<PageData> listByKey(Page page) throws Exception {
        return (List<PageData>) dao.findForList("OwnerMapper.listPageMuserByKey", page);
    }

    /*
     *根据 id 查询实体
     */
    public PageData findById(String owerID) throws Exception {
        return (PageData) dao.findForObject("OwnerMapper.findMUserById", owerID);
    }

    /*
    *取最大的ID
    */
    public PageData findMaxId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("OwnerMapper.findMaxMUserId", pd);
    }

    /*
     *取userinfo最大的ID
     */
    public PageData findUserinfoMaxId(PageData pd) throws Exception {
        return (PageData) dao.findForObject("OwnerMapper.findUserinfoMaxId", pd);
    }

    /*
    *保存u_user
    */
    public void saveUowner(PageData pd) throws Exception {
        dao.save("OwnerMapper.saveUowner", pd);
    }

    /*
    * 删除
    */
    public void delete(String id) throws Exception {
        dao.delete("OwnerMapper.deleteMUser", id);
    }

    /*
     * 删除userinfo
     */
    public void deleteUserInfo(String id) throws Exception {
        dao.delete("OwnerMapper.deleteUserInfo", id);
    }

    /*
     * 批量删除
     */
    public void deleteAll(String[] ids) throws Exception {
        dao.delete("OwnerMapper.deleteAllMUser", ids);
    }

    /*
     * 批量删除userinfo
     */
    public void deleteAllUserInfo(String[] ids) throws Exception {
        dao.delete("OwnerMapper.deleteAllUserInfo", ids);
    }

    /*
     *更新user
     */
    public void updateUser(PageData pd) throws Exception {
        dao.update("OwnerMapper.updateMUser", pd);
    }

    /*
     * 更新userinfo
     */
    public void updateUserInfo(PageData pd) throws Exception {
        dao.update("OwnerMapper.updateUserInfo", pd);
    }

    /*
    *充值 列表
    */
    public List<PageData> listRecharge(Page page) throws Exception {
        return (List<PageData>) dao.findForList("OwnerMapper.listPageRecharge", page);
    }

    /*
     * 删除充值信息
     */
    public void deleteRecharge(String id) throws Exception {
        dao.delete("OwnerMapper.deleteRecharge", id);
    }
}