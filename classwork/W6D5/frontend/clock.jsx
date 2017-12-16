import React from 'react';

class Clock extends React.Component {
  constructor(props) {
    super(props);

    this.state = { date: new Date() };

    this.tick = this.tick.bind(this);
  }

  componentDidMount() {
    this.intervalId = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    clearInterval(this.intervalId);
  }

  tick() {
    const date = new Date();
    this.setState({ date });
  }

  render() {
    const formattedDate = this.state.date.toString().slice(0, 15);
    const formattedTime = this.state.date.toLocaleTimeString();
    return (
      <div>
        <div className="clock">
          <section className="time">
            <p>Time: </p>
            <p>{formattedTime}</p>
          </section>
          <section className="date">
            <p>Date: </p>
            <p>{formattedDate}</p>
          </section>
        </div>
      </div>
    );
  }
}

export default Clock;
