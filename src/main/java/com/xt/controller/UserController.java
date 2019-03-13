package com.xt.controller;

import com.github.pagehelper.PageInfo;
import com.xt.service.UserService;
import com.xt.utils.JsonUtils;
import com.xt.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService service;

    @RequestMapping("/show")
    public @ResponseBody
    JsonUtils<PageInfo<User>> findAllUser(Integer pageNumber,Integer pageSize){
        return service.findAllUser(pageNumber,pageSize);
    }
    @RequestMapping("/add")
    public @ResponseBody JsonUtils  addUser(User user){
        return service.insert(user);
    }

    @RequestMapping("/delete")
    public @ResponseBody JsonUtils deleteByPrimaryKey(String val){
        String [] str = val.split(",");
        Integer [] arrId = new Integer[str.length];
        for (int i = 0;i<str.length;i++){
            arrId[i] = Integer.valueOf(str[i]);
        }
        return service.deleteByPrimaryKey(arrId);
    }

    @RequestMapping("update")
    public  @ResponseBody JsonUtils update(User user){
        System.out.println("123");
        System.out.println(user);
        return service.updateByPrimaryKey(user);
    }
}
