import React from 'react';
import Clock from './frontend/clock';
import Tabs from './frontend/tabs';
import Weather from './frontend/weather';
import Autocomplete from './frontend/autocomplete';

class Root extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <div>
        <h1>Awesome Clock</h1>
        <Clock />
        <h1>Amazing Tabs</h1>

        <Tabs data={
          [
            {
              title: 'Pane 1',
              content: 'This is the first tab.'
            },
            {
              title: 'Pane 2',
              content: 'This is the second tab.'
            },
            {
              title: 'Pane 3',
              content: 'This is the third tab.'
            }
          ]
        } />
        <h1>Awe-inspiring Weather</h1>
        <Weather />
        <h1>Astonishing Autocomplete</h1>
        <Autocomplete data={
          [
            'Barbara',
            'Andrew',
            'Gregory',
            'Aaron',
            'Tim',
            'Bryan',
            'Morgan',
            'Marquee',
            'Mike',
            'Sunny',
            'Kevin',
            'Dae',
            'Brice',
            'Alex',
            'John'
          ]
        } />
      </div>
    );
  }
}

export default Root;
