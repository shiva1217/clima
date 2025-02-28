import 'package:clima/model/weather_data_daily.dart';
import 'package:clima/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecast({super.key, required this.weatherDataDaily});

  // string manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: CustomColors.dividerLine.withAlpha(150),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "5 Days Forecast",
              style: TextStyle(
                  color: CustomColors.textColorBlack,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          ),
          dailyList(),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
              "max./min. temp. in °c",
              style: TextStyle(
                  color: CustomColors.textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w100),
            ),
          ),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          getDay(weatherDataDaily.daily[index].dt),
                          style: const TextStyle(
                              color: CustomColors.textColorBlack,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                            "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                      ),
                      Text(
                          "${weatherDataDaily.daily[index].temp!.max}°/${weatherDataDaily.daily[index].temp!.min}",
                          style: const TextStyle(
                              color: CustomColors.textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal))
                    ],
                  )),
              Container(
                height: 1,
                color: CustomColors.dividerLine,
              )
            ],
          );
        },
      ),
    );
  }
}
