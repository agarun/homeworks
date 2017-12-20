import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';
import { thunk } from '../middleware/thunk';

const middlewares = [
  thunk
];

const configureStore = createStore(
  rootReducer,
  {},
  applyMiddleware(...middlewares)
);

export default configureStore;
