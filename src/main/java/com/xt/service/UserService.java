package com.xt.service;

import com.github.pagehelper.PageInfo;
import com.xt.utils.JsonUtils;
import com.xt.vo.User;


public interface UserService {
    public JsonUtils<PageInfo<User>> findAllUser(Integer pageNumber,Integer pageSize);
    public JsonUtils insert(User user);
    public JsonUtils deleteByPrimaryKey(Integer[] id);
    public JsonUtils updateByPrimaryKey(User user);
}
