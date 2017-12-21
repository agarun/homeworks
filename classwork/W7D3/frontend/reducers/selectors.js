const selectAllPokemon = (state) => {
  const pokesArray = [];
  Object.keys(state.entities.pokemon).forEach((poke) => {
    pokesArray.push(state.entities.pokemon[poke]);
  });
  return pokesArray;
};

export default selectAllPokemon;
