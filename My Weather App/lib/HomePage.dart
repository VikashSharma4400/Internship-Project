import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myweather/constants.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  final String selectedCity;
  const HomePage({super.key, required this.selectedCity});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final weatherValue = await _wf.currentWeatherByCityName(widget.selectedCity);
    setState(() {
      _weather = weatherValue;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: build_ui(),
    );
  }

  Widget build_ui() {
    if(_weather == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 12),
            locationHeader(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            weatherTimeInfo(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            weatherIcon(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            temperatureInfo(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            extraInfo(),
          ],
        ),
      ),
    );
  }

  Widget locationHeader() {
    return Text(_weather?.areaName ?? "",
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );
  }

  Widget weatherTimeInfo() {
    DateTime time = _weather!.date!;
    return Column(
      children: [
        Text(DateFormat("hh:mm a").format(time),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(DateFormat("EEEE").format(time),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            Text("  ${DateFormat("dd/MM/yyy").format(time)}",
              style: const TextStyle(fontWeight: FontWeight.w400),
            )
          ],
        ),
      ],
    );
  }

  Widget weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(_weather?.weatherDescription ?? "",
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ]
    );
  }

  Widget temperatureInfo() {
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(2)}° C",
      style: const TextStyle(
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget extraInfo() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
