<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalTime"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,200" />
<title>@${user.username}</title>
</head>
<style>
	.strikethrough {
	  position: relative;
	  display: inline-block;
	}
	
	.strikethrough::before {
	  content: "";
	  position: absolute;
	  top: 50%;
	  left: -5%;
	  width: 110%;
	  height: 2px;
	  background-color: #dd0031;
	  transform: rotate(-2deg);
	  transform-origin: center;
	  border-radius: 50% / 50%;
	  opacity: 0.8;
	}

	.header-1 {
	  font-size: 72px;
	  font-weight: 400
	}
	
	.header-2 {
	  font-size: 56px;
	  font-weight: 500
	}
	
	.header-3 {
	  font-size: 32px;
	  font-weight: 600
	}
	
	.header-4 {
	  font-size: 16px;
	  font-weight: 600
	}
</style>
<body>

	<div class="m-4">
	
		<div style="display: flex;">
			<div>
			
			<%
				int currentHour = LocalTime.now().getHour();
				String greetingMessage;
				
		        if (currentHour >= 0 && currentHour < 5)
		        	greetingMessage = "Good Night!🌌";
		        else if (currentHour >= 5 && currentHour < 12)
		        	greetingMessage = "Good Morning!🌅";
		        else if (currentHour >= 12 && currentHour < 18)
		        	greetingMessage = "Good Afternoon!😎";
		        else
		        	greetingMessage = "Good Evening!🌇";
			%>
			
				<h1 class="header-1"><%= greetingMessage %></h1>
				<h3 class="header-3">@${user.username}</h3>
				<button class="btn btn-primary mt-5 mb-3" type="submit" data-toggle="modal" data-target="#newTaskModal">New Task</button>
			</div>
		</div>
		

		<table class="table table-hover" border=1>
			<thead class="thead-dark">
				<tr class="text-center header-4">
					<th scope="col">Status</th>
					<th scope="col">
						Task
					</th>
					<th scope="col">
						<span class="material-symbols-outlined">
							priority
						</span>
					</th>
					<th scope="col">
						<span class="material-symbols-outlined">
							update
						</span>
					</th>
					<th scope="col">
						<span class="material-symbols-outlined">
						delete
						</span>
					</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="todo" items = "${listOfTodos}">
					<tr>
						<td class="text-center">
							    <c:if test="${todo.completed}">
							    	<span class="material-symbols-outlined">
										check_box
									</span>
							    </c:if>
    
							    <c:if test="${not todo.completed}">
							    	<span class="material-symbols-outlined">
										check_box_outline_blank
									</span>
							    </c:if>
						</td>
						<td>
								<c:if test="${todo.completed}">
							    	<span class="strikethrough">
						                <c:out value="${todo.task}"></c:out>
						            </span>
							    </c:if>
    
							    <c:if test="${not todo.completed}">
							    	<c:out value="${todo.task}"></c:out>
							    </c:if>
						</td>
						<td class="text-center">
								<c:if test="${todo.completed}">
							        <a type="button" class="btn btn-link" href="/ToDo-MVC/incomplete?id=${todo.id}">Mark as Incomplete</a>
							    </c:if>
    
							    <c:if test="${not todo.completed}">
							        <a type="button" class="btn btn-link" href="/ToDo-MVC/completed?id=${todo.id}">Mark as Completed</a>
							    </c:if>
						</td>
						<td class="text-center">
							<button type="button" class="btn btn-link" data-toggle="modal" data-target="#updateModal" data-todo-id="${todo.id}" data-todo-task="${todo.task}">
								Update
							</button>
						</td>
						<td class="text-center">
							<button type="button" class="btn btn-link" data-toggle="modal" data-target="#deleteModal" data-todo-id="${todo.id}">
								Delete
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody> 
		</table>
	</div>
	
	
	<div class="modal fade" id="newTaskModal" tabindex="-1" role="dialog" aria-labelledby="newTaskModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title" id="newTaskModalLongTitle">✏️ Add New Task!</h5>
				  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="message-text" class="col-form-label">Task:</label>
							<textarea class="form-control" id="message-text"></textarea>
						</div>
			        </form>
				</div>
				<div class="modal-footer">
				  	<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				  	<a id="dynamicNewTaskLink" href="#" class="btn btn-primary">
				  		Create
				  	</a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="updateModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title" id="updateModalLongTitle">✏️ Update</h5>
				  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group">
							<label for="message-text" class="col-form-label">Task:</label>
							<textarea class="form-control" id="message-text"></textarea>
						</div>
			        </form>
				</div>
				<div class="modal-footer">
				  	<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				  	<a id="dynamicUpdateLink" href="#" class="btn btn-primary">
				  		Update
				  	</a>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalTitle" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
				  <h5 class="modal-title" id="deleteModalLongTitle">🔔 Confirmation Required!</h5>
				  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>
				</div>
				<div class="modal-body">
				  Are you certain you wish to proceed with the deletion of this task? 
				  <p>ℹ️ Remember, action cannot be reversible.</p>
				</div>
				<div class="modal-footer">
				  	<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
				  	<a id="dynamicDeleteLink" href="#" class="btn btn-danger">
				  		Delete
				  	</a>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			var todoId, todoTask;
			$('#deleteModal').on('show.bs.modal', function (event) {
				todoId = $(event.relatedTarget).data('todo-id')
				$('#dynamicDeleteLink').attr('href', '/ToDo-MVC/delete?id=' + todoId);
			})
			
			$('#updateModal').on('show.bs.modal', function (event) {
				todoId = $(event.relatedTarget).data('todo-id')
				todoTask = $(event.relatedTarget).data('todo-task')
				$(this).find('.modal-body textarea').val(todoTask)
				$('#dynamicUpdateLink').attr('href', '/ToDo-MVC/update?id=' + todoId);
			})
			
			$('#dynamicUpdateLink').on('click', function () {
		        todoTaskVal = $('#updateModal .modal-body textarea').val();
		        $('#dynamicUpdateLink').attr('href', '/ToDo-MVC/update?id=' + todoId + '&task=' + encodeURIComponent(todoTaskVal));
		    });
			
			$('#dynamicNewTaskLink').on('click', function () {
		        todoTaskVal = $('#newTaskModal .modal-body textarea').val();
		        $('#dynamicNewTaskLink').attr('href', '/ToDo-MVC/add?task=' + encodeURIComponent(todoTaskVal));
		    });
			
	    });
	</script>
	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>