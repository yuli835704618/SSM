package mybatis;

import com.xt.dao.UserMapper;
import com.xt.vo.User;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class Test {
    @Autowired
    private  UserMapper mapper;

    public static void main(String[] args) throws Exception{
        new Test().findAllUser();
    }

    public void findAllUser(){
        List<User> user = mapper.findAllUser();
        for (User u:user){
            System.out.println(u);
        }
    }
}
