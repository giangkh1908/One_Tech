package model;
/**
 *
 * @author KimHo
 */
public class Account {
    public String username, email, password, auth_method, code;
    public boolean isAdmin;
    
    public Account() {
    }
    public Account(String username, String email, String password) {
        this.username = username;
        this.email = email;
        this.password = password;
    }
    public Account(String username, String email, String password, String auth_method, String code) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.auth_method = auth_method;
        this.code = code;
    }
    public Account(String username, String email, String password, String code) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.code = code;
    }
    
    public Account(String username, String password) {
        this.username = username;
        this.password = password;
    } 
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getAuth_method() {
        return auth_method;
    }
    public void setAuth_method(String auth_method) {
        this.auth_method = auth_method;
    }
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    
    public boolean isAdmin() {
        return isAdmin;
    }
    public void setAdmin(boolean isAdmin) {
        this.isAdmin = isAdmin;
    }
}
