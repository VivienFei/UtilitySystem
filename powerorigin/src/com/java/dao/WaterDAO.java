package com.java.dao;

import java.util.Date;
import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.java.po.Water;

import util.BaseHibernateDAO;

public class WaterDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(WaterDAO.class);
	// property constants
	public static final String USEID = "useid";
	public static final String PRICEID = "priceid";
	

	public void save(Water transientInstance) {
		log.debug("saving Water instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Water persistentInstance) {
		log.debug("deleting Water instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}
	
	public void delete(Integer id) {
		log.debug("deleting Water instance");
		try {
			String hql = "DELETE FROM Water t WHERE t.id=?";
			Query q = getSession().createQuery(hql);
			q.setParameter(0, id);
			q.executeUpdate();
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}
	public Water findById(java.lang.Integer id) {
		log.debug("getting Water instance with id: " + id);
		try {
			Water instance = (Water) getSession().get("com.java.po.Water", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}


	public List findByProperty(String propertyName, Object value) {
		log.debug("finding Water instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from Water as model where model.user.username like'%"+value+"%' or model.user.loginname like '%"+value+"%'";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByUseid(Object useid) {
		return findByProperty(USEID, useid);
	}
	public List findByLoginname(Object useid,String value) {
		try {
			String queryString = "from Water as model where model.user.loginname=? and EXTRACT(YEAR_MONTH FROM model.time)=?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, useid);
			queryObject.setParameter(1, Integer.parseInt(value));
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findAll() {
		log.debug("finding all Water instances");
		try {
			String queryString = "from Water";
			getSession().clear();
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	
	public List findAll(int startrow,int pagesize) {
		log.debug("finding all Water instances");
		try {
			String queryString = "from Water";
			getSession().clear();
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setFirstResult(startrow).setMaxResults(pagesize);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}
	public int getRows()
	{
		log.debug("finding all Water instances");
		try {
			String queryString = "from Water";
			Query queryObject = getSession().createQuery(queryString);
			if(queryObject.list().size()>0)
			return queryObject.list().size();
			return 0;
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public void attachDirty(Water instance) {
		log.debug("attaching dirty Water instance");
		try {
			getSession().saveOrUpdate(instance);
			getSession().flush();
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
	/*
	 * 通过用户id获得用户的缴费列表
	 */
	public List findByUserId( java.lang.Integer id) {
		try {
			String queryString = "from Water as model where model.user.id=?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, id);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
	
	/*
	 * 通过用户id获得用户的缴费列表
	 */
	public Water findByUserLoginname( String loginname) {
		try {
			String queryString = "from Water as model where model.id=(SELECT max( b.id) FROM Water b where b.user.loginname=?)";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, loginname);
			if(queryObject.list().size()>0)
			{
			Water instance =(Water) queryObject.list().get(0);
			return instance;
			}
			return null;
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}
}