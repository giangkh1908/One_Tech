/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package register;

import java.security.MessageDigest;
import org.apache.tomcat.util.codec.binary.Base64;
/**
 *
 * @author KimHo
 */
public class EncryptionPassword {
    
    public static String toSHA1(String password) {
        String salt = "asdfadskjkjk12ad;adfasghgkj";
        String result = null;
        // encryption
        
        password = password + salt;
        try {
            byte[] dataBytes = password.getBytes("UTF-8");
            
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            result = Base64.encodeBase64String(md.digest(dataBytes));
        } catch (Exception e) {
        }
        return result;
    }
}
