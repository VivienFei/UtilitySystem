package com.java.dao;

import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.java.po.Admin;
import com.java.po.User;

import util.BaseHibernateDAO;

/**
 * @author fjj1213
 */

public class UserDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(UserDAO.class);
	// property constants
	public static final String LOGINNAME = "loginname";


	public void save(User transientInstance) {
		log.debug("saving User instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}
 
	public void delete(Integer id) {
		log.debug("deleting User instance");
		try {
			String hql = "DELETE FROM User t WHERE t.id=?";
			Query q = getSession().createQuery(hql);
			q.setParameter(0, id);
			q.executeUpdate();
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}
	public User findById(java.lang.Integer id) {
		log.debug("getting User instance with id: " + id);
		try {
			User instance = (User) getSession().get("com.java.po.User", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

 

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding User instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from User as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

 
	public User findByLoginname(Object loginname) {
		try {
			String queryString = "from User as model where model."
					+ LOGINNAME + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, loginname);
			if(queryObject.list().size()>0)
			{
				return (User) queryObject.list().get(0);
			}
			return null;
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
 

	public List findAll() {
		log.debug("finding all User instances");
		try {
			String queryString = "from User";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
 
	public List findAll(int startrow,int pagesize) {
		log.debug("finding all User instances");
		try {
			String queryString = "from User";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setFirstResult(startrow).setMaxResults(pagesize);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	public void attachDirty(User instance) {
		log.debug("attaching dirty User instance");
		try {
			getSession().saveOrUpdate(instance);
			getSession().flush();
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
	public int getRows()
	{
		String queryString = "select count(*) from User";
		Query queryObject = getSession().createQuery(queryString);
		return   Integer.parseInt(queryObject.list().get(0).toString());
	}
 
}