import rootReducer from '../reducers/root_reducer';
import {applyMiddleware, createStore} from 'redux';
import logger from 'redux-logger';
import thunk from '../middleware/thunk';

const configureStore = () => createStore(rootReducer, applyMiddleware(thunk, logger));

export default configureStore;
