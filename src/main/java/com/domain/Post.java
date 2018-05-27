package com.domain;


import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "t_post")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)//映射继承,构成一张表
@DiscriminatorColumn(name = "post_type",discriminatorType = DiscriminatorType.STRING)
@DiscriminatorValue("1")
public class Post extends BaseDomain{

    @Id
    @Column(name = "post_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int postId;
//    private int postType;
    @Column(name = "post_title")
    private String postTitle;
    @Column(name = "post_text")
    private String postText;
    @Column(name = "create_time")
    private Date createTime;
    @Column(name = "board_id")
    private int boardId;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    @ManyToOne(cascade = {CascadeType.PERSIST,CascadeType.MERGE})
    @JoinColumn(name = "topic_id")
    private Topic topic;

    public int getBoardId() {
        return boardId;
    }

    public void setBoardId(int boardId) {
        this.boardId = boardId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

//    public int getPostType() {
//        return postType;
//    }
//
//    public void setPostType(int postType) {
//        this.postType = postType;
//    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostText() {
        return postText;
    }

    public void setPostText(String postText) {
        this.postText = postText;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
