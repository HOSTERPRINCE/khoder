import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:khoder/components/myappbar.dart';

class PythonNotes extends StatelessWidget {
  const PythonNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Python Notes"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading 1: Introduction to Python
            Text(
              'Introduction to Python',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Python is a high-level, interpreted programming language known for its simplicity and readability. It is widely used for web development, data analysis, artificial intelligence, and more. Python supports multiple programming paradigms, including procedural, object-oriented, and functional programming.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Heading 2: Variables and Data Types
            Text(
              'Variables and Data Types',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'In Python, you can declare variables without specifying their type. Python supports several data types, including:\n\n'
                  '- **int**: Integer numbers (e.g., `10`)\n'
                  '- **float**: Floating-point numbers (e.g., `3.14`)\n'
                  '- **str**: Strings (e.g., `"Hello, Python!"`)\n'
                  '- **bool**: Boolean values (`True` or `False`)',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Variables
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''# Variables in Python
x = 10
y = 3.14
name = "Python"
is_fun = True''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 3: Loops in Python
            Text(
              'Loops in Python',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Python provides two types of loops:\n\n'
                  '- **for loop**: Used to iterate over a sequence (e.g., list, tuple, string).\n'
                  '- **while loop**: Repeats a block of code as long as a condition is true.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: For Loop
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''# For Loop Example
fruits = ["apple", "banana", "cherry"]
for fruit in fruits:
    print(fruit)''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: While Loop
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''# While Loop Example
count = 0
while count < 5:
    print("Count:", count)
    count += 1''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 4: Functions in Python
            Text(
              'Functions in Python',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Functions are reusable blocks of code that perform a specific task. In Python, you can define a function using the `def` keyword.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Functions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''# Function Example
def greet(name):
    return f"Hello, {name}!"

print(greet("Python"))''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 5: Lists and Dictionaries
            Text(
              'Lists and Dictionaries',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Python provides powerful data structures like lists and dictionaries:\n\n'
                  '- **Lists**: Ordered, mutable collections of items.\n'
                  '- **Dictionaries**: Key-value pairs for storing data.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Lists
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''# List Example
numbers = [1, 2, 3, 4, 5]
numbers.append(6)
print(numbers)''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Dictionaries
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''# Dictionary Example
person = {
    "name": "Alice",
    "age": 25,
    "city": "New York"
}
print(person["name"])''',
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