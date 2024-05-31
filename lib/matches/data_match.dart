import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'match_model.dart';

Future<List<Match>> loadAllMatchData() async {
  String supabaseUrl =
      'https://eksgwihmgfwwanfrxnmg.supabase.co/storage/v1/object/public/Data/matches_csv';
  List<String> fileNames = [
    'matches_2013.csv',
    'matches_2014.csv',
    'matches_2015.csv',
    'matches_2016.csv',
    'matches_2017.csv',
    'matches_2018.csv',
    'matches_2019.csv',
    'matches_2020.csv',
    'matches_2021.csv',
    'matches_2022.csv',
    'matches_2023.csv',
  ];

  List<Match> allMatches = [];

  for (String fileName in fileNames) {
    var fileUrl = '$supabaseUrl/$fileName';
    var response = await http.get(Uri.parse(fileUrl));

    if (response.statusCode == 200) {
      final String csvString = utf8.decode(response.bodyBytes);
      List<List<dynamic>> csvData =
          const CsvToListConverter(fieldDelimiter: ';').convert(csvString);

      for (List<dynamic> row in csvData.skip(1)) {
        allMatches.add(Match(
          dateGMT: row[0].toString(),
          homeTeam: row[1].toString(),
          awayTeam: row[2].toString(),
          homeTeamGoal: row[3].toString(),
          awayTeamGoal: row[4].toString(),
          homeTeamCorner: row[6].toString(),
          awayTeamCorner: row[7].toString(),
          homeTeamYellowCards: row[8].toString(),
          homeTeamRedCards: row[9].toString(),
          awayTeamYellowCards: row[10].toString(),
          awayTeamRedCards: row[11].toString(),
          homeTeamShots: row[12].toString(),
          awayTeamShots: row[13].toString(),
          homeTeamShotsOnTarget: row[14].toString(),
          awayTeamShotsOnTarget: row[15].toString(),
          homeTeamFouls: row[16].toString(),
          awayTeamFouls: row[17].toString(),
          homeTeamPossession: row[18].toString(),
          awayTeamPossession: row[19].toString(),
          stadiumName: row[20].toString(),
        ));
      }
    } else {
      throw Exception(
          'Failed to load match data from Supabase Storage for file $fileName');
    }
  }

  return allMatches;
}
