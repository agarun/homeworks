import React from 'react';
import {connect} from 'react-redux';
import ItemDetail from './item_detail';

const mapStateToProps = (state, ownProps) => {
  const itemId = parseInt(ownProps.match.params.itemId);
  return {
    itemId,
    item: state.entities.items[itemId]
  };
};

const mapDispatchToProps = (state) => {

};

export default connect(mapStateToProps)(ItemDetail);
