import React from 'react';
import PokemonIndexItem from './pokemon_index_item';
import PokemonDetailContainer from './pokemon_detail_container';
import PokemonForm from './pokemon_form';
import { withRouter, Route } from 'react-router-dom';

class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render () {
    const pokemonArray = this.props.pokemon.map ((poke) => {
      return (
        <PokemonIndexItem key={poke.id} poke={poke} />
      );
    });

    return (
      <div>
        <PokemonForm />
        <Route path="/pokemon/:id" component={PokemonDetailContainer} />
        <ul>
          {pokemonArray}
        </ul>
      </div>
    );
  }
}

export default withRouter(PokemonIndex);
