import 'package:clima/controller/global_controller.dart';
import 'package:clima/model/weather_data_hourly.dart';
import 'package:clima/utils/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  final RxInt cardIndex = GlobalController().getIndex();
  HourlyDataWidget({super.key, required this.weatherDataHourly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text("Today's Forecast",
              style: TextStyle(
                  fontSize: 18,
                  color: CustomColors.textColorBlack,
                  fontWeight: FontWeight.w700)),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 14
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx((() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.5, 0),
                          blurRadius: 30,
                          spreadRadius: 1,
                          color: CustomColors.dividerLine.withAlpha(150))
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(colors: [
                            CustomColors.firstGradientColor1,
                            CustomColors.secondGradientColor2
                          ])
                        : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ))));
        },
      ),
    );
  }
}

// hourly details class
class HourlyDetails extends StatelessWidget {
  final int temp;
  final int index;
  final int cardIndex;
  final int timeStamp;
  final String weatherIcon;

  const HourlyDetails(
      {super.key,
      required this.cardIndex,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon});
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp),
              style: TextStyle(
                color: cardIndex == index
                    ? CustomColors.textColor
                    : CustomColors.textColorBlack,
                fontWeight:
                    cardIndex == index ? FontWeight.bold : FontWeight.w300,
              )),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/weather/$weatherIcon.png",
              height: 40,
              width: 40,
            )),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°",
              style: TextStyle(
                color: cardIndex == index
                    ? CustomColors.textColor
                    : CustomColors.textColorBlack,
                fontWeight:
                    cardIndex == index ? FontWeight.bold : FontWeight.w300,
              )),
        )
      ],
    );
  }
}
