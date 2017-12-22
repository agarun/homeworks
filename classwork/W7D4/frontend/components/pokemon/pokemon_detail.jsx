import React from 'react';
import {Link, Route} from 'react-router-dom';
import ItemDetailContainer from '../items/item_detail_container';

class PokemonDetail extends React.Component {
  componentDidMount () {
    this.props.requestPokemon(this.props.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (this.props.pokemonId !== newProps.pokemonId) {
      this.props.requestPokemon(newProps.pokemonId);
    }
  }

  render () {
    if (typeof this.props.pokemon === 'undefined') {
      return <div></div>;
    }

    const itemsImageArr = Object.keys(this.props.items).map((itemKey) => {
      const item = this.props.items[itemKey];
      return (
        <li>
          <Link to={`/pokemon/${this.props.pokemon.id}/items/${item.id}`}>
            <img className="small-image" src={item.image_url} />
          </Link>
        </li>
      );
    });
    return (
      <section className="pokemon-detail">
        <ul>
          <figure><img className="big-image" src={this.props.pokemon.image_url} /></figure>
          <li><h2>{this.props.pokemon.name}</h2></li>
          <li>Type: {this.props.pokemon.poke_type}</li>
          <li>Attack: {this.props.pokemon.attack}</li>
          <li>Defense: {this.props.pokemon.defense}</li>
          <li>Moves: {this.props.pokemon.moves}</li>
        </ul>

        <section className="items">
          <h2>Items</h2>
          <ul>
            {itemsImageArr}
            <Route path='/pokemon/:id/items/:itemId' component={ItemDetailContainer} />
          </ul>
        </section>
      </section>
    );
  }
}

export default PokemonDetail;
