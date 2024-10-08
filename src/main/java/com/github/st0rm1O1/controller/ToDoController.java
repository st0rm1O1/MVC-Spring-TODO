package com.github.st0rm1O1.controller;

import java.util.*;
import java.util.stream.Collectors;

//import jakarta.annotation.PostConstruct;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.st0rm1O1.model.ToDoModel;
import com.github.st0rm1O1.model.UserModel;





@Controller
public class ToDoController {
	
	private static TreeMap<Integer, ToDoModel> listOfTodos;
	
	
//    @PostConstruct
    public void init() {
		listOfTodos = new TreeMap<>();
		listOfTodos.put(1, new ToDoModel(1, "Finish reading a classic novel.", false));
		listOfTodos.put(2, new ToDoModel(2, "Learn to play a musical instrument.", false));
		listOfTodos.put(3, new ToDoModel(3, "Visit a country you've never been to before.", true));
		listOfTodos.put(4, new ToDoModel(4, "Try a new cuisine or cooking technique.", false));
		listOfTodos.put(5, new ToDoModel(5, "Start a daily mindfulness or meditation practice.", true));
		listOfTodos.put(6, new ToDoModel(6, "Learn a new language or improve your language skills.", false));
		listOfTodos.put(7, new ToDoModel(7, "Take up a new sport or physical activity.", false));
		listOfTodos.put(8, new ToDoModel(8, "Volunteer for a charitable organization.", false));
		listOfTodos.put(9, new ToDoModel(9, "Learn a new programming language or technology.", true));
		listOfTodos.put(10, new ToDoModel(10, "Create a personal website or blog to share your interests.", false));
    }
	
	
	
//	VIEW	
	@RequestMapping(path = {"/", "/home", "/index", "/dash", "/dashboard"}, method = RequestMethod.GET)
	public ModelAndView dash() {
		if (null == listOfTodos) {
			init();
		}

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("index");		
		modelAndView.addObject("listOfTodos", listOfTodos.descendingMap().values());
		modelAndView.addObject("user", new UserModel("550e8400-e29b-41d4-a716-446655440000", "st0rm1O1", "thekunalvartak@gmail.com", "alien"));
		return modelAndView;
	}
	
	
	
	
	
//	ACTION
	@RequestMapping(path = "/add", method = RequestMethod.GET)
	public String add(@RequestParam("task") String todoTask) {
		int todoId = listOfTodos.lastKey() + 1;
		todoTask = StringUtils.isEmpty(todoTask) ? "TODO" : todoTask;
		listOfTodos.putIfAbsent(todoId, new ToDoModel(todoId, todoTask, false));
		return "redirect:/";
	}
	
	
	@RequestMapping(path = "/update", method = RequestMethod.GET)
	public String update(@RequestParam("id") Integer todoId, @RequestParam("task") String todoTask) {
		todoTask = StringUtils.isEmpty(todoTask) ? "TODO" : todoTask;
		updateTodo(todoId, todoTask, null);
		return "redirect:/";
	}
	
	
	@RequestMapping(path = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("id") Integer todoId) {
		listOfTodos.remove(todoId);
		return "redirect:/";
	}
	
	
	@RequestMapping(path = "/completed", method = RequestMethod.GET)
	public String markAsDone(@RequestParam("id") Integer todoId) {
		updateTodo(todoId, null, true);
		return "redirect:/";
	}
	
	
	@RequestMapping(path = "/incomplete", method = RequestMethod.GET)
	public String markAsNotDone(@RequestParam("id") Integer todoId) {
		updateTodo(todoId, null, false);
		return "redirect:/";
	}
	
	
	
	
	
//	UTILS
	private void updateTodo(int todoId, String todoTask, Boolean isCompleted) {
		listOfTodos.computeIfPresent(todoId, (id, todo) -> {
			if (todoTask != null) {
				todo.setTask(todoTask);
			}

			if (isCompleted != null) {
				todo.setCompleted(isCompleted);
			}

			return todo;
		});
	}
	

}
