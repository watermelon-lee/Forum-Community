package com.domain;

import org.apache.commons.lang.builder.ToStringBuilder;

import java.io.Serializable;

//实现序列化,方便JVM序列化POJO
public class BaseDomain implements Serializable {
    //重写统一的ToString,通过Apache的ToStringBuilder工具类实现
    /*
    项目中一般都需要打印日志，所有实体的toString()方法都是用简单的"+"，
    因为每"＋" 一个就会 new 一个 String 对象，这样如果系统内存小的话会暴内存。
    使用ToStringBuilder就可以避免暴内存这种问题。
     */
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
