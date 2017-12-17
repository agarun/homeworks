import React from 'react';

const Currency = ({name, rate}) => {
  let color = rate < 1 ? "red" : "green";

  return (
    <div className={color}>
      {name}
      &nbsp;
      {rate}
    </div>
  );
};

export default Currency;
