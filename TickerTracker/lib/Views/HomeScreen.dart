import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Services/EarningsProvider.dart';
import 'earnings_data_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _tickerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: InkWell(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ticker Tracker",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _tickerController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Enter Company Ticker (e.g., MSFT)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
              onPressed: () {
                if (_tickerController.text.isNotEmpty) {
                  Provider.of<EarningsProvider>(context, listen: false)
                      .fetchEarningsData(_tickerController.text.toUpperCase())
                      .then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) =>
                          EarningsDataScreen(ticker: _tickerController.text)),
                    );
                  });
                }

              },

                style: ButtonStyle(
                  backgroundColor:WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                ),
                child: Text('Search',
                style: TextStyle(
                  color: Colors.black
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
