import React from 'react';
import { withRouter } from 'react-router-dom';
import {createPokemon} from '../../actions/pokemon_actions';

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {

    };
    this.handleSubmit = this.handleSubmit.bind(this);
    this.update = this.update.bind(this);
    this.types = [
      'fire',
      'electric',
      'normal',
      'ghost',
      'psychic',
      'water',
      'bug',
      'dragon',
      'grass',
      'fighting',
      'ice',
      'flying',
      'poison',
      'ground',
      'rock',
      'steel'
    ];
  }

  update(property) {
    return (event) => {
      this.setState({ [property]: event.target.value });
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    createPokemon(this.state).then((newPokemon) => {
      this.props.history.push(`pokemon/${newPokemon.id}`);
    });
  }

  render () {
    return (
      <form onSubmit={this.handleSubmit}>
        <input onChange={this.update('name')}></input>

        <select onChange={this.update('type')}>
          {this.types.map(type => <option value={type}>{type}</option>)}
        </select>

        <input onChange={this.update('attack')}></input>
        <input onChange={this.update('defense')}></input>
        <button>Submit</button>
      </form>
    );
  }
}

export default withRouter(PokemonForm);
