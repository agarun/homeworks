import React from 'react';

class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render () {
    const pokemonArray = this.props.pokemon.map ((poke) => {
      return (
        <li key={poke.id} className="smallImageForMashu">
          {poke.id}&nbsp;<img src={poke.image_url} />&nbsp;{poke.name}
        </li>
      );
    });

    return (
      <ul>
        {pokemonArray}
      </ul>
    );
  }
}

export default PokemonIndex;
