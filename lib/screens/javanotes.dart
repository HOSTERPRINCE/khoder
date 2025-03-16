import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:khoder/components/myappbar.dart';

class JavaNotes extends StatelessWidget {
  const JavaNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Java Notes"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading 1: Introduction to Java
            Text(
              'Introduction to Java',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Java is a high-level, class-based, object-oriented programming language designed to have as few implementation dependencies as possible. It is widely used for building enterprise-scale applications, Android apps, and web applications.',
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
              'In Java, variables must be declared with a specific data type. Java supports several primitive data types, including:\n\n'
                  '- **int**: Integer numbers (e.g., `10`)\n'
                  '- **double**: Floating-point numbers (e.g., `3.14`)\n'
                  '- **char**: Single characters (e.g., `A`)\n'
              '- **boolean**: Boolean values (`true` or `false`)',
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
                '''// Variables in Java
int age = 25;
double price = 19.99;
char grade = 'A';
boolean isJavaFun = true;''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 3: Control Flow
            Text(
              'Control Flow',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Java provides several control flow statements, including:\n\n'
                  '- **if-else**: Executes a block of code based on a condition.\n'
                  '- **for loop**: Repeats a block of code a specific number of times.\n'
                  '- **while loop**: Repeats a block of code as long as a condition is true.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: If-Else
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''// If-Else Example
int number = 10;
if (number > 0) {
    System.out.println("Positive");
} else {
    System.out.println("Negative");
}''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
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
                '''// For Loop Example
for (int i = 0; i < 5; i++) {
    System.out.println("Iteration: " + i);
}''',
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
                '''// While Loop Example
int count = 0;
while (count < 5) {
    System.out.println("Count: " + count);
    count++;
}''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 4: Classes and Objects
            Text(
              'Classes and Objects',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Java is an object-oriented programming language. Classes are blueprints for creating objects, and objects are instances of classes. A class can contain fields (variables) and methods (functions).',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Class and Object
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''// Class and Object Example
class Car {
    String brand;
    String model;

    void start() {
        System.out.println("The car is starting.");
    }
}

Car myCar = new Car();
myCar.brand = "Toyota";
myCar.model = "Corolla";
myCar.start();''',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Heading 5: Arrays
            Text(
              'Arrays',
              style: GoogleFonts.orbitron(
                color: const Color(0xFFFF6B00),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Arrays are used to store multiple values of the same type in a single variable. In Java, arrays have a fixed size once declared.',
              style: GoogleFonts.orbitron(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Code Example: Arrays
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '''// Array Example
int[] numbers = {1, 2, 3, 4, 5};
for (int i = 0; i < numbers.length; i++) {
    System.out.println(numbers[i]);
}''',
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