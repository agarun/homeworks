import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO, TOGGLE_TODO } from '../actions/todo_actions';
import { receiveTodos, receiveTodo } from '../actions/todo_actions';

const _initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    status: 'slippery',
    done: false
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    status: 'wet',
    done: true
  },
  3: {
    id: 3,
    title: 'washing the car w the dog',
    body: 'with shampoo and soap',
    status: 'slippery and wet homie',
    done: false
  },
};

const todosReducer = (state = _initialState, action) => {
  let newState = {};
  switch (action.type) {
    case RECEIVE_TODOS:
      action.todos.forEach((todo) => {
        newState[todo.id] = todo;
      });
      return Object.assign({}, state, newState);

    case RECEIVE_TODO:
      newState[action.todo.id] = action.todo;
      const newTodo = {[action.todo.id]: action.todo};
      return Object.assign({}, state, newState);

    case REMOVE_TODO:
      newState = Object.assign({}, state);
      delete newState[action.todo.id];
      return newState;

    case TOGGLE_TODO:
      newState = Object.assign({}, state);
      newState[action.todo.id].done = !action.todo.done;
      return newState;
    default:
      return state;
  }
};

export default todosReducer;

// const todos = [{id: 4, title: 'hey hacker dawg'}, {id: 5, title: 'hack daddy'}]
