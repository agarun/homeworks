import React from 'react';

export default class TodoForm extends React.Component {
  constructor (props) {
    super(props);
    this.state = { title: '', body: '', done: false };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  uniqueId () {
    return new Date().getTime();
  }

  handleChange (field) {
    return (e) => {
      this.setState({ [field]: e.target.value });
    };
  }

  handleSubmit (e) {
    e.preventDefault();
    const payload = Object.assign({}, this.state);
    this.props.createTodo(payload)
      .then(() => this.setState({title: '', body: ''}));
  }

  render () {
    return (
      <form>
        <div>{ this.props.errors }</div>
        <label>Title
          <input
            onChange={ this.handleChange('title') }
            value={ this.state.title }
          />
        </label>
        <label>Body
          <input
            onChange={ this.handleChange('body') }
            value={ this.state.body }
          />
        </label>
        <button type="submit" onClick={this.handleSubmit}>Add The 2Do</button>
      </form>
    );
  }
}
