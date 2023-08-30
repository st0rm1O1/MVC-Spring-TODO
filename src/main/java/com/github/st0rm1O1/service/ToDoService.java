package com.github.st0rm1O1.service;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

import com.github.st0rm1O1.model.ToDoModel;





public class ToDoService {
	
	SessionFactory sessionfactory;
	public ToDoService() {
		this.sessionfactory = new Configuration()
				.configure("hibernate-config.xml")
				.addAnnotatedClass(ToDoModel.class)
				.buildSessionFactory();
	}


}
