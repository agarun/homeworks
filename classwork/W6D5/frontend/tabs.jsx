import React from 'react';
import Header from './header';

class Tabs extends React.Component {
  constructor(props) {
    super(props);

    this.state = { selectedTabIdx: 0 };
    this.handleClick = this.handleClick.bind(this);
  }

  handleClick(idx) {
    return (e) => {
      e.target.setAttribute('id', 'selected-tab');
      const selectedTabIdx = parseInt(idx);
      this.setState({ selectedTabIdx });
    };
  }

  render() {
    const tabIdx = this.state.selectedTabIdx;
    const selectedTab = this.props.data[tabIdx];
    const renderedContent = (
      <ul className="header-tabs">
        <Header handleClick={this.handleClick} data={this.props.data} selectedId={tabIdx} />
        <article>{selectedTab.content}</article>
      </ul>
    );

    return (
      <div className="tab-collection">
        {renderedContent}
      </div>
    );
  }
}

export default Tabs;
