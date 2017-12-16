import React from 'react';

class Autocomplete extends React.Component {
  constructor(props) {
    super(props);
    this.state = { inputVal: '' };
    this.updateNames = this.updateNames.bind(this);
    this.selectName = this.selectName.bind(this);
  }

  updateNames(e) {
    e.preventDefault();
    const inputVal = e.target.value;
    this.setState({ inputVal });
  }

  selectName(e) {
    e.preventDefault();
    const inputVal = e.target.innerHTML;
    this.setState({ inputVal });
  }

  render() {
    let matchedNames = this.props.data.filter(name => name.toLowerCase().includes(this.state.inputVal.toLowerCase()));
    matchedNames = matchedNames.map((name, idx) => {
      return (
        <li onClick={this.selectName} key={idx}>{name}</li>
      );
    });

    return (
      <div className='autocomplete'>
        <input onChange={this.updateNames} value={this.state.inputVal} placeholder="Search..." />
        <ul>
          {matchedNames}
        </ul>
      </div>
    );
  }
}

export default Autocomplete;
