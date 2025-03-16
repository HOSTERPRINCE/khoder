import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/components/my_button.dart';
import 'package:khoder/components/mytextfield.dart';
import 'package:khoder/loginandsignup/authState.dart';
import 'package:khoder/loginandsignup/login.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  bool isAccepted = false;
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final emailController = TextEditingController();
  final passwordController=TextEditingController();
  final userNameController=TextEditingController();
  final confirmPasswordController= TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    // Initialize the animation after the controller
    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Start from bottom
      end: Offset(0, 0),   // Move to normal position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }


  void _toggleAcceptance(bool? value) {
    setState(() {
      isAccepted = value ?? false;
      if (isAccepted) {
        _controller.forward();  // Animate in
      } else {
        _controller.reverse();  // Animate out
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: true,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                              children: [
                                Text("A Community Built for Coders, by Coders!" , style: GoogleFonts.orbitron(
                                  fontSize: 18,
                                  color: Color(0xFFFF6B00),

                                ),
                                  textAlign: TextAlign.center,),
                                SizedBox(height: 30,),
                                Center(
                                  child: Container(

                                    child: Row(
                                      children: [
                                        Text("A problem Feed" ,style: GoogleFonts.orbitron(
                                          fontSize: 20,
                                          color: Color(0xFFFF6B00)
                                        ),),
                                        SizedBox(width: 10,),
                                        Icon(Icons.error),
                                      ],
                                    ),
                                  ),
                                ),
                                Text("A feed where logged in users can add theirs error and problems which can be replied by any other developer or other logged in user it also allows you to have your code in the problem which help in debugging", style: GoogleFonts.orbitron(
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.inversePrimary
                                ),),
                                SizedBox(height: 20,),
                                Center(
                                  child: Row(
                                    children: [
                                      Text("Notes Section" ,style: GoogleFonts.orbitron(
                                          fontSize: 20,
                                          color: Color(0xFFFF6B00)
                                      ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.note),
                                    ],
                                  ),
                                ),
                                Text("A section where you can find notes of different programming languages and frameworks",style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.inversePrimary
                                ),),
                                SizedBox(height: 20,),
                                Center(
                                  child: Row(
                                    children: [
                                      Text("A suggestion Feed" ,style: GoogleFonts.orbitron(
                                          fontSize: 20,
                                          color: Color(0xFFFF6B00)
                                      ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.assessment_outlined),
                                    ],
                                  ),
                                ),
                                Text("A feed in which people can ask for suggestion related to programming.", style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.inversePrimary
                                ),),
                                SizedBox(height: 20,),
                                Center(
                                  child: Row(
                                    children: [
                                      Text("A multiLanguage Compiler" ,style: GoogleFonts.orbitron(
                                          fontSize: 20,
                                          color: Color(0xFFFF6B00)
                                      ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.code),
                                    ],
                                  ),
                                ),
                                Text("A complier is integrated in the application so you can code in the application also.",style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.inversePrimary
                                ),),
                                SizedBox(height: 20,),
                                Center(
                                  child: Row(
                                    children: [
                                      Text("A WPS Test" ,style: GoogleFonts.orbitron(
                                          fontSize: 20,
                                          color: Color(0xFFFF6B00)
                                      ),),
                                      SizedBox(width: 10,),
                                      Icon(Icons.keyboard),
                                    ],
                                  ),
                                ),
                                Text("you can test your typing seed if you need using this application also have a scoreboard of WPS speed." , style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.inversePrimary
                                ),)
                              ],
                            ),

                            ),
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(

                            color: Color(0xFFFF6B00), // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline , color:Theme.of(context).colorScheme.inversePrimary,size: 30,),
                              Text("Info", style: GoogleFonts.orbitron(
                                  fontSize: 24 ,
                                  color:Theme.of(context).colorScheme.inversePrimary
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
                SizedBox(height: 30,),
                Padding(
          padding: EdgeInsets.symmetric(horizontal: 110),
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(

                        color: Color(0xFFFF6B00), // Border color
                        width: 4.0, // Border width
                      ),
                    ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("K", style: Theme.of(context).textTheme.displayLarge,),
                          Text("hoder",
                            style: GoogleFonts.orbitron(
                                fontSize: 32,
                                color: Theme.of(context).colorScheme.inversePrimary
                            ),),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(

                          color: Color(0xFFFF6B00), // Border color
                          width: 4.0, // Border width
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("A Community Built for Coders, by Coders!" , style: GoogleFonts.orbitron(
                              fontSize: 18,
                              color: Color(0xFFFF6B00),

                            ),
                            textAlign: TextAlign.center,),
                            SizedBox(height: 20,),
                            Text("Join a thriving community of developers! Solve doubts, collaborate on projects, and level up your coding skills with Khoder."
                                ,style: GoogleFonts.roboto(

                                fontSize: 16,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                                "Code without limits. Discuss without barriers. Connect with like-minded programmers!",
                              style: GoogleFonts.roboto(

                                fontSize: 16,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              "From debugging to deploying – Khoder is your go-to place to discuss, learn, and grow as a coder!",
                              style: GoogleFonts.roboto(

                                fontSize: 16,
                                color: Theme.of(context).colorScheme.inversePrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: isAccepted,
                                  onChanged: _toggleAcceptance,
                                  checkColor: Colors.black,
                                  fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                                    if (states.contains(MaterialState.selected)) {
                                      return Color(0xFFFF6B00); // Change fill color when selected
                                    }
                                    return Colors.transparent; // Change fill color when not selected
                                  }),
                                  side: BorderSide(
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                    width: 2,
                                  ),
                                ),

                                Text("accept Terms and"
                                ,style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    color: Theme.of(context).colorScheme.inversePrimary,
                                  ),),
                                TextButton(onPressed: (){
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text("1. User Accounts" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),
                                              textAlign: TextAlign.center,),
                                            Text("You must provide accurate and up-to-date information during registration.\nYou are responsible for maintaining the confidentiality of your account credentials.\nWe reserve the right to suspend or terminate accounts violating our policies.\n"
                                              ,style: GoogleFonts.roboto(

                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary
                                              ),),
                                            Text("2. Acceptable Use" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),
                                              textAlign: TextAlign.center,),
                                            Text("You agree not to:\nPost offensive, harmful, or misleading content.\nEngage in harassment, hate speech, or illegal activities.\nUse the platform to share malicious code or unauthorized advertisements.\nViolate intellectual property rights of others."
                                              ,style: GoogleFonts.roboto(

                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),
                                            Text("3. Content Ownership & License" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),
                                              textAlign: TextAlign.center,),
                                            Text("You retain ownership of the content you post but grant Khoder a non-exclusive, royalty-free license to display and distribute it within the app.\nWe do not claim ownership of user-generated content but may remove content that violates our guidelines."
                                              ,style: GoogleFonts.roboto(

                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),
                                            Text("4. Community Guidelines" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),
                                              textAlign: TextAlign.center,),
                                            Text("Respect all users and contribute positively to discussions.\nUse appropriate language and avoid spamming.\nReport violations of our policies to maintain a safe community."
                                              ,style: GoogleFonts.roboto(

                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),
                                            Text("5. Privacy & Data Protection" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),
                                              textAlign: TextAlign.center,),
                                            Text("Your data is handled according to our Privacy Policy.\nWe do not sell your personal information to third parties.\nYou may request account deletion at any time."
                                              ,style: GoogleFonts.roboto(

                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),
                                            Text("6. Limitation of Liability" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),textAlign: TextAlign.center,),
                                            Text("Khoder is provided 'as is' without any warranties.\nWe are not liable for user-generated content or any damages resulting from platform use.\nWe do not guarantee uninterrupted service or error-free functionality."
                                              ,style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),
                                            Text("7. Termination" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),textAlign: TextAlign.center,),
                                            Text("We may suspend or terminate access to Khoder if you violate these Terms.\nYou may delete your account at any time."
                                              ,style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),
                                            Text("8. Modifications to Terms" , style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Color(0xFFFF6B00),

                                            ),textAlign: TextAlign.center,),
                                            Text("We may update these Terms from time to time. Continued use of Khoder after changes signifies acceptance."
                                              ,style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                color: Theme.of(context).colorScheme.inversePrimary,
                                              ),),

                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: Text("Cancel" ,style: GoogleFonts.orbitron(
                                    fontSize: 18,
                                    color: Color(0xFFFF6B00),

                                    ),)),

                                        if(!isAccepted)
                                          TextButton(onPressed: (){
                                            isAccepted=!isAccepted;
                                            Navigator.of(context).pop();
                                          }, child: Text("Accept" ,style: GoogleFonts.orbitron(
                                            fontSize: 18,
                                            color: Color(0xFFFF6B00),

                                          ),))
                                      ],
                                    );
                                  });
                                }, child: Text("Conditions",
                                  style: GoogleFonts.roboto(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 16,
                                    color: Color(0xFFFF6B00),
                                  ),)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                ),

                SizedBox(height: 50,),
                SlideTransition(
                  position: _animation,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    opacity: isAccepted ? 1.0 : 0.0,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true, // Allows full-height bottom sheet
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
                              ),
                              child: Wrap(
                                children: [
                                  LoginOrRegister(
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    confirmPasswordController: confirmPasswordController,
                                    userNameController: userNameController,
                                    parentContext: context,
                                  )
                                ],
                              ),
                            );
                          },
                        );


                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Color(0xFFFF6B00), width: 4.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Start", style: GoogleFonts.orbitron(fontSize: 20, color: Theme.of(context).colorScheme.inversePrimary)),
                                Icon(Icons.start_outlined, color: Theme.of(context).colorScheme.inversePrimary),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )


              ],
            ),

    );
  }
}
