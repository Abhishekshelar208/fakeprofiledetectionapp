import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController linkController = TextEditingController();
  String result = '';
  String profileImage = ''; // Image path for the profile
  bool _isLoading = false; // To track loading state

  // Predefined real and fake links
  final List<String> realLinks = [
    'https://www.instagram.com/weemens.in/',
    'https://www.instagram.com/__jayeshp05__/',
    'https://www.instagram.com/roshni.official111/'
  ];

  final List<String> fakeLinks = [
    'https://www.instagram.com/mr_naga271/',
    'https://www.instagram.com/salonikadam_/',
    'https://www.instagram.com/payal_wanghare/'
  ];

  void checkProfile() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate 2 seconds loading

    String inputLink = linkController.text.trim();

    if (realLinks.contains(inputLink)) {
      setState(() {
        result = 'Real Profile';
        profileImage = 'lib/assets/images/verified.png'; // Show verified image
      });
    } else if (fakeLinks.contains(inputLink)) {
      setState(() {
        result = 'Fake Profile';
        profileImage = 'lib/assets/images/nonverified.png'; // Show non-verified image
      });
    } else {
      setState(() {
        result = 'Link not recognized';
        profileImage = ''; // No image for unrecognized link
      });
    }

    setState(() {
      _isLoading = false; // Stop loading after checking
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter Profile Link",
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: linkController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: "Enter Link here...",
                  hintStyle: TextStyle(
                    color: Color(0xFF57636c),
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF1F4F8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : checkProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Check Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Show loading animation or profile image/result
            _isLoading
                ? CircularProgressIndicator(color: Colors.purple) // Loading spinner
                : Column(
              children: [
                SizedBox(height: 20),
                profileImage.isNotEmpty
                    ? Image.asset(profileImage, width: 200, height: 200)
                    : Container(), // Show image if available

                SizedBox(
                  height: 10,
                ),
                Text(
                  result,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
