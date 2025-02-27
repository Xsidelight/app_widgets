import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Platform channel to communicate with native code.
  static const platform = MethodChannel('com.xside.appWidgets/widget');

  String _widgetData = "Default Widget Data";

  /// Updates the shared data and notifies the native widget code.
  Future<void> _updateWidget() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String newData = "Updated at ${DateTime.now()}";

    // Save new data to shared preferences.
    await prefs.setString("widgetData", newData);

    // Update the Flutter UI.
    setState(() {
      _widgetData = newData;
    });

    // Notify native side (Android/iOS) to update the widget.
    try {
      await platform.invokeMethod('updateWidgetData', {"data": newData});
    } on PlatformException catch (e) {
      // Log error if the method call fails.
      debugPrint("Failed to update widget: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Widget Data:', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text(
                _widgetData,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(onPressed: _updateWidget, child: const Text('Update Widget Data')),
            ],
          ),
        ),
      ),
    );
  }
}
