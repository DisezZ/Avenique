import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

List<FlSpot> flspotDateInfo() {
  List<FlSpot> infoLists = [];
  double j = 0;
  for (double i = 0; i <= 30; i++) {
    j = j + 0.1;
    infoLists.add(FlSpot(i, j));
  }
  return infoLists;
}

String getDateMonth(int durations) {
  DateTime startDate = DateTime.now();
  var newDate =
      DateTime(startDate.year, startDate.month, startDate.day - durations);
  String dateMonthString = DateFormat('dd/MM').format(newDate);
  //print('New DATE: $newDate');
  return dateMonthString;
}

class DateTimeTest extends StatefulWidget {
  const DateTimeTest({super.key});

  @override
  State<DateTimeTest> createState() => _DateTimeTestState();
}

class _DateTimeTestState extends State<DateTimeTest> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();
    String currentDates = DateFormat('yyyy-MM-dd').format(dateTime);
    String currentdateMonth = DateFormat('dd/MM').format(dateTime);
    return Container(
      child: Text(currentdateMonth),
    );
  }
}

class BalanceTrendContainer extends StatefulWidget {
  const BalanceTrendContainer({super.key});

  @override
  State<BalanceTrendContainer> createState() => _BalanceTrendContainerState();
}

class _BalanceTrendContainerState extends State<BalanceTrendContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 29, 246, 221),
              borderRadius: BorderRadius.circular(16)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Balance Trend', style: TextStyle(fontSize: 21))),
            //DateTimeTest(),
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21),
              child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8))),
            ),
            const Padding(
                padding: EdgeInsets.all(8.0), child: LineChartSample2())
          ]),
        ),
      ),
    );
  }
}

// ----------------[Line chart example]------------------
// Line chart example from..
class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.50,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(18),
              ),
              color: Color.fromARGB(255, 102, 106, 110),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                right: 18,
                left: 12,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                fontSize: 12,
                color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String caseDateZero = getDateMonth(30);
    String caseDateFive = getDateMonth(25);
    String caseDateTen = getDateMonth(20);
    String caseDateFifteen = getDateMonth(15);
    String caseDateTwenty = getDateMonth(10);
    String caseDateTwentyfive = getDateMonth(5);
    const style = TextStyle(
      color: Color.fromARGB(255, 177, 188, 199),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(caseDateZero, style: style);
        break;
      case 5:
        text = Text(caseDateFive, style: style);
        break;
      case 10:
        text = Text(caseDateTen, style: style);
        break;
      case 15:
        text = Text(caseDateFifteen, style: style);
        break;
      case 20:
        text = Text(caseDateTwenty, style: style);
        break;
      case 25:
        text = Text(caseDateTwentyfive, style: style);
        break;
      case 30:
        text = const Text('TODAY', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color.fromARGB(255, 237, 239, 240),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        /*
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color(0xFF2BFA27),
            strokeWidth: 1,
          );
        },
        */
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 0, 0, 0),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 30,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: flspotDateInfo(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        /*
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        */
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}