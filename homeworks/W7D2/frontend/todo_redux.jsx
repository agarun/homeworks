import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';

import Root from './components/root';

// Middleware fits in between actions and reducers in the Redux cycle
// action object -> intercept -> dispatcher -> reducer @ the store -> state -> cycle

// const addLoggingToDispatch = store => next => action => {
//   console.log('Last state:');
//   console.log(store.getState());
//   console.log('Passed action:');
//   console.log(action);
//   next(action);
//   console.log('New state:');
//   console.log(store.getState());
// };

const applyMiddlewares = (store, ...middlewares) => {
  let dispatch = store.dispatch;
  middlewares.forEach((middleware) => {
    dispatch = middleware(store)(dispatch);
  });
  return Object.assign({}, store, { dispatch });
};

document.addEventListener('DOMContentLoaded', () => {
  const preloadedState = localStorage.state ?
    JSON.parse(localStorage.state) : {};
  let store = configureStore(preloadedState);
  // store = applyMiddlewares(store, addLoggingToDispatch);

  const root = document.getElementById('content');
  ReactDOM.render(<Root store={store} />, root);
});
