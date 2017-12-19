import { createStore } from 'redux';
import { applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';

// Middleware fits in between actions and reducers in the Redux cycle
// action object -> intercept -> dispatcher -> reducer @ the store -> state -> cycle

const addLoggingToDispatch = store => next => action => {
  console.log('Last state:');
  console.log(store.getState());
  console.log('Passed action:');
  console.log(action);
  console.log('Next param is:');
  console.log(next);
  next(action);
  console.log('New state:');
  console.log(store.getState());
};

const configureStore = (preloadedState = {}) => {
  const store = createStore(rootReducer, preloadedState, applyMiddleware(addLoggingToDispatch));
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });
  return store;
}

export default configureStore;
