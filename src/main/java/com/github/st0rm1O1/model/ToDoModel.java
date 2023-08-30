package com.github.st0rm1O1.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;



@Entity(name = "todo")
public class ToDoModel {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "todo_id")
	public int id;
	
	@Column(name = "todo_task")
	public String task;
	
	@Column(name = "todo_completed")
	public boolean completed;
	
	
	
	public ToDoModel(int id, String task, boolean completed) {
		super();
		this.id = id;
		this.task = task;
		this.completed = completed;
	}

	
	
//	GETTERS
	public int getId() {
		return id;
	}

	public String getTask() {
		return task;
	}

	public boolean isCompleted() {
		return completed;
	}
	
	
	
//	SETTERS
	public void setId(int id) {
		this.id = id;
	}

	public void setTask(String task) {
		this.task = task;
	}

	public void setCompleted(boolean completed) {
		this.completed = completed;
	}

}
