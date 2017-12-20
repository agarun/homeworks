export const allTodos = ({ todos }) => (
  Object.keys(todos).map(todoId => todos[todoId])
);
