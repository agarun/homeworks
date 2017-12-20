import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';


class TodoList extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchTodos();
  }

  render () {
    const {
      receiveTodo,
      deleteTodo,
      toggleTodo,
      createTodo,
      errors
    } = this.props;
    const todoItems = (
      this.props.todos.map(todo => <TodoListItem
                          key={todo.id}
                          todoItem={todo}
                          toggleTodo={ toggleTodo }
                        />)
    );

    return (
      <div>
        <ul>
          {todoItems}
        </ul>
        <TodoForm
          errors={ errors }
          createTodo={createTodo}
         />
      </div>
    );
  }
}

// const TodoList = ({
//   receiveTodo,
//   removeTodo,
//   toggleTodo
// }) => {
//   const todoItems = (
//     todos.map(todo => <TodoListItem
//                         key={todo.id}
//                         todoItem={todo}
//                         removeTodo={ removeTodo }
//                         toggleTodo={ toggleTodo }
//                       />)
//   );
//
//   return (
//     <div>
//       <ul>
//         {todoItems}
//       </ul>
//       <TodoForm receiveTodo={receiveTodo} />
//     </div>
//   );
// };

export default TodoList;
