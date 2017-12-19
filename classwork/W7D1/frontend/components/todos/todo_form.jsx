import React from 'react';

export default class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { id: null, title: '', done: false };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  uniqueId() {
    return new Date().getTime();
  }

  handleChange(e) {
    const title = e.target.value;
    this.setState({ title });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.setState({ id: this.uniqueId() }, () =>    this.props.receiveTodo(this.state));
  }

  render() {
    return (
      <form>
        <input onChange={this.handleChange} />
        <button type="submit" onClick={this.handleSubmit}>Add The 2Do</button>
      </form>
    );
  }
}
