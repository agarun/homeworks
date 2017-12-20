import React from 'react';
import { Provider } from 'react-redux';

import GiphysSearchContainer from './giphys_search_container';

// file structure map
// Root
//   GiphysSearchContainer
//     GiphysSearch
//       GiphysIndex
//        GiphysIndexItem

const Root = ({ store }) => (
  <Provider store={store}>
    <GiphysSearchContainer />
  </Provider>
);

export default Root;
