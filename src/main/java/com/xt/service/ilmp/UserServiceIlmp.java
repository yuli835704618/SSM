package com.xt.service.ilmp;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xt.dao.UserMapper;
import com.xt.service.UserService;
import com.xt.utils.JsonUtils;
import com.xt.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceIlmp implements UserService {
    @Autowired
    private UserMapper mapper;

    @Transactional(readOnly = true,propagation = Propagation.REQUIRED)
    public JsonUtils<PageInfo<User>> findAllUser(Integer pageNumber,Integer pageSize){
        PageHelper.startPage(pageNumber,pageSize,"user_id desc");
        List<User> list = mapper.findAllUser();

        PageInfo<User> pageInfo = new PageInfo<>(list);
        JsonUtils jsonUtils = new JsonUtils("OK",pageInfo,"0");
        System.out.println(jsonUtils);
        return jsonUtils;
    }
    @Transactional(readOnly = false,propagation = Propagation.REQUIRED)
    public JsonUtils insert(User user){
        JsonUtils jsonUtils = new JsonUtils();
        int i = mapper.insert(user);
        if(i>0){
            jsonUtils.setMsg("OK");
        }else{
            jsonUtils.setErrorCode("500");
        }
        return jsonUtils;
    }

    public JsonUtils deleteByPrimaryKey(Integer[] id){
        JsonUtils jsonUtils = new JsonUtils();
        int j = 0;
        for(int i = 0 ;i<id.length;i++){
            System.out.println(id[i]);
            j = mapper.deleteByPrimaryKey(id[i]);
        }
        if(j>0){
            jsonUtils.setMsg("OK");
        }else {
            jsonUtils.setErrorCode("500");
        }
        return jsonUtils;
    }

    public JsonUtils updateByPrimaryKey(User user){
        JsonUtils jsonUtils = new JsonUtils();
        if(user.getStatus().isEmpty()){
            user.setStatus(null);
        }
        if(user.getPhone().isEmpty()){
            user.setPhone(null);
        }
        if(user.getMail().isEmpty()){
            user.setMail(null);
        }
        if(user.getPassword().isEmpty()){
            user.setPassword(null);
        }
        int i = mapper.updateByPrimaryKey(user);
        if(i>0){
            jsonUtils.setMsg("OK");
        }else{
            jsonUtils.setErrorCode("500");
        }
        return jsonUtils;
    }
}
