export const fetchAllPokemon = () => {
  return $.ajax({
    url: '/api/pokemon',
    method: 'get'
  });
};

export const fetchPokemon = (pokemonId) => {
  return $.ajax({
    url: `api/pokemon/${pokemonId}`,
    method: 'get'
  });
};

export const postPokemon = (pokemon) => {
  return $.ajax({
    url: '/api/pokemon',
    method: 'post',
    data: {
      pokemon
    }
  });
};
