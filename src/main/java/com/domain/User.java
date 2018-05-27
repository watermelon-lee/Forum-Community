package com.domain;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

@Entity
@Table(name = "t_user")
public class User extends BaseDomain {
    /*
        锁定用户对应状态值
     */
    public static final int USER_LOCK=1;
    /*
    用户解锁状态值
     */
    public static final int USER_UNLOCK=0;
    /*
        管理员类型
     */
    public static final int FORUM_ADMIN=2;
    /*
        普通用户类型
     */
    public static final int NORMAL_USER=1;
    @Id
    @Column(name = "user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;
    @Column(name = "user_name")
    private String userName;
    @Column(name = "password")
    private String password;
    @Column(name = "user_type")
    private int userType;
    @Column(name = "locked")
    private int locked;
    @Column(name = "credit")
    private int credit;
    @Column(name = "last_visit")
    private Date lastVisit;
    @Column(name = "last_ip")
    private String lastIp;

    @ManyToMany(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
    // 映射连接表中名为user_id的外键列
    // 映射连接表中名为board_id的外键列
    @JoinTable(name = "t_board_manager", joinColumns = {@JoinColumn(name ="user_id" )}, inverseJoinColumns = {@JoinColumn(name = "board_id") })
    private Set<Board>manBoards;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getUserType() {
        return userType;
    }

    public void setUserType(int userType) {
        this.userType = userType;
    }

    public int getLocked() {
        return locked;
    }

    public void setLocked(int locked) {
        this.locked = locked;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public Date getLastVisit() {
        return lastVisit;
    }

    public void setLastVisit(Date lastVisit) {
        this.lastVisit = lastVisit;
    }

    public String getLastIp() {
        return lastIp;
    }

    public void setLastIp(String lastIp) {
        this.lastIp = lastIp;
    }

    public Set<Board> getManBoards() {
        return manBoards;
    }

    public void setManBoards(Set<Board> manBoards) {
        this.manBoards = manBoards;
    }
}
