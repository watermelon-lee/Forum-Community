package com.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Set;

public class BaseDao<T> {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    private Class entityClass;

    //通过反射获取子类泛型
    public BaseDao() {
        //返回表示此 Class 所表示的实体类的 直接父类 的 Type。注意，是直接父类
        Type type=getClass().getGenericSuperclass();

        //判断是否泛型
        if(type instanceof ParameterizedType){
            //getActualTypeArguments()返回表示此类型实际类型参数的Type对象的数组,这里我们只有一个泛型类.
            // 当有多个泛型类时，数组的长度就不是1了
            ParameterizedType pType=(ParameterizedType)type;
            Type claz=pType.getActualTypeArguments()[0];
            if(claz instanceof Class){
                this.entityClass=(Class<T>)claz;
            }
        }
    }

    //根据ID加载PO实例
    public T load(Serializable id){
        return (T)getHibernateTemplate().load(entityClass,id);
    }
    //根据ID获取实例
    public T get(Serializable id){
        return (T)getHibernateTemplate().get(entityClass,id);
    }
    //获取PO的所有对象
    public Set<T> loadAll(){
        return (Set<T>)getHibernateTemplate().loadAll(entityClass);
    }
    //保存PO
    public void save(T entity){
        getHibernateTemplate().save(entity);
    }
    //删除PO
    public void remoce(T entity){
        getHibernateTemplate().delete(entity);
    }
    //更改Po
    public void update(T entity){
        getHibernateTemplate().update(entity);
    }
    //执行
    //HQL查询
    public List find(String sql){
        return (List)getHibernateTemplate().find(sql);
    }
    //执行带参HQL查询
    /*
    Object...params,java新特性
    这个参数就是不定长的数组（可为null）
    相当于new Object[]{para1, para2, para3 }    这样的形式。
     */
    public List find(String sql,Object... params){
        return (List)getHibernateTemplate().find(sql, params);
    }
    //对延迟加载的实体PO进行初始化

}
