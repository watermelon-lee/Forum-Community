package com.domain;


import javax.persistence.*;
import java.util.Date;
@Entity
@Table(name = "t_login_log")
public class LoginLog extends BaseDomain {
    @Id
    @Column(name = "login_log_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int loginId;
    @Column(name = "ip")
    private String ip;
    @Column(name = "login_datetime")
    private Date loginDate;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public int getLoginId() {
        return loginId;
    }

    public void setLoginId(int loginId) {
        this.loginId = loginId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public Date getLoginDate() {
        return loginDate;
    }

    public void setLoginDate(Date loginDate) {
        this.loginDate = loginDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
