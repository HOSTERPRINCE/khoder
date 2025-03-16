import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:khoder/components/myappbar.dart';

class FlutterNotes extends StatelessWidget {
  const FlutterNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Flutter Notes"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading 1: What is Flutter?
            Text(
              'What is Flutter?',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Flutter is an open-source UI framework developed by Google. It allows developers to build natively compiled applications for mobile, web, and desktop from a single codebase. Flutter uses the Dart programming language and provides a rich set of pre-designed widgets to create beautiful and responsive user interfaces.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Heading 2: Widgets in Flutter
            Text(
              'Widgets in Flutter',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'In Flutter, everything is a widget. Widgets are the building blocks of a Flutter app. There are two types of widgets: StatelessWidget and StatefulWidget.\n\n'
                  '- **StatelessWidget**: A widget that does not require mutable state. It is immutable and cannot change once built.\n'
                  '- **StatefulWidget**: A widget that can change its state during runtime. It uses a `State` object to manage its mutable state.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: StatelessWidget
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello, Stateless World!');
  }
}''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: StatefulWidget
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Counter: \$_counter');
  }
}''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 3: State Management
            Text(
              'State Management',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'State management is a critical part of building Flutter apps. It refers to how you manage and share the state of your app across different widgets. Common approaches include:\n\n'
                  '- **setState**: Used for local state management within a single widget.\n'
                  '- **Provider**: A popular package for managing app-wide state.\n'
                  '- **Bloc**: A pattern for managing state using streams and events.\n'
                  '- **Riverpod**: A more flexible and modern alternative to Provider.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: setState
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Counter: \$_counter'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 4: Navigation
            Text(
              'Navigation in Flutter',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Navigation in Flutter is handled using the `Navigator` class. You can push and pop routes to move between screens.\n\n'
                  '- **Push**: Navigate to a new screen.\n'
                  '- **Pop**: Return to the previous screen.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Navigation
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}