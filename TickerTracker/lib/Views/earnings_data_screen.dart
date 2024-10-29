import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Services/EarningsProvider.dart';
import 'transcript_screen.dart';

class EarningsDataScreen extends StatefulWidget {
  final String ticker;

  EarningsDataScreen({required this.ticker});

  @override
  _EarningsDataScreenState createState() => _EarningsDataScreenState();
}

class _EarningsDataScreenState extends State<EarningsDataScreen> {
  @override
  Widget build(BuildContext context) {
    final earningsProvider = Provider.of<EarningsProvider>(context);
    final earningsData = earningsProvider.earningsData;
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: earningsData.isEmpty
          ? Center(child: Text('No Data\nPlease try some other company'))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Estimated vs. Actual EPS',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Company Ticker: ${widget.ticker.toUpperCase()}',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: H*0.5,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: earningsData.asMap().entries.map((entry) {
                        int idx = entry.key;
                        var data = entry.value;
                        return FlSpot(idx.toDouble(), data.estimatedEPS);
                      }).toList(),
                      isCurved: true,
                      color: Colors.blue,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                    LineChartBarData(
                      spots: earningsData.asMap().entries.map((entry) {
                        int idx = entry.key;
                        var data = entry.value;
                        return FlSpot(idx.toDouble(), data.actualEPS);
                      }).toList(),
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 2,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineTouchData: LineTouchData(
                    touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) async {
                      if (event is FlTapUpEvent && touchResponse != null && touchResponse.lineBarSpots != null) {
                        final int index = touchResponse.lineBarSpots!.first.spotIndex;
                        final selectedData = earningsData[index];

                        // Attempt to fetch the transcript
                        await earningsProvider.fetchEarningsTranscript(
                          widget.ticker,
                          selectedData.date.split('-')[0], // Year
                          '${index + 1}', // Example quarter placeholder
                        );

                        // Only navigate if transcript data is available
                        if (earningsProvider.transcript != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => TranscriptScreen()),
                          );
                        } else {
                          // Show snackbar using Flutter's built-in functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Transcript not available."),
                            ),
                          );
                        }
                      }
                    },
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (List<LineBarSpot> touchedSpots) {
                        return touchedSpots.map((LineBarSpot spot) {
                          final data = earningsData[spot.spotIndex];
                          return LineTooltipItem(
                            '${data.date}\nEstimated: ${data.estimatedEPS}, Actual: ${data.actualEPS}',
                            TextStyle(color: Colors.white),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: W * 0.7,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 30,
                      color: Colors.blue,
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text('Estimated '),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 30,
                      color: Colors.green,
                      margin: EdgeInsets.only(right: 10),
                    ),
                    Text('Actual'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
