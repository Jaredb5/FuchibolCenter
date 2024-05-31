import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'teams_model.dart';

class PieChartSampleTeamComparison extends StatelessWidget {
  final String dataType;
  final List<Team> teamData;

  PieChartSampleTeamComparison(
      {required this.dataType, required this.teamData});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];

    for (int i = 0; i < teamData.length; i++) {
      Team team = teamData[i];
      double value = 0;
      if (dataType == 'matches') {
        value = team.matches_played.toDouble();
      } else if (dataType == 'goals') {
        value = team.goals_scored.toDouble();
      } else if (dataType == 'cards') {
        value = team.cards_total.toDouble();
      } else if (dataType == 'averageGoals') {
        value = team.matches_played > 0
            ? team.goals_scored.toDouble() / team.matches_played
            : 0;
      } else if (dataType == 'averageCards') {
        value = team.matches_played > 0
            ? team.cards_total.toDouble() / team.matches_played
            : 0;
      }
      sections.add(PieChartSectionData(
        value: value,
        color: Colors.primaries[i % Colors.primaries.length],
        title: value.toStringAsFixed(2),
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      ));
    }

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    sectionsSpace: 2,
                    centerSpaceRadius: 40,
                    pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {}),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: teamData.length,
                  itemBuilder: (context, index) {
                    final team = teamData[index];
                    return Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${team.season}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
