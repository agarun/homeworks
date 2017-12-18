const initialState = {
  baseCurrency: "Please select",
  rates: {}
};

const reducer = (state = initialState, action) => {
  Object.freeze(state);
  switch (action.type) {
    case "SWITCH_CURRENCY":
      return Object.assign(
        {}, state, {
          rates: action.rates,
          baseCurrency: action.baseCurrency
        }
      );
    default:
      return state;
  }
};

export default reducer;
