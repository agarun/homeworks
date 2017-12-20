import { allTodos } from '../../reducers/selectors';
import { deleteTodo, updateTodo, createTodo, fetchTodos, receiveTodo, removeTodo, toggleTodo } from '../../actions/todo_actions.js';
import { connect } from 'react-redux';
import TodoList from './todo_list';

const mapStateToProps = state => ({
  todos: allTodos(state),
  errors: state.errors
});

const mapDispatchToProps = dispatch => ({
  // receiveTodo: todo => dispatch(receiveTodo(todo)),
  toggleTodo: todo => dispatch(toggleTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  createTodo: todo => dispatch(createTodo(todo)),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
