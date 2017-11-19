package com.java.dao;

import java.util.Date;
import java.util.List;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.java.po.Money;

import util.BaseHibernateDAO;


public class MoneyDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(MoneyDAO.class);
	// property constants

	public void save(Money transientInstance) {
		log.debug("saving Money instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(Money persistentInstance) {
		log.debug("deleting Money instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}
	public void delete(Integer id) {
		log.debug("deleting Company instance");
		try {
			String hql = "DELETE FROM Money t WHERE t.id=?";
			Query q = getSession().createQuery(hql);
			q.setParameter(0, id);
			q.executeUpdate();
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}
	public Money findLastById() {
		try {
			String hql = " FROM Money t WHERE t.id=(SELECT max( b.id) FROM Money b)";
			Query q = getSession().createQuery(hql);
			if(q.list().isEmpty()){
				return null;
			}
			Money instance = (Money) q.list().get(0);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public Money findById(java.lang.Integer id ) {
		log.debug("getting Money instance with id: " + id);
		try {
			Money instance = (Money) getSession().get("com.java.po.Money", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}


	public List findByProperty(String value) {
	 
		try {
			String queryString = "from Money model where  EXTRACT(YEAR_MONTH FROM model.time)>=?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, Integer.parseInt(value));
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findAll() {
		log.debug("finding all Money instances");
		try {
			String queryString = "from Money";
			getSession().clear();
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}



	public void attachDirty(Money instance) {
		log.debug("attaching dirty Money instance");
		try {
			getSession().close();
			getSession().saveOrUpdate(instance);
			getSession().flush();
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
	
//	public void attachDirtyById(java.lang.Integer id ) {
//		log.debug("attaching dirty Money instance");
//		try {
//			String queryString = "update Money model set model.isactive='Y'  where model.id=?";
//			Query queryObject = getSession().createQuery(queryString);
//			queryObject.setParameter(0, id);
//			queryObject.executeUpdate();
//			log.debug("attach successful");
//		} catch (RuntimeException re) {
//			log.error("attach failed", re);
//			throw re;
//		}
//	}

}