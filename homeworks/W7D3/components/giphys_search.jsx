import React from 'react';

import GiphysIndex from './giphys_index';

// renders the search bar and handles all of the search logic
// (keeping track of the query and trigger the AJAX request on submit);
// renders the GiphysIndex.

class GiphysSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = { searchTerm: 'nice car' };
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  componentDidMount() {
    this.props.fetchSearchGiphys('nice+car'); // default. did mount runs once.
  }

  handleChange(e) {
    this.setState({ searchTerm: e.currentTarget.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    const searchTerm = this.state.searchTerm.split(' ').join('+');
    this.props.fetchSearchGiphys(searchTerm);
  }

  render() {
    const { giphys } = this.props;

    return (
      <div>
        <form onSubmit={this.handleSubmit} className="search-bar">
          <input
            value={this.state.searchTerm}
            onChange={this.handleChange}
          />
          <button>Search!</button>
        </form>
        <GiphysIndex giphys={giphys} />
      </div>
    );
  }
}

export default GiphysSearch;
