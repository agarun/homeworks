import * as TodoApiUtil from '../util/todo_api_util';
import { receiveErrors, clearErrors } from './error_actions';

export const RECEIVE_TODOS = 'RECEIVE_TODOS';
export const RECEIVE_TODO = 'RECEIVE_TODO';
export const REMOVE_TODO = 'REMOVE_TODO';
export const TOGGLE_TODO = 'TOGGLE_TODO';

export const receiveTodos = (todos) => ({
  type: RECEIVE_TODOS,
  todos
});

export const receiveTodo = (todo) => ({
  type: RECEIVE_TODO,
  todo
});

export const removeTodo = (todo) => ({
  type: REMOVE_TODO,
  todo
});

// export const toggleTodo = (todo) => ({
//   type: TOGGLE_TODO,
//   todo
// });

export const fetchTodos = () => (dispatch) => {
  return TodoApiUtil.fetchTodos().then(todos => {
    return dispatch(receiveTodos(todos));
  });
};

export const createTodo = (todo) => (dispatch) => {
  return TodoApiUtil.createTodo(todo).then(
    response => {
      dispatch(clearErrors());
      return dispatch(receiveTodo(response));
    },
    failure => {
      return dispatch(receiveErrors(failure.responseJSON));
    }
  );
};

export const updateTodo = (todo) => (dispatch) => {
  return TodoApiUtil.updateTodo(todo).then(
    response => {
      dispatch(clearErrors());
      return dispatch(receiveTodo(response));
    },
    failure => {
      return dispatch(receiveErrors(failure.responseJSON));
    }
  );
};

export const toggleTodo = (todo) => {
  todo.done = !todo.done;
  return updateTodo(todo);
  // return ({
  //   type: TOGGLE_TODO,
  //   todo
  // });
};

export const deleteTodo = (todo) => (dispatch) => {
  return TodoApiUtil.removeTodo(todo).then(
    response => {
      dispatch(clearErrors());
      return dispatch(removeTodo(response));
    },
    failure => {
      return dispatch(receiveErrors(failure.responseJSON));
    }
  );
};
