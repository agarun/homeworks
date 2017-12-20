import React from 'react';
import TodoDetailView from './todo_detail_view_container';

class TodoListItem extends React.Component {
  constructor (props) {
    super (props);
    this.state = { detail: false };
    this.toggleDetail = this.toggleDetail.bind(this);
  }

  toggleDetail () {
    this.setState({ detail: !this.state.detail});
  }

  render () {
    const todoItem = this.props.todoItem;
    const completed = todoItem.done ? "Done" : "Not Done";
    const detail = this.state.detail ?
      <TodoDetailView
        todoItem={todoItem}
        deleteTodo={this.props.deleteTodo}
      /> 
      : '';
    return (
      <li>
        <h4 onClick={ this.toggleDetail }>{todoItem.title}</h4>
        <button onClick={() => this.props.toggleTodo(todoItem)}>{ completed }</button>
        {detail}
      </li>
    );
  }
}

export default TodoListItem;

// const TodoListItem = ({ toggleTodo, removeTodo, todoItem }) => {
//   const detailView =
//
//   const completed = todoItem.done ? "Done" : "Not Done";
//   return (
//     <li>
//       {todoItem.title}
//       <button onClick={() => toggleTodo(todoItem)}>{completed}</button>
//     </li>
//   );
