import React from 'react';

const TodoDetailView = ({ removeTodo, todoItem }) => {
  return (
    <ul>
      <li>{todoItem.body}</li>
      <li>{todoItem.status}</li>
      <button onClick={() => removeTodo(todoItem)}>Remove</button>
    </ul>
  );
}

export default TodoDetailView;
