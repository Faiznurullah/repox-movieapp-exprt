import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:ditonton/presentation/pages/search_page.dart';

class FirebaseCrashlyticsTestPage extends StatelessWidget {
  static const ROUTE_NAME = '/crashlytics-test';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Crashlytics Test'),
        backgroundColor: Colors.red[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.warning, size: 64, color: Colors.orange),
                    SizedBox(height: 16),
                    Text(
                      'Firebase Crashlytics Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Test various crash scenarios and error reporting',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // Test Crash Button
            ElevatedButton.icon(
              onPressed: () {
                // Force a crash for testing
                FirebaseCrashlytics.instance.crash();
              },
              icon: Icon(Icons.bug_report),
              label: Text('Test Force Crash'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            
            SizedBox(height: 12),
            
            // Test Exception Button
            ElevatedButton.icon(
              onPressed: () async {
                try {
                  throw Exception('Test exception from Crashlytics demo');
                } catch (error, stackTrace) {
                  // Report non-fatal error
                  await FirebaseCrashlytics.instance.recordError(
                    error,
                    stackTrace,
                    reason: 'Test exception from demo page',
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Non-fatal error reported to Crashlytics'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                }
              },
              icon: Icon(Icons.error_outline),
              label: Text('Test Non-Fatal Error'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            
            SizedBox(height: 12),
            
            // Search with Crash Test Button (Your requested feature)
            ElevatedButton.icon(
              onPressed: () {
                // Your requested implementation
                FirebaseCrashlytics.instance.crash();
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              },
              icon: Icon(Icons.search),
              label: Text('Search + Crash Test'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            
            SizedBox(height: 12),
            
            // Log Custom Event
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseCrashlytics.instance.log('Custom log from demo page');
                await FirebaseCrashlytics.instance.setCustomKey('test_key', 'test_value');
               
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Custom data logged to Crashlytics'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: Icon(Icons.analytics),
              label: Text('Log Custom Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            
            SizedBox(height: 24),
            
            // Navigation Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                    },
                    icon: Icon(Icons.search),
                    label: Text('Go to Search'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.home),
                    label: Text('Back to Home'),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16),
            
            // Warning Text
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                border: Border.all(color: Colors.yellow[700]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.yellow[700]),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Warning: Crash tests will actually crash the app for testing purposes!',
                      style: TextStyle(
                        color: Colors.yellow[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
