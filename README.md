
# Ticker Tracker

**Ticker Tracker** is a mobile application that allows users to track estimated vs. actual earnings for various companies by entering their stock ticker symbols. This app provides an interactive experience by visualizing earnings data and displaying transcripts of earnings calls for specific quarters.

## Features

- **Company Ticker Input**: Users can enter any valid company ticker (e.g., MSFT for Microsoft).
- **Earnings Data Retrieval**: Fetches estimated and actual earnings data using the Earnings Calendar API.
- **Interactive Graph**: Displays a double line graph comparing estimated earnings to actual earnings, allowing users to interact with data points.
- **Earnings Call Transcripts**: Users can click on specific nodes to retrieve and view earnings call transcripts for the selected quarter and year.

## Technologies Used

- Flutter
- Dart
- Provider (for state management)
- FL Chart (for graphing)
- APIs:
  - [Earnings Calendar API](https://api-ninjas.com/api/earningscalendar)
  - [Earnings Call Transcript API](https://api-ninjas.com/api/earningscalltranscript)

## Live Demo

You can view the live version of the app [here](https://anettaj.in/Ticker-Tracker/).

## Screenshots

<p align="center">
  <img src="images/38.png" alt="Ticker Tracker app" style="width: 300px; height: auto; margin: 0 10px;">
  <img src="images/39.png" alt="Ticker Tracker app" style="width: 300px; height: auto; margin: 0 10px;">
  <img src="images/40.png" alt="Ticker Tracker app" style="width: 300px; height: auto; margin: 0 10px;">
</p>

## How to Run the Project

1. Clone the repository:
   ```bash
   git clone https://github.com/anettaj/Ticker-Tracker.git
   ```
2. Navigate to the project directory:
   ```bash
   cd Ticker-Tracker
   ```
3. Install the dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Contributing

If you'd like to contribute to the project, feel free to open an issue or submit a pull request.

## Acknowledgments

Thank you for taking the time to review my project! I hope you find it useful and informative. You can also check out a brief demonstration of the app on [YouTube](https://youtube.com/shorts/3VZKtRWOUU8).

