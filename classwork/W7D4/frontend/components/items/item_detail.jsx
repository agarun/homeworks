import React from 'react';

class ItemDetail extends React.Component {
  render () {
    return (
      <ul className="item-detail">
        <li>Name: {this.props.item.name}</li>
        <li>Price: {this.props.item.price}</li>
        <li>Happiness: {this.props.item.happiness}</li>
      </ul>
    );
  }
}

export default ItemDetail;
