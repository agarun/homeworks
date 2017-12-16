import React from 'react';

const Header = ({ handleClick, selectedId, data }) => {
  const shownClass = 'selected-tab';

  return (
    <header>
    {
      data.map((prop, idx) => (
        <h2 onClick={handleClick(idx)} id={idx === selectedId ? shownClass : ''}>{prop.title}</h2>
      ))
    }
    </header>
  );
};

export default Header;
