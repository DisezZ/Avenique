import './indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './graphTest.dart';

class SpendingPieCStatContainer extends StatefulWidget {
  const SpendingPieCStatContainer({super.key});

  @override
  State<SpendingPieCStatContainer> createState() =>
      _SpendingPieCStatContainerState();
}

class _SpendingPieCStatContainerState extends State<SpendingPieCStatContainer> {
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
                child: Text('Categories', style: TextStyle(fontSize: 21))),
            //DateTimeTest(),
            Padding(
              padding: const EdgeInsets.only(left: 21, right: 21),
              child: Container(
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8))),
            ),
            Container(
              child: PieChartSample2(),
            ),
            Container(
              child: SpendingLineChart(),
            ),
            // Container(
            //   child: LineChartSample1(),
            // ),
          ]),
        ),
      ),
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        //color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 45,
                    sections: showingSections(),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'First',
                  isSquare: true,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Second',
                  isSquare: true,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Third',
                  isSquare: true,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'Fourth',
                  isSquare: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 32.0 : 24.0;
      final radius = isTouched ? 70.0 : 60.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

/*################################################
 * This function is getDayinBetween
 * this function will required startdate and endate
 * return list of day
 */

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}

class TestDateList extends StatefulWidget {
  const TestDateList({super.key});

  @override
  State<TestDateList> createState() => _TestDateListState();
}

class _TestDateListState extends State<TestDateList> {
  List<String> setOfDate = getDaysBetween(30);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: setOfDate.length,
        prototypeItem: ListTile(
          title: Text(setOfDate.first),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(setOfDate[index]),
          );
        },
      ),
    );
  }
}

List<String> getDaysBetween(int duration) {
  DateTime startDate = DateTime.now();
  DateTime newDate;
  String dateMonthString;
  List<String> days = [];
  for (int i = duration; i >= 0; i = i - 1) {
    newDate = DateTime(startDate.year, startDate.month, startDate.day - i);
    dateMonthString = DateFormat('dd/MM/yyyy').format(newDate);
    days.add(dateMonthString);
  }
  return days;
}

/*###########################################
 * this fucntion is flsportDateinfo
 * this function will mockup the date for plot
 * retun list<flspot>
 */
List<FlSpot> flspotDateInfo() {
  List<FlSpot> infoLists = [];
  double j = 0;
  for (double i = 0; i <= 30; i++) {
    j = j + 0.1;
    infoLists.add(FlSpot(i, j));
  }
  return infoLists;
}

/*###########################################
 * this fucntion is getDateMonth
 * this function will find the past date between today and duration.
 * retun string Date
 */
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
    String currentdateMonth = DateFormat('dd/MM/yyyy').format(dateTime);
    return Container(
      child: Text(currentdateMonth),
    );
  }
}

// ----------------[Line chart example]------------------
// Line chart example from..
class SpendingLineChart extends StatefulWidget {
  const SpendingLineChart({super.key});

  @override
  State<SpendingLineChart> createState() => _SpendingLineChartState();
}

class _SpendingLineChartState extends State<SpendingLineChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff23b6e6),
  ];
  List<Color> lineInfoColors = [
    const Color.fromARGB(255, 237, 240, 231),
    const Color(0xff23b6e6)
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 180,
          width: double.infinity,
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
                left: 6,
                top: 24,
                bottom: 12,
              ),
              child: LineChart(
                mainData(),
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
    List<String> listDay = getDaysBetween(30);
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueAccent, //box background color
          tooltipRoundedRadius: 1,
          tooltipMargin: 5,
          showOnTopOfTheChartBoxArea: true,
          //fitInsideVertically: true,
          fitInsideHorizontally: true,
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
                '${listDay[flSpot.x.toInt()]} \n',
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
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 255, 255, 255),
            strokeWidth: 1,
            dashArray: [4, 2],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color.fromARGB(255, 4, 4, 26),
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
            reservedSize: 32,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Color.fromARGB(255, 239, 239, 239)),
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
            colors: lineInfoColors,
          ),
          barWidth: 4,
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
}
