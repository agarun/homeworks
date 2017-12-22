import React from 'react';
import { withRouter, Link } from 'react-router-dom';

class PokemonIndexItem extends React.Component {
  constructor (props) {
    super(props);
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick () {
    if (parseInt(this.props.match.params.id) !== this.props.poke.id) {
      this.props.history.push(`/pokemon/${this.props.poke.id}`);
    }
  }

  render() {
    return (
      <li className="smallImageForMashu">
        {this.props.poke.id}&nbsp;
        <img src={this.props.poke.image_url} />&nbsp;
        <button onClick={this.handleClick}>{this.props.poke.name}</button>
      </li>
    );
  }
}

// ^^ This used to be a functional componenet, was changed to a class component to
// add in the logic that prevented any components from being re-rendered if the user
// clicked on a link that led to the Pokemon Index Item that we're currently viewing.
// Now, the first loaded Pokemon does not display its details -- maybe refactor to
// display the details properly?

// <Link to={`/pokemon/${poke.id}`}>{poke.name}</Link>
export default withRouter(PokemonIndexItem);
