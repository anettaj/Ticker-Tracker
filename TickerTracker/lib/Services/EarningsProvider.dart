import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EarningsProvider with ChangeNotifier {
  List<EarningsData> _earningsData = [];
  String? _transcript;

  List<EarningsData> get earningsData => _earningsData;
  String? get transcript => _transcript;

  // Replace 'YOUR_API_KEY' with your actual API key
  final String apiKey = '5ytCE9eBIbZqCw74ZR5TdQ==356N3MHGs5ZUXO1X';

  Future<void> fetchEarningsData(String ticker) async {
    final url = 'https://api.api-ninjas.com/v1/earningscalendar?ticker=$ticker';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print("Response body: ${response.body}");  // Debug: Check response content

        // Check if data is being parsed correctly
        _earningsData = data.map((json) => EarningsData.fromJson(json)).toList();
        print("Parsed earningsData length: ${_earningsData.length}"); // Debug: Confirm data population
        notifyListeners();  // Notify listeners to refresh UI
      } else {
        print("Failed to load earnings data: ${response.statusCode}");
        throw Exception('Failed to load earnings data');
      }
    } catch (e) {
      print("Error fetching earnings data: $e");
      throw Exception('Error fetching earnings data: $e');
    }
  }

  Future<void> fetchEarningsTranscript(String ticker, String year, String quarter) async {
    print(' ticker:$ticker,year:$year ,quarter :$quarter');
    final url = 'https://api.api-ninjas.com/v1/earningstranscript?ticker=$ticker&year=$year&quarter=$quarter';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final transcriptData = json.decode(response.body);
        _transcript = transcriptData['transcript'];
      } else {
        print("Failed to load transcript: ${response.statusCode} - ${response.body}");
      }

    } catch (e) {
      print("Error fetching earnings transcript: $e");
      _transcript = "Error fetching transcript: $e";
    } finally {
      notifyListeners();
    }
  }
}

class EarningsData {
  final String date;
  final double estimatedEPS;
  final double actualEPS;

  EarningsData({
    required this.date,
    required this.estimatedEPS,
    required this.actualEPS,
  });

  factory EarningsData.fromJson(Map<String, dynamic> json) {
    return EarningsData(
      date: json['pricedate'],
      estimatedEPS: json['estimated_eps'].toDouble(),
      actualEPS: json['actual_eps'].toDouble(),
    );
  }
}
