import * as EC from '../actions/error_actions';

const _initialState = [];

const errorReducer = (state = _initialState, action) => {
  let newState = [];
  switch (action.type) {
    case EC.RECEIVE_ERRORS:
      // newState[errors] = [...state[errors], action.errors];
      // return Object.assign({}, state, newState);
      // return [...state, action.errors];
      return action.errors.concat(...state);

    case EC.CLEAR_ERRORS:
      return [];

    default:
      return state;
  }
};

export default errorReducer;
