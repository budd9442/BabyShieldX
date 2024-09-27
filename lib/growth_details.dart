import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BabyWeightChart extends StatelessWidget {
  final List<WeightEntry> weightEntries;

  const BabyWeightChart({Key? key, required this.weightEntries}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baby Weight Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Baby Weight Over Time',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                _buildChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildChart() {
    // Convert weight entries to FlSpot for the graph
    List<FlSpot> weightSpots = weightEntries
        .map((entry) => FlSpot(entry.month.toDouble(), entry.weight))
        .toList();

    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text('${value.toInt()}m'); // Show months on x-axis
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text('${value.toStringAsFixed(1)}kg'); // Show weight on y-axis
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.black),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: weightSpots,
          isCurved: true, // Smooth out the line
          barWidth: 3,
          dotData: FlDotData(
            show: true, // Show dots at each data point
          ),
          belowBarData: BarAreaData(show: false),
          color: Colors.blue, // Line color for actual baby weight
        ),
      ],
      // Add background colored sections for weight categories
      betweenBarsData: [
        BetweenBarsData(
          fromIndex: 0,
          toIndex: 5,
          color: Colors.red.withOpacity(0.4),  // Severely underweight
        ),
        BetweenBarsData(
          fromIndex: 5,
          toIndex: 7,
          color: Colors.yellow.withOpacity(0.4), // Medium underweight
        ),
        BetweenBarsData(
          fromIndex: 7,
          toIndex: 8,
          color: Colors.lightGreen.withOpacity(0.4), // Risk of underweight
        ),
        BetweenBarsData(
          fromIndex: 8,
          toIndex: 10,
          color: Colors.green.withOpacity(0.4), // Normal weight
        ),
        BetweenBarsData(
          fromIndex: 10,
          toIndex: 12,
          color: Colors.grey.withOpacity(0.4), // Overweight
        ),
      ],
    );
  }
}

class WeightEntry {
  final int month; // Month of the baby (x-axis)
  final double weight; // Baby's weight in kilograms (y-axis)

  WeightEntry(this.month, this.weight);
}
