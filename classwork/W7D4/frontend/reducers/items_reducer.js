import { RECEIVE_A_POKEMON } from '../actions/pokemon_actions';

const itemsReducer = (state = {}, action) => {
  switch (action.type) {
    case RECEIVE_A_POKEMON:
      return action.items;
    default:
      return state;
  }
};

export default itemsReducer;
