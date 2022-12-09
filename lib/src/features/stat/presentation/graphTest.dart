import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample3 extends StatefulWidget {
  const LineChartSample3({super.key});

  List<String> get weekDays =>
      const ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  List<double> get yValues => const [1.3, 1, 1.8, 1.5, 2.2, 1.8, 3];

  @override
  State createState() => _LineChartSample3State();
}

class _LineChartSample3State extends State<LineChartSample3> {
  late double touchedValue;

  @override
  void initState() {
    touchedValue = -1;
    super.initState();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '';
        break;
      case 1:
        text = '1k calories';
        break;
      case 2:
        text = '2k calories';
        break;
      case 3:
        text = '3k calories';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 6,
      child: Text(text, style: style, textAlign: TextAlign.center),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final isTouched = value == touchedValue;
    final style = TextStyle(
      color: isTouched ? Colors.deepOrange : Colors.deepOrange.withOpacity(0.5),
      fontWeight: FontWeight.bold,
    );

    return SideTitleWidget(
      space: 4,
      axisSide: meta.axisSide,
      child: Text(widget.weekDays[value.toInt()], style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Text(
              'Average Line',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              ' and ',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'Indicators',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        SizedBox(
          width: 300,
          height: 140,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((spotIndex) {
                    final spot = barData.spots[spotIndex];
                    if (spot.x == 0 || spot.x == 6) {
                      return null;
                    }
                    return TouchedSpotIndicatorData(
                      FlLine(color: Colors.blue, strokeWidth: 4),
                      FlDotData(
                        getDotPainter: (spot, percent, barData, index) {
                          if (index.isEven) {
                            return FlDotCirclePainter(
                              radius: 8,
                              color: Colors.white,
                              strokeWidth: 5,
                              strokeColor: Colors.deepOrange,
                            );
                          } else {
                            return FlDotSquarePainter(
                              size: 16,
                              color: Colors.white,
                              strokeWidth: 5,
                              strokeColor: Colors.deepOrange,
                            );
                          }
                        },
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: Colors.blueAccent,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      final flSpot = barSpot;
                      if (flSpot.x == 0 || flSpot.x == 6) {
                        return null;
                      }

                      TextAlign textAlign;
                      switch (flSpot.x.toInt()) {
                        case 1:
                          textAlign = TextAlign.left;
                          break;
                        case 5:
                          textAlign = TextAlign.right;
                          break;
                        default:
                          textAlign = TextAlign.center;
                      }

                      return LineTooltipItem(
                        '${widget.weekDays[flSpot.x.toInt()]} \n',
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: flSpot.y.toString(),
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const TextSpan(
                            text: ' k ',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const TextSpan(
                            text: 'calories',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                        textAlign: textAlign,
                      );
                    }).toList();
                  },
                ),
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? lineTouch) {
                  if (!event.isInterestedForInteractions ||
                      lineTouch == null ||
                      lineTouch.lineBarSpots == null) {
                    setState(() {
                      touchedValue = -1;
                    });
                    return;
                  }
                  final value = lineTouch.lineBarSpots![0].x;

                  if (value == 0 || value == 6) {
                    setState(() {
                      touchedValue = -1;
                    });
                    return;
                  }

                  setState(() {
                    touchedValue = value;
                  });
                },
              ),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 1.8,
                    color: Colors.green.withOpacity(0.8),
                    strokeWidth: 3,
                    dashArray: [20, 2],
                  ),
                ],
              ),
              lineBarsData: [
                LineChartBarData(
                  isStepLineChart: true,
                  spots: widget.yValues.asMap().entries.map((e) {
                    return FlSpot(e.key.toDouble(), e.value);
                  }).toList(),
                  isCurved: false,
                  barWidth: 4,
                  color: Colors.orange,
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withOpacity(0.5),
                        Colors.orange.withOpacity(0),
                      ],
                      stops: const [0.5, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    spotsLine: BarAreaSpotsLine(
                      show: true,
                      flLineStyle: FlLine(
                        color: Colors.blue,
                        strokeWidth: 2,
                      ),
                      checkToShowSpotLine: (spot) {
                        if (spot.x == 0 || spot.x == 6) {
                          return false;
                        }

                        return true;
                      },
                    ),
                  ),
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      if (index.isEven) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Colors.white,
                          strokeWidth: 3,
                          strokeColor: Colors.deepOrange,
                        );
                      } else {
                        return FlDotSquarePainter(
                          size: 12,
                          color: Colors.white,
                          strokeWidth: 3,
                          strokeColor: Colors.deepOrange,
                        );
                      }
                    },
                    checkToShowDot: (spot, barData) {
                      return spot.x != 0 && spot.x != 6;
                    },
                  ),
                ),
              ],
              minY: 0,
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: true,
                getDrawingHorizontalLine: (value) {
                  if (value == 0) {
                    return FlLine(
                      color: Colors.deepOrange,
                      strokeWidth: 2,
                    );
                  } else {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  }
                },
                getDrawingVerticalLine: (value) {
                  if (value == 0) {
                    return FlLine(
                      color: Colors.black,
                      strokeWidth: 2,
                    );
                  } else {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  }
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 46,
                    getTitlesWidget: leftTitleWidgets,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: bottomTitleWidgets,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ----------------[Line chart example]------------------
// Line chart example from..
// class LineChartSample2 extends StatefulWidget {
//   const LineChartSample2({super.key});

//   @override
//   State<LineChartSample2> createState() => _LineChartSample2State();
// }

// class _LineChartSample2State extends State<LineChartSample2> {
//   List<Color> gradientColors = [
//     const Color(0xff23b6e6),
//     const Color(0xff23b6e6),
//   ];
//   List<Color> lineInfoColors = [
//     const Color.fromARGB(255, 237, 240, 231),
//     const Color(0xff23b6e6)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.60,
//           child: DecoratedBox(
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(18),
//               ),
//               color: Color.fromARGB(255, 102, 106, 110),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 right: 18,
//                 left: 12,
//                 top: 24,
//                 bottom: 12,
//               ),
//               child: LineChart(
//                 mainData(),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     String caseDateZero = getDateMonth(30);
//     String caseDateFive = getDateMonth(25);
//     String caseDateTen = getDateMonth(20);
//     String caseDateFifteen = getDateMonth(15);
//     String caseDateTwenty = getDateMonth(10);
//     String caseDateTwentyfive = getDateMonth(5);
//     const style = TextStyle(
//       color: Color.fromARGB(255, 177, 188, 199),
//       fontWeight: FontWeight.bold,
//       fontSize: 12,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = Text(caseDateZero, style: style);
//         break;
//       case 5:
//         text = Text(caseDateFive, style: style);
//         break;
//       case 10:
//         text = Text(caseDateTen, style: style);
//         break;
//       case 15:
//         text = Text(caseDateFifteen, style: style);
//         break;
//       case 20:
//         text = Text(caseDateTwenty, style: style);
//         break;
//       case 25:
//         text = Text(caseDateTwentyfive, style: style);
//         break;
//       case 30:
//         text = const Text('TODAY', style: style);
//         break;
//       default:
//         text = const Text('', style: style);
//         break;
//     }

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: text,
//     );
//   }

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Color.fromARGB(255, 237, 239, 240),
//       fontWeight: FontWeight.bold,
//       fontSize: 15,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '10K';
//         break;
//       case 3:
//         text = '30k';
//         break;
//       case 5:
//         text = '50k';
//         break;
//       default:
//         return Container();
//     }

//     return Text(text, style: style, textAlign: TextAlign.left);
//   }

//   LineChartData mainData() {
//     List<String> listDay = getDaysBetween(30);
//     return LineChartData(
//       lineTouchData: LineTouchData(
//         enabled: true,
//         touchTooltipData: LineTouchTooltipData(
//           tooltipBgColor: Colors.blueAccent,
//           getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
//             return touchedBarSpots.map((barSpot) {
//               final flSpot = barSpot;
//               if (flSpot.x == 0 || flSpot.x == 6) {
//                 return null;
//               }

//               TextAlign textAlign;
//               switch (flSpot.x.toInt()) {
//                 case 1:
//                   textAlign = TextAlign.left;
//                   break;
//                 case 5:
//                   textAlign = TextAlign.right;
//                   break;
//                 default:
//                   textAlign = TextAlign.center;
//               }

//               return LineTooltipItem(
//                 '${listDay[flSpot.x.toInt()]} \n',
//                 const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 children: [
//                   TextSpan(
//                     text: flSpot.y.toString(),
//                     style: TextStyle(
//                       color: Colors.grey[100],
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   const TextSpan(
//                     text: ' k ',
//                     style: TextStyle(
//                       fontStyle: FontStyle.italic,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                   const TextSpan(
//                     text: 'calories',
//                     style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ],
//                 textAlign: textAlign,
//               );
//             }).toList();
//           },
//         ),
//       ),
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//         /*
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: Color(0xFF2BFA27),
//             strokeWidth: 1,
//           );
//         },
//         */
//         getDrawingVerticalLine: (value) {
//           return FlLine(
//             color: Color.fromARGB(255, 4, 4, 26),
//             strokeWidth: 2,
//           );
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 42,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: Color.fromARGB(255, 239, 239, 239)),
//       ),
//       minX: 0,
//       maxX: 30,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: flspotDateInfo(),
//           isCurved: true,
//           gradient: LinearGradient(
//             colors: lineInfoColors,
//           ),
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: false,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff4af699),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0xffaa4cfc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: const Color(0xff27b6fc),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x444af699),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: const Color(0x99aa4cfc),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: const Color(0x33aa4cfc),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x4427b6fc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xff2c274c),
              Color(0xff46426c),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                const Text(
                  'Unfold Shop 2018',
                  style: TextStyle(
                    color: Color(0xff827daa),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Monthly Sales',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: _LineChart(isShowingMainData: isShowingMainData),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
