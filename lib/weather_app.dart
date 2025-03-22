import 'package:flutter/material.dart';
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2548693782.
import 'package:http/http.dart' as http;
import 'package:weather_app_api/secrets.dart';
import 'dart:convert';
import 'package:weather_app_api/widgets/custom_column.dart';
import 'package:weather_app_api/widgets/custom_container.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
    getWeather();
  }

  String cityName = 'Erbil';
  final TextEditingController _controller = TextEditingController();
  Future<Map<String, dynamic>> getWeather() async {
    try {
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$myAPIKey'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != 200) {
        throw 'Unexpected error occured';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

// Suggested code may be subject to a license. Learn more: ~LicenseLog:2342605839.
  @override
  Widget build(BuildContext context) {
    // final List<String> times = [
    //   '10:00',
    //   '11:00',
    //   '12:00',
    //   '13:00',
    //   '14:00',
    //   '15:00',
    //   '16:00',
    //   '17:00',
    //   '18:00',
    //   '19:00',
    //   '20:00',
    //   '21:00',
    // ];
    // final List<String> conditions = [
    //   'Rain',
    //   'Cloudy',
    //   'Sunny',
    //   'Foggy',
    //   'Sunny',
    //   'Rain',
    //   'Cloudy',
    //   'Sunny',
    //   'Foggy',
    //   'Sunny',
    //   'Rain',
    //   'Cloudy',
    // ];
    // final List<IconData> icons = [
    //   Icons.cloud,
    //   Icons.cloud,
    //   Icons.sunny,
    //   Icons.foggy,
    //   Icons.sunny,
    //   Icons.cloud,
    //   Icons.cloud,
    //   Icons.sunny,
    //   Icons.foggy,
    //   Icons.sunny,
    //   Icons.cloud,
    //   Icons.cloud,
    // ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator
                  .adaptive(), // the adaptive is for the loading icon that changes in android and ios
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data;

          // This is for converting Kelvin to Celsius.
          double temp = data!['main']['temp'];
          temp -= 273.15;

          final int humidity = data['main']['humidity'];
          final int windSpeed = data['wind']['speed'].toInt();
          final int pressure = data['main']['pressure'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search for your city',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter your city',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (val) {
                      setState(() {
                        cityName = _controller.text;
                        _controller.clear();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    cityName, // its valuse is static because tht API doesnt contain the forecast data.
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomContainer(
                    condition: data['weather'][0]['main'],
                    degree: '${temp.toStringAsFixed(0)}°C',
                    heights: 200,
                    sizes: 60,
                    fontSize: 35,
                    conditionFontSize: 20,
                    icon: data['weather'][0]['main'] == 'clouds' ||
                            data['weather'][0]['main'] == 'rain'
                        ? Icons.cloud
                        : Icons.sunny,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // i can uncomment it when i use listview
                  // const Text(
                  //   'Weather Forecast (its value is static)', // its valuse is static because tht API doesnt contain the forecast data.
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  const SizedBox(
                    height: 20,
                  ),

                  // its a forecast for the next 12 hours. and its value is static thats why i just commented it

                  // SizedBox(
                  //   height: 140,
                  //   width: double.infinity,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: times.length,
                  //     // Suggested code may be subject to a license. Learn more: ~LicenseLog:1352806267.
                  //     itemBuilder: (context, index) => HourlyForecastItems(
                  //       condition: conditions[index],
                  //       time: times[index],
                  //       icon: icons[index],
                  //     ),
                  //   ),
                  // ),
                  const Text(
                    'Additional Information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomAdditionalCol(
                        bodyText: 'Humidity',
                        icon: Icons.water_drop,
                        measure: humidity,
                      ),
                      CustomAdditionalCol(
                        bodyText: 'Wind Speed',
                        icon: Icons.air,
                        measure: windSpeed,
                      ),
                      CustomAdditionalCol(
                        bodyText: 'Pressure',
                        icon: Icons.beach_access,
                        measure: pressure,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}




















// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Movie {
//   String posterPath;

//   Movie({required this.posterPath});

//   factory Movie.fromJson(Map<String, dynamic> json) {
//     return Movie(
//       posterPath: json['poster_path'],
//     );
//   }
// }





// class MovieService {
//   Future<List<dynamic>> fetchingMovieData(String sectionPoint) async {
//     final res = await http.get(
//       Uri.parse(
//           'https://api.themoviedb.org/3/movie/$sectionPoint?api_key=323932alkjdsoal'),
//     );

//     if (res.statusCode == 200) {
//       final List<dynamic> result = jsonDecode(res.body);
//       return result.map((e) => Movie.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load movies');
//     }
//   }

//   Future<List<dynamic>> fetchingPopularMovies() async =>
//       fetchingMovieData('popular');
//   Future<List<dynamic>> fetchingTopRatedMovies() async =>
//       fetchingMovieData('top_rated');
//   Future<List<dynamic>> fetchingUpcomingMovies() async =>
//       fetchingMovieData('upcoming');
//   Future<List<dynamic>> fetchingNowPlayingMovies() async =>
//       fetchingMovieData('now_playing');
// }

