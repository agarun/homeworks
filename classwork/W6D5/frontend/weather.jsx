import React from 'react';

class Weather extends React.Component {
  constructor(props) {
    super(props);
    this.isLoaded = false;
    this.state = { city: null, temp: null };
  }

  componentDidMount() {
    const currentCoords = navigator.geolocation.getCurrentPosition((response) => {
      const lat = response.coords.latitude;
      const lon = response.coords.longitude;
      const url = `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&APPID=b97eaf3deb12ac2af8fb79826a834f47`;
      const xhr = new XMLHttpRequest();
      xhr.open('GET', url);
      xhr.onload = () => {
        const weatherInfo = JSON.parse(xhr.response);
        const city = weatherInfo.name;
        const temp = (weatherInfo.main.temp - 273.15).toFixed(2);

        this.isLoaded = true;
        this.setState({city, temp});
      };
      xhr.send();
    });
  }

  render() {
    let weatherInfo;

    if (!this.isLoaded) {
      weatherInfo = (
        <div className="loading">loading weather data...</div>
      );
    } else {
      weatherInfo = (
        <section>
          <h1>{this.state.city}</h1>
          <h1>{this.state.temp} degrees celsius</h1>
        </section>
      );
    }

    return (
      <div className='weather'>
        {weatherInfo}
      </div>
    );
  }
}

export default Weather;
