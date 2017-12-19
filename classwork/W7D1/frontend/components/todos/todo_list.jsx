import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

const TodoList = ({
  todos,
  receiveTodo,
  removeTodo,
  toggleTodo
}) => {
  const todoItems = (
    todos.map(todo => (
      <TodoListItem
        key={todo.id}
        todoItem={todo}
        removeTodo={removeTodo}
        toggleTodo={toggleTodo}
      />
    ))
  );

  return (
    <div>
      <ul>
        {todoItems}
      </ul>
      <TodoForm receiveTodo={receiveTodo} />
    </div>
  );
};

export default TodoList;
