package com.dao;

import com.cons.CommonConstant;
import com.domain.Topic;
import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate4.HibernateTemplate;
import org.springframework.util.Assert;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.unitils.orm.hibernate.HibernateUnitils.getSession;

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
    public List<T> loadAll(){
        return (List<T>)getHibernateTemplate().loadAll(entityClass);
    }
    //保存PO
    public void save(T entity){
        getHibernateTemplate().save(entity);
    }
    //删除PO
    public void remove(T entity){
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

    //分页查询函数,使用HQL
    public Page pageQuery(String hql,int pageNo,int pageSize,Object...params){
        String countQueryString="select count(*) "+removeSelect(removeOrders(hql));
        List countList=getHibernateTemplate().find(countQueryString,params);
        long totalCount=(Long)countList.get(0);
        if(totalCount<1){
            return new Page();
        }
        //实际查询返回分页对象
        int startIndex=Page.getStartOfPage(pageNo,pageSize);
        List list1=getHibernateTemplate().find(hql,params);
        int endIndex=startIndex+CommonConstant.PAGE_SIZE;
        if(endIndex>list1.size()){
            endIndex=list1.size();
        }
        List list=list1.subList(startIndex,endIndex);

        //Query query=createQuery(hql,params);
        //List list=query.setFirstResult(startIndex).setMaxResults(pageSize).list();
        return new Page(pageSize,startIndex,list,totalCount);
    }

    public Page searchQuery(int pageNo,int pageSize,Object...params){
        String hql="from Topic  where topicTitle like '%"+params+"%'";
        String countQueryString="select count(*) "+hql;
        List countList=getHibernateTemplate().find(countQueryString);
        long totalCount=(Long)countList.get(0);
        if(totalCount<1){
            return new Page();
        }
        //实际查询返回分页对象
        int startIndex=Page.getStartOfPage(pageNo,pageSize);
        List list1=getHibernateTemplate().find(hql,params);
        int endIndex=startIndex+CommonConstant.PAGE_SIZE;
        if(endIndex>list1.size()){
            endIndex=list1.size();
        }
        List list=list1.subList(startIndex,endIndex);

        //Query query=createQuery(hql,params);
        //List list=query.setFirstResult(startIndex).setMaxResults(pageSize).list();
        return new Page(pageSize,startIndex,list,totalCount);
    }
    //创建Query对象
//    public Query createQuery(String hql,Object...params){
//        Assert.hasText(hql);
//        Query query=getSession().createQuery(hql);
//        /*
//        通过getSession()取回来的session的flush mode 是FlushMode.NEVER，FlushMode.NEVER只支持read-only()，
//        简而言之就是，只能对数据进行读的操作，其余的操作不被允许。只有当session的类型为FlushMode.AUTO时，
//        才能够进行修改等操作。如果想把session的类型设为FlushMode.AUTO的话，
//        就需要继承OpenSessionInViewFilter类，然后重写这个方法
//         */
//        for(int i=0;i<params.length;i++){
//            query.setParameter(i,params[i]);
//        }
//        return query;
//    }

    //除去Hql的Select子句
    private static String removeSelect(String hql){
        Assert.hasText(hql);
        int beginPos=hql.toLowerCase().indexOf("from");
        Assert.isTrue(beginPos!=-1,"hql:"+hql+"must has a keywords 'from'");
        return hql.substring(beginPos);
    }
    //出去Hql的Order By子句
    private static String removeOrders(String hql){
        Assert.hasText(hql);
        Pattern p=Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",Pattern.CASE_INSENSITIVE);
        Matcher m=p.matcher(hql);
        StringBuffer stringBuffer=new StringBuffer();
        while (m.find()){
            m.appendReplacement(stringBuffer,"");
        }
        m.appendTail(stringBuffer);
        return stringBuffer.toString();
    }
}
