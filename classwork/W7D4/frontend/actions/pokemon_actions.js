import * as APIUtil from '../util/api_util';

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_A_POKEMON = "RECEIVE_A_POKEMON";

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receivePokemon = (pokemon, items) => ({
  type: RECEIVE_A_POKEMON,
  pokemon,
  items
});

export const createPokemon = (pokemon) => (dispatch) => (
	APIUtil
    .postPokemon(pokemon)
    .then(pokemon => {
	    dispatch(receivePokemon(pokemon));
      return pokemon;
	  })
);

export const requestAllPokemon = () => (dispatch) => {
  return (
    APIUtil
      .fetchAllPokemon()
      .then(pokemon => dispatch(receiveAllPokemon(pokemon)))
  );
};

export const requestPokemon = (pokemonId) => (dispatch) => {
  return (
    APIUtil
      .fetchPokemon(pokemonId)
      .then((response) => {
        const items = response.items;
        const pokemon = response.pokemon;
        return dispatch(receivePokemon(pokemon, items));
      })
  );
};
