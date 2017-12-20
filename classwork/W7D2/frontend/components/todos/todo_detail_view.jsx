import React from 'react';

const TodoDetailView = ({ deleteTodo, todoItem }) => {
  return (
    <ul>
      <li>{todoItem.body}</li>
      <li>{todoItem.status}</li>
      <button onClick={() => deleteTodo(todoItem)}>Remove</button>
    </ul>
  );
}

export default TodoDetailView;
