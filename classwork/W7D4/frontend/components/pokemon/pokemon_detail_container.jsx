import {connect} from 'react-redux';
import React from 'react';
import PokemonDetail from './pokemon_detail';
import { requestPokemon } from '../../actions/pokemon_actions';

const mapStateToProps = (state, ownProps) => {
  const pokemonId = parseInt(ownProps.match.params.id);
  return {
    pokemonId,
    pokemon: state.entities.pokemon[pokemonId],
    items: state.entities.items
  };
};

const mapDispatchToProps = dispatch => ({
  requestPokemon: (pokemonId) => dispatch(requestPokemon(pokemonId))
});

export default connect(mapStateToProps, mapDispatchToProps)(PokemonDetail);
