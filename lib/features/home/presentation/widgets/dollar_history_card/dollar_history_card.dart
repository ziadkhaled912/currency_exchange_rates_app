import 'package:currency_exchange/core/extenstions/context.dart';
import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/core/presentation/widgets/drop_downs/drop_down_item.dart';
import 'package:currency_exchange/features/home/presentation/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DollarHistoryCard extends StatefulWidget {
  const DollarHistoryCard({super.key});

  @override
  State<DollarHistoryCard> createState() => _DollarHistoryCardState();
}

class _DollarHistoryCardState extends State<DollarHistoryCard> {
  late List<_ChartData> data;
  final List<GenericDropdownMenuItem<Duration>> timeRanges = const [
    GenericDropdownMenuItem(
      title: "24 Hours",
      value: Duration(hours: 24),
    ),
    GenericDropdownMenuItem(
      title: "7 Days",
      value: Duration(days: 7),
    ),
    GenericDropdownMenuItem(
      title: "14 Days",
      value: Duration(days: 14),
    ),
    GenericDropdownMenuItem(
      title: "1 Month",
      value: Duration(days: 30),
    ),
    GenericDropdownMenuItem(
      title: "3 Months",
      value: Duration(days: 90),
    ),
    GenericDropdownMenuItem(
      title: "6 Months",
      value: Duration(days: 180),
    ),
  ];

  @override
  void initState() {
    data = [
      _ChartData(DateTime.now(), 12),
      _ChartData(DateTime(2024, 2, 19), 15),
      _ChartData(DateTime(2024, 2, 18), 30),
      _ChartData(DateTime(2024, 2, 17), 6.4),
      _ChartData(DateTime(2024, 2, 16), 14)
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Price Changes in EGP",
                  style: context.textTheme.labelSmall?.copyWith(
                    color: AppColors.secondText,
                  ),
                ),
              ),
              SizedBox(width: 8.toWidth),
              DropdownButton<Duration>(
                style: context.textTheme.labelSmall?.copyWith(
                  fontSize: 12.toFont,
                  color: AppColors.mainText,
                ),
                items: timeRanges
                    .map((e) => DropdownMenuItem(
                          value: e.value,
                          child: Text(e.title),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
            ],
          ),
          SizedBox(height: 12.toHeight),
          SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              labelStyle: TextStyle(
                fontSize: 12.toFont,
              ),
            ),
            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 40,
              interval: 10,
              labelStyle: TextStyle(
                fontSize: 12.toFont,
              ),            ),
            series: <CartesianSeries<_ChartData, DateTime>>[
              AreaSeries<_ChartData, DateTime>(
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  borderColor: AppColors.primary,
                  borderWidth: 3,
                  color: Colors.white,
                ),
                dataSource: data,
                xValueMapper: (_ChartData data, _) => data.x,
                yValueMapper: (_ChartData data, _) => data.y,
                name: 'Gold',
                borderDrawMode: BorderDrawMode.top,
                borderColor: Colors.green,
                borderWidth: 4,
                color: AppColors.primary.withOpacity(0.25),
              )
            ],
          ),
          // SfSparkLineChart(
          //   //Enable the trackball
          //   trackball: SparkChartTrackball(
          //       activationMode: SparkChartActivationMode.tap),
          //   //Enable marker
          //   marker:
          //       SparkChartMarker(displayMode: SparkChartMarkerDisplayMode.all),
          //
          //   //Enable data label
          //   data: <double>[
          //     1,
          //     5,
          //     -6,
          //     0,
          //     1,
          //     -2,
          //     7,
          //     -7,
          //     -4,
          //     -10,
          //     13,
          //     -6,
          //     7,
          //     5,
          //     11,
          //     5,
          //     3
          //   ],
          // )
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final DateTime x;
  final double y;
}
