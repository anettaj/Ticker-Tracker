import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/EarningsProvider.dart';

class TranscriptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final earningsProvider = Provider.of<EarningsProvider>(context);
    final transcript = earningsProvider.transcript;

    String formatTranscript(String transcript) {
      // Regular expression to match text patterns between a dot and a colon
      final regExp = RegExp(r'\.(.*?)\s*:', dotAll: true);
      return transcript.replaceAllMapped(
        regExp,
            (match) => '.\n\n${match.group(1)?.trim()}:', // Adds new line before text between dot and colon
      );
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: transcript == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Earnings Call Transcript',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                style: TextStyle(fontSize: 15, color: Colors.grey[300]),
                children: formatTranscript(transcript).split('\n').map((text) {
                  // Check for formatted names with ':' to identify speaker parts
                  if (text.contains(':')) {
                    final parts = text.split(':');
                    return TextSpan(
                      children: [
                        TextSpan(
                          text: '\n\n${parts[0]}: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: parts.length > 1 ? parts[1] : '',
                          style: TextStyle(color: Colors.grey,),
                        ),
                      ],
                    );
                  }
                  // Regular text display without speaker format
                  return TextSpan(text: text,style: TextStyle(color: Colors.grey));
                }).toList(),
                          ),
                        ),
              ],
            ),
      ),
    );
  }
}
