package com.xt.dao;

import com.xt.vo.User;

import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userId);

    int deleteByPrimaryKey();

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userId);

    int updateUserSelective(User record);

    int updateByPrimaryKey(User record);

    List<User> findAllUser();


}