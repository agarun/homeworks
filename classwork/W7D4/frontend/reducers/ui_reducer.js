import { RECEIVE_A_POKEMON } from '../actions/pokemon_actions';

const uiReducer = (state = {}, action) => {
  switch (action.type) {
    case RECEIVE_A_POKEMON:
      const newPokeType = { ui: { pokeDisplay: action.pokemon.id } };
      return Object.assign({}, state, newPokeType);
    default:
      return state;
  }
};

export default uiReducer;
