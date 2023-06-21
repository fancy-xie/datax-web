package com.wugui.admin.util;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.util.DigestUtils;

public class EncodeTest {

    @Test
    public void encodeTest() {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        String password = "123456";
        String md5Str = DigestUtils.md5DigestAsHex(password.getBytes());
        System.out.println(md5Str);
        String encodeStr = bCryptPasswordEncoder.encode(md5Str);
        System.out.println(encodeStr);
    }
}
