import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {
  constructor(props){
    super(props);
  }

  render(){
    // Phase 3, end: refactor li into todo_list_item.jsx!
    const { todos, receiveTodo, removeTodo } = this.props;
    return (
      <main className="todos">
        <ul>
          {
            todos.map((td, i) =>
            <TodoListItem todo={td}
                          key={i}
                          receiveTodo={receiveTodo}
                          removeTodo={removeTodo}
                          title={td.title} />)
          }
        </ul>
        <TodoForm receiveTodo={receiveTodo} />
      </main>
    );
  }
}

export default TodoList;
