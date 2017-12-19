import { allTodos } from '../../reducers/selectors';
import { receiveTodo, removeTodo, toggleTodo } from '../../actions/todo_actions.js';
import { connect } from 'react-redux';
import TodoList from './todo_list';

const mapStateToProps = state => ({
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: todo => dispatch(receiveTodo(todo)),
  removeTodo: todo => dispatch(removeTodo(todo)),
  toggleTodo: todo => dispatch(toggleTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
