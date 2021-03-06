import React from "react";
import allTodos from "../../reducers/selectors";
import {
  receiveTodo, receiveTodos, removeTodo
} from "../../actions/todo_actions";
import { connect } from "react-redux";
import TodoList from "./todo_list.jsx";

const mapStateToProps = (state) => ({
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  receiveTodos: (todos) => dispatch(receiveTodos(todos)),
  removeTodo: (todo) => dispatch(removeTodo(todo))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(TodoList);
