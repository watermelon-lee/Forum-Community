package com.dao;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Repository
public class Page implements Serializable {

    private static int DEFAULT_PAGE_SIZE=20;
    private int pageSize;//每页记录数
    private long start;//当前页面第一条在list中的位置,从0开始
    private List data;//当前页面中存放的记录
    private long totalCount;//总记录数

    public Page(int pageSize, long start, List data, long totalCount) {
        this.pageSize = pageSize;
        this.start = start;
        this.data = data;
        this.totalCount = totalCount;
    }

    public Page() {
        this(DEFAULT_PAGE_SIZE,0,new ArrayList(),0);
    }

    //取总页数
    public long getTotalPageCount(){
        if(totalCount%pageSize==0){
            return totalCount/pageSize;
        }else {
            return totalCount/pageSize+1;
        }
    }
    //取话题
    public List getResult() {
        return data;
    }

    //取该页当前页码,页码从1开始
    public long getCurrentPageNo() {
        return start / pageSize + 1;
    }
    //该页是否还有下一页
    public boolean isHasNextPage(){
        return getCurrentPageNo()<getTotalPageCount();
    }
    //该页是否还有上一页
    public boolean isHasPreviousPage(){
        return getCurrentPageNo()>1;
    }
    //获取任意一页第一条数据在数据集中的位置,页面条数数使用默认值
    public static int getStartOfPage(int pageNo){
        return getStartOfPage(pageNo,DEFAULT_PAGE_SIZE);
    }
    //获取任意一页第一条数据在数据集中的位置
    public static int getStartOfPage(int pageNo,int pageSize){
        return (pageNo-1)*pageSize;
    }
}
