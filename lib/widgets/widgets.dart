import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';

/// Background
class Background extends StatefulWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff151518),
            Color(0xff151518),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: widget.child,
    );
  }
}

/// Header
class Header extends StatefulWidget {
  final String image;
  final double imageSize;
  final String name;
  final double nameSize;
  final String jobTitle;
  final double jobTitleSize;
  final double jobTitleSpacing;
  final double iconButtonSize;
  final double iconButtonSpacerSize;
  final double spacerSize;

  const Header(
      {Key? key,
      required this.image,
      required this.imageSize,
      required this.name,
      required this.nameSize,
      required this.jobTitle,
      required this.jobTitleSize,
      required this.jobTitleSpacing,
      required this.iconButtonSize,
      required this.iconButtonSpacerSize,
      required this.spacerSize})
      : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Couldn't redirect to $url";
    }
  }

  final nameController = TextEditingController();
  final jobTitleController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    jobTitleController.text = widget.jobTitle;
  }

  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
        emailController.text = "";
        passwordController.text = "";
        Navigator.of(context).pop();
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().split("]")[1],
            ),
          ),
        );
      }
    }

    Future signInDialog() => showDialog(
      context: context,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: const Color(0xff0d0d0f),
            title: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset("images/admin_unlocked.png",
                          height: widget.iconButtonSize),
                    ),
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              height: 350,
              width: 300,
              child: Column(
                children: [
                  Column(
                    children: const [
                      Text(
                        "If you're not Nuno Silva, you shouldn't be here!",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Curious on what's behind this? Here is a sneak peak!",
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.white54,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: const InputDecoration(
                      fillColor: Color(0xff151518),
                      filled: true,
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white54,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white54,
                      )),
                    ),
                    style: const TextStyle(
                      fontFamily: "Righteous",
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.white54,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      fillColor: Color(0xff151518),
                      filled: true,
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white54,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white54,
                      )),
                    ),
                    style: const TextStyle(
                      fontFamily: "Righteous",
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white54,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Color(0xff151518),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: signIn,
                      child: const Icon(
                        Icons.input_outlined,
                        color: Color(0xff151518),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: CircleAvatar(
                                radius: widget.imageSize,
                                backgroundImage: AssetImage(widget.image),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: ElevatedButton(
                                onPressed: () async {
                                  final results =
                                      await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.any,
                                  );

                                  if (results == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("No image selected."),
                                      ),
                                    );
                                    return;
                                  }

                                  final path = results.files.first.bytes;
                                  final imageName = results.files.first.name;

                                  print(path);
                                  print(imageName);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: const Text(
                                  "Upload Image",
                                  style: TextStyle(
                                    fontFamily: "Righteous",
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff151518),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: nameController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                          ),
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.nameSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: jobTitleController,
                          cursorColor: Colors.white54,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Job Title",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                          ),
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.jobTitleSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white54,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Icon(
                              Icons.save_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                  width: double.infinity,
                  child: const Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Signed out!"),
                      ),
                    );
                    FirebaseAuth.instance.signOut();
                  },
                  icon: Image.asset("images/admin_unlocked.png"),
                  iconSize: widget.iconButtonSize,
                  tooltip: "Admin View",
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: widget.imageSize,
                  backgroundImage: AssetImage(widget.image),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: widget.nameSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.jobTitle,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.jobTitleSize,
                    letterSpacing: widget.jobTitleSpacing,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                  width: double.infinity,
                  child: const Divider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset("images/pdf.png"),
                      iconSize: widget.iconButtonSize,
                      tooltip: "Download CV PDF",
                    ),
                    SizedBox(
                      width: widget.iconButtonSpacerSize,
                    ),
                    IconButton(
                      onPressed: () {
                        _launchURL(
                            "https://github.com/nunodiogosilva/portfolio");
                      },
                      icon: Image.asset("images/github.png"),
                      iconSize: widget.iconButtonSize,
                      tooltip: "Github Repository",
                    ),
                    SizedBox(
                      width: widget.iconButtonSpacerSize,
                    ),
                    IconButton(
                      onPressed: () {
                        signInDialog();
                      },
                      icon: Image.asset("images/admin.png"),
                      iconSize: widget.iconButtonSize,
                      tooltip: "Admin View",
                    ),
                  ],
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Personal Information
class PersonalInfo extends StatefulWidget {
  final double titleSize;
  final double titleUnderlineSize;
  final double iconSize;
  final String nationality;
  final String email;
  final String linkedInUrl;
  final String linkedInLabel;
  final String phoneNumber;
  final String locationLabel;
  final String locationUrl;
  final double labelFontSize;
  final double spacerSize;
  final double widgetSpacerSize;

  const PersonalInfo(
      {Key? key,
      required this.titleSize,
      required this.titleUnderlineSize,
      required this.iconSize,
      required this.nationality,
      required this.email,
      required this.linkedInUrl,
      required this.linkedInLabel,
      required this.phoneNumber,
      required this.locationLabel,
      required this.locationUrl,
      required this.labelFontSize,
      required this.spacerSize,
      required this.widgetSpacerSize})
      : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  _launchEmail(String email) async {
    launch("mailto:$email");
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Couldn't redirect to $url";
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw "Couldn't call $phoneNumber";
    }
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> updatePersonalInfo(nationality, email, linkedInLabel,
      linkedInUrl, phoneNumber, locationLabel, locationUrl) {
    return person
        .doc('personDetails')
        .update({
          'nationality': nationality,
          'email': email,
          'linkedIn.label': linkedInLabel,
          'linkedIn.url': linkedInUrl,
          'phoneNumber': phoneNumber,
          'location.label': locationLabel,
          'location.url': locationUrl
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Personal Info successfully updated!",
                ),
              ),
            ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Unable to update Personal Info!",
                ),
              ),
            ));
  }

  final nationalityController = TextEditingController();
  final emailController = TextEditingController();
  final linkedInUrlController = TextEditingController();
  final linkedInLabelController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final locationUrlController = TextEditingController();
  final locationLabelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nationalityController.text = widget.nationality;
    emailController.text = widget.email;
    linkedInUrlController.text = widget.linkedInUrl;
    linkedInLabelController.text = widget.linkedInLabel;
    phoneNumberController.text = widget.phoneNumber;
    locationLabelController.text = widget.locationLabel;
    locationUrlController.text = widget.locationUrl;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PERSONAL INFORMATION",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.flag_outlined,
                                  color: Colors.white70, size: widget.iconSize),
                            ),
                            Text(
                              "Nationality: ",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.labelFontSize,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: nationalityController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Nationality",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.email_outlined,
                                  color: Colors.white70, size: widget.iconSize),
                            ),
                            Text(
                              "Email: ",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.labelFontSize,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: emailController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.people_outline,
                                  color: Colors.white70, size: widget.iconSize),
                            ),
                            Text(
                              "LinkedIn: ",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.labelFontSize,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: linkedInLabelController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Label",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: linkedInUrlController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Url",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.phone_outlined,
                                  color: Colors.white70, size: widget.iconSize),
                            ),
                            Text(
                              "Phone Number: ",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.labelFontSize,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: phoneNumberController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Phone Number",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(Icons.room_outlined,
                                  color: Colors.white70, size: widget.iconSize),
                            ),
                            Text(
                              "Location: ",
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.labelFontSize,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: locationLabelController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Label",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: locationUrlController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Url",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: widget.labelFontSize,
                                  color: Colors.white54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              updatePersonalInfo(
                                  nationalityController.text,
                                  emailController.text,
                                  linkedInLabelController.text,
                                  linkedInUrlController.text,
                                  phoneNumberController.text,
                                  locationLabelController.text,
                                  locationUrlController.text);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Icon(
                              Icons.save_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.widgetSpacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PERSONAL INFORMATION",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.flag_outlined,
                              color: Colors.white70, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Nationality: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          widget.nationality,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.email_outlined,
                              color: Colors.white70, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Email: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            _launchEmail(widget.email);
                          },
                          child: Text(
                            widget.email,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "OpenSans",
                              fontSize: widget.labelFontSize,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.people_outline,
                              color: Colors.white70, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "LinkedIn: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(widget.linkedInUrl);
                          },
                          child: Text(
                            widget.linkedInLabel,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "OpenSans",
                              fontSize: widget.labelFontSize,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.phone_outlined,
                              color: Colors.white70, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Phone Number: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _makePhoneCall(widget.phoneNumber);
                          }),
                          child: Text(
                            widget.phoneNumber,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "OpenSans",
                              fontSize: widget.labelFontSize,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.room_outlined,
                              color: Colors.white70, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Location: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            _launchURL(widget.locationUrl);
                          },
                          child: Text(
                            widget.locationLabel,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: "OpenSans",
                              fontSize: widget.labelFontSize,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.widgetSpacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Profile
class Profile extends StatefulWidget {
  final double titleSize;
  final double titleUnderlineSize;
  final String profile;
  final double labelFontSize;
  final double spacerSize;
  final double widgetSpacerSize;

  const Profile(
      {Key? key,
      required this.titleSize,
      required this.titleUnderlineSize,
      required this.profile,
      required this.labelFontSize,
      required this.spacerSize,
      required this.widgetSpacerSize})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final profileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileController.text = widget.profile;
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> updateProfile(profile) {
    return person
        .doc('personDetails')
        .update({
      'profile': profile
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Profile successfully updated!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to update Profile!",
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROFILE",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: profileController,
                          maxLines: 6,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Profile description",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                          ),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white54,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (profileController.text != widget.profile) {
                                updateProfile(profileController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            child: const Icon(
                              Icons.save_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.widgetSpacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROFILE",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
                Text(
                  widget.profile,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white54,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.widgetSpacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Skills Section Title
class SkillsSectionTitle extends StatefulWidget {
  final double iconButtonSize;
  final double titleSize;
  final double titleUnderlineSize;
  final double spacerSize;

  const SkillsSectionTitle(
      {Key? key,
        required this.iconButtonSize,
        required this.titleSize,
        required this.titleUnderlineSize,
        required this.spacerSize})
      : super(key: key);

  @override
  State<SkillsSectionTitle> createState() => _SkillsSectionTitleState();
}

class _SkillsSectionTitleState extends State<SkillsSectionTitle> {
  final skillController = TextEditingController();
  final percentageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    skillController.text = "";
    percentageController.text = "";
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> addSkill(skill) {
    return person
        .doc('personDetails')
        .set({
      'skills': FieldValue.arrayUnion(skill),
    },
      SetOptions(merge: true),
    )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Skill successfully added!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to add Skill!",
        ),
      ),
    ));
  }

  Future addSkillDialog() => showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: const Color(0xff0d0d0f),
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.star_outline,
                      color: Colors.white,
                      size: widget.iconButtonSize,
                    ),
                  ),
                  const Text(
                    "Add Skill",
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 150,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: skillController,
                  cursorColor: Colors.white54,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    fillColor: Color(0xff151518),
                    filled: true,
                    hintText: "Skill",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                  ),
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: percentageController,
                    cursorColor: Colors.white54,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      fillColor: Color(0xff151518),
                      filled: true,
                      hintText: "%",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                          )),
                    ),
                    style: const TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                    ),
                    onPressed: () {
                      skillController.text = "";
                      percentageController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Color(0xff151518),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async{
                      List<dynamic> skill = [
                        {
                          'skill': skillController.text,
                          'percentage': percentageController.text
                        }
                      ];
                      addSkill(skill);
                      skillController.text = "";
                      percentageController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SKILLS",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      addSkillDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SKILLS",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Skills
class Skills extends StatefulWidget {
  final String label;
  final double progressionBarWidth;
  final double labelFontSize;
  final String progression;
  final double spacerSize;

  const Skills(
      {Key? key,
        required this.label,
        required this.progressionBarWidth,
        required this.labelFontSize,
        required this.progression,
        required this.spacerSize})
      : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final labelController = TextEditingController();
  final progressionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.label;
    progressionController.text = widget.progression;
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> updateSkill(skill) {
    return person
        .doc('personDetails')
        .update({
      'skills': FieldValue.arrayUnion(skill),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Skills successfully updated!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to update Skills!",
        ),
      ),
    ));
  }

  Future<void> deleteSkill(skill) {
    return person
        .doc('personDetails')
        .update({
      'skills': FieldValue.arrayRemove(skill),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Skills successfully deleted!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to delete Skills!",
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: labelController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Label",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                )),
                          ),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: widget.progressionBarWidth,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white30,
                            color: Colors.white70,
                            minHeight: widget.labelFontSize,
                            value: double.parse(progressionController.text),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: progressionController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              fillColor: Color(0xff151518),
                              filled: true,
                              hintText: "%",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                            ),
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: widget.labelFontSize,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1.0,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (labelController.text != widget.label  || progressionController.text != widget.progression) {
                                    List<dynamic> updatedSkill = [
                                      {
                                        'skill': labelController.text,
                                        'percentage': progressionController.text
                                      }
                                    ];
                                    updateSkill(updatedSkill);

                                    List<dynamic> outdatedSkill = [
                                      {
                                        'skill': widget.label,
                                        'percentage': widget.progression
                                      }
                                    ];
                                    deleteSkill(outdatedSkill);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.save_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  List<dynamic> skill = [
                                    {
                                      'skill': widget.label,
                                      'percentage': widget.progression
                                    }
                                  ];
                                  deleteSkill(skill);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: widget.progressionBarWidth,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white30,
                    color: Colors.white70,
                    minHeight: widget.labelFontSize,
                    value: double.parse(widget.progression),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Job Section Title
class JobSectionTitle extends StatefulWidget {
  final double iconButtonSize;
  final double titleSize;
  final double titleUnderlineSize;
  final double spacerSize;

  const JobSectionTitle(
      {Key? key,
        required this.iconButtonSize,
        required this.titleSize,
        required this.titleUnderlineSize,
        required this.spacerSize})
      : super(key: key);

  @override
  State<JobSectionTitle> createState() => _JobSectionTitleState();
}

class _JobSectionTitleState extends State<JobSectionTitle> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = "";
    descriptionController.text = "";
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> addJob(job) {
    return person
        .doc('personDetails')
        .set({
      'jobs': FieldValue.arrayUnion(job),
    },
      SetOptions(merge: true),
    )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Professional Experience successfully added!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to add Professional Experience!",
        ),
      ),
    ));
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null && datePicker != startDate) {
      setState(() {
        startDate = datePicker;
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null && datePicker != endDate) {
      setState(() {
        endDate = datePicker;
      });
    }
  }

  Future addJobDialog() => showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: const Color(0xff0d0d0f),
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.work_outline,
                      color: Colors.white,
                      size: widget.iconButtonSize,
                    ),
                  ),
                  const Text(
                    "Add Job",
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 350,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  maxLines: 3,
                  cursorColor: Colors.white54,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  decoration: const InputDecoration(
                    fillColor: Color(0xff151518),
                    filled: true,
                    hintText: "Job Title",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                  ),
                  style: const TextStyle(
                    fontFamily: "Righteous",
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${startDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${startDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                            style: const TextStyle(
                              fontFamily: "OpenSans",
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                selectStartDate(context);
                              });
                            },
                            child: const Icon(
                              Icons.today_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${endDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${endDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                            style: const TextStyle(
                              fontFamily: "OpenSans",
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                selectEndDate(context);
                              });
                            },
                            child: const Icon(
                              Icons.event_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  cursorColor: Colors.white54,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    fillColor: Color(0xff151518),
                    filled: true,
                    hintText: "Job Description",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                  ),
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                    ),
                    onPressed: () {
                      titleController.text = "";
                      startDate = DateTime.now();
                      endDate = DateTime.now();
                      descriptionController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Color(0xff151518),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async{
                      List<dynamic> job = [
                        {
                          'title': titleController.text,
                          'time':
                          {
                            'start': startDate,
                            'end': endDate
                          },
                          'description': descriptionController.text
                        }
                      ];
                      addJob(job);
                      titleController.text = "";
                      startDate = DateTime.now();
                      endDate = DateTime.now();
                      descriptionController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROFESSIONAL EXPERIENCE",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      addJobDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PROFESSIONAL EXPERIENCE",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Job
class Job extends StatefulWidget {
  final double iconSize;
  final String title;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String description;
  final double labelFontSize;
  final double spacerSize;

  const Job(
      {Key? key,
      required this.iconSize,
      required this.title,
      required this.timeStart,
      required this.timeEnd,
      required this.description,
      required this.labelFontSize,
      required this.spacerSize})
      : super(key: key);

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  final titleController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
    startController.text = "${widget.timeStart}";
    endController.text = "${widget.timeEnd}";
    descriptionController.text = widget.description;
  }

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: widget.timeStart,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null) {
      setState(() {
        startController.text = "$datePicker";
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: widget.timeEnd,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null) {
      setState(() {
        endController.text = "$datePicker";
      });
    }
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> updateJob(job) {
    return person
        .doc('personDetails')
        .update({
      'jobs': FieldValue.arrayUnion(job),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Professional Experience successfully updated!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to update Professional Experience!",
        ),
      ),
    ));
  }

  Future<void> deleteJob(job) {
    return person
        .doc('personDetails')
        .update({
      'jobs': FieldValue.arrayRemove(job),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Professional Experience successfully deleted!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to delete Professional Experience!",
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.work_outline,
                                color: Colors.white70,
                                size: widget.iconSize,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: titleController,
                                maxLines: 3,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Job Title",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white54,
                                  )),
                                ),
                                style: TextStyle(
                                  fontFamily: "Righteous",
                                  fontSize: widget.iconSize,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateTime.parse(startController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${DateTime.parse(startController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: widget.labelFontSize,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectStartDate(context);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.today_outlined,
                                    color: Color(0xff151518),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: widget.spacerSize,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateTime.parse(endController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${DateTime.parse(endController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: widget.labelFontSize,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectEndDate(context);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.event_outlined,
                                    color: Color(0xff151518),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: widget.labelFontSize,
                        ),
                        TextField(
                          controller: descriptionController,
                          maxLines: 6,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Job description",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                          ),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white54,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (titleController.text != widget.title || DateTime.parse(startController.text) != widget.timeStart || DateTime.parse(endController.text) != widget.timeEnd || descriptionController.text != widget.description) {
                                    List<dynamic> updatedJob = [
                                      {
                                        'title': titleController.text,
                                        'time':
                                        {
                                          'start': DateTime.parse(startController.text),
                                          'end': DateTime.parse(endController.text)
                                        },
                                        'description': descriptionController.text
                                      }
                                    ];
                                    updateJob(updatedJob);

                                    List<dynamic> outdatedJob = [
                                      {
                                        'title': widget.title,
                                        'time':
                                        {
                                          'start': widget.timeStart,
                                          'end': widget.timeEnd
                                        },
                                        'description': widget.description
                                      }
                                    ];
                                    deleteJob(outdatedJob);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.save_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  List<dynamic> job = [
                                    {
                                      'title': widget.title,
                                      'time':
                                      {
                                        'start': widget.timeStart,
                                        'end': widget.timeEnd
                                      },
                                      'description': widget.description
                                    }
                                  ];
                                  deleteJob(job);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.work_outline,
                            color: Colors.white70,
                            size: widget.iconSize,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: widget.title,
                        style: TextStyle(
                          fontFamily: "Righteous",
                          fontSize: widget.iconSize,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                widget.timeStart == widget.timeEnd ? Text(
                  "(${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()} - at the moment)",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white54,
                  ),
                ) : Text(
                  "(${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()} - ${widget.timeEnd.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${widget.timeEnd.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()})",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white54,
                  ),
                ),
                SizedBox(
                  height: widget.labelFontSize,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white54,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Education Section Title
class EducationSectionTitle extends StatefulWidget {
  final double iconButtonSize;
  final double titleSize;
  final double titleUnderlineSize;
  final double spacerSize;

  const EducationSectionTitle(
      {Key? key,
        required this.iconButtonSize,
        required this.titleSize,
        required this.titleUnderlineSize,
        required this.spacerSize})
      : super(key: key);

  @override
  State<EducationSectionTitle> createState() => _EducationSectionTitleState();
}

class _EducationSectionTitleState extends State<EducationSectionTitle> {
  final academyController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    academyController.text = "";
    courseController.text = "";
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> addEducation(education) {
    return person
        .doc('personDetails')
        .set({
      'education': FieldValue.arrayUnion(education),
    },
      SetOptions(merge: true),
    )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Education successfully added!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to add Education!",
        ),
      ),
    ));
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null && datePicker != startDate) {
      setState(() {
        startDate = datePicker;
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null && datePicker != endDate) {
      setState(() {
        endDate = datePicker;
      });
    }
  }

  Future addEducationDialog() => showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: const Color(0xff0d0d0f),
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.domain_outlined,
                      color: Colors.white,
                      size: widget.iconButtonSize,
                    ),
                  ),
                  const Text(
                    "Add Education",
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 350,
            width: 300,
            child: Column(
              children: [
                TextField(
                  controller: academyController,
                  maxLines: 2,
                  cursorColor: Colors.white54,
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  decoration: const InputDecoration(
                    fillColor: Color(0xff151518),
                    filled: true,
                    hintText: "Academy",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                  ),
                  style: const TextStyle(
                    fontFamily: "Righteous",
                    fontWeight: FontWeight.bold,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: courseController,
                  maxLines: 2,
                  cursorColor: Colors.white54,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    fillColor: Color(0xff151518),
                    filled: true,
                    hintText: "Course",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                  ),
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${startDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${startDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                            style: const TextStyle(
                              fontFamily: "OpenSans",
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                selectStartDate(context);
                              });
                            },
                            child: const Icon(
                              Icons.today_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${endDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${endDate.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                            style: const TextStyle(
                              fontFamily: "OpenSans",
                              color: Colors.white54,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                selectEndDate(context);
                              });
                            },
                            child: const Icon(
                              Icons.event_outlined,
                              color: Color(0xff151518),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                    ),
                    onPressed: () {
                      academyController.text = "";
                      courseController.text = "";
                      startDate = DateTime.now();
                      endDate = DateTime.now();
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Color(0xff151518),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async{
                      List<dynamic> education = [
                        {
                          'academy': academyController.text,
                          'course': courseController.text,
                          'time':
                          {
                            'start': startDate,
                            'end': endDate
                          },

                        }
                      ];
                      addEducation(education);
                      academyController.text = "";
                      courseController.text = "";
                      startDate = DateTime.now();
                      endDate = DateTime.now();
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EDUCATION",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      addEducationDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EDUCATION",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Education
class Education extends StatefulWidget {
  final double iconSize;
  final String academy;
  final String course;
  final DateTime timeStart;
  final DateTime timeEnd;
  final double labelFontSize;
  final double spacerSize;

  const Education(
      {Key? key,
        required this.iconSize,
        required this.academy,
        required this.course,
        required this.timeStart,
        required this.timeEnd,
        required this.labelFontSize,
        required this.spacerSize})
      : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final academyController = TextEditingController();
  final courseController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();

  @override
  void initState() {
    super.initState();
    academyController.text = widget.academy;
    courseController.text = widget.course;
    startController.text = "${widget.timeStart}";
    endController.text = "${widget.timeEnd}";
  }

  Future<void> selectStartDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: widget.timeStart,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null) {
      setState(() {
        startController.text = "$datePicker";
      });
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    DateTime? datePicker = await showDatePicker(
      context: context,
      initialDate: widget.timeEnd,
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
      textDirection: TextDirection.ltr,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: (DateTime val) => val.weekday == 6 || val.weekday == 7 ? false : true,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xff151518), // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: const Color(0xff0d0d0f),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.white, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (datePicker != null) {
      setState(() {
        endController.text = "$datePicker";
      });
    }
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> updateEducation(education) {
    return person
        .doc('personDetails')
        .update({
      'education': FieldValue.arrayUnion(education),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Education successfully updated!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to update Education!",
        ),
      ),
    ));
  }

  Future<void> deleteEducation(education) {
    return person
        .doc('personDetails')
        .update({
      'education': FieldValue.arrayRemove(education),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Education successfully deleted!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to delete Education!",
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.domain_outlined,
                                color: Colors.white70,
                                size: widget.iconSize,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: TextField(
                                controller: academyController,
                                maxLines: 2,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xff151518),
                                  filled: true,
                                  hintText: "Academy",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white54,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white54,
                                      )),
                                ),
                                style: TextStyle(
                                  fontFamily: "Righteous",
                                  fontSize: widget.iconSize,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: courseController,
                          maxLines: 2,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Course",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white54,
                                )),
                          ),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.iconSize,
                            color: Colors.white54,
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateTime.parse(startController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${DateTime.parse(startController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: widget.labelFontSize,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectStartDate(context);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.today_outlined,
                                    color: Color(0xff151518),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: widget.spacerSize,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${DateTime.parse(endController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${DateTime.parse(endController.text).toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()}",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: widget.labelFontSize,
                                    color: Colors.white54,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectEndDate(context);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.event_outlined,
                                    color: Color(0xff151518),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (academyController.text != widget.academy || courseController.text != widget.course || DateTime.parse(startController.text) != widget.timeStart || DateTime.parse(endController.text) != widget.timeEnd) {
                                    List<dynamic> updatedEducation = [
                                      {
                                        'academy': academyController.text,
                                        'course': courseController.text,
                                        'time':
                                        {
                                          'start': DateTime.parse(startController.text),
                                          'end': DateTime.parse(endController.text)
                                        },
                                      }
                                    ];
                                    updateEducation(updatedEducation);

                                    List<dynamic> outdatedEducation = [
                                      {
                                        'academy': widget.academy,
                                        'course': widget.course,
                                        'time':
                                        {
                                          'start': widget.timeStart,
                                          'end': widget.timeEnd
                                        },
                                      }
                                    ];
                                    deleteEducation(outdatedEducation);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.save_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  List<dynamic> education = [
                                    {
                                      'academy': widget.academy,
                                      'course': widget.course,
                                      'time':
                                      {
                                        'start': widget.timeStart,
                                        'end': widget.timeEnd
                                      },
                                    }
                                  ];
                                  deleteEducation(education);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.domain_outlined,
                            color: Colors.white70,
                            size: widget.iconSize,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: widget.academy,
                        style: TextStyle(
                          fontFamily: "Righteous",
                          fontSize: widget.iconSize,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  widget.course,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.iconSize,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                widget.timeStart == widget.timeEnd ? Text(
                  "(${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()} - at the moment)",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white54,
                  ),
                ) : Text(
                  "(${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${widget.timeStart.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()} - ${widget.timeEnd.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[1].toString()}/${widget.timeEnd.toIso8601String().split('T').first.replaceAll("-", "/").substring(0, 7).split("/")[0].toString()})",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white54,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Languages Section Title
class LanguagesSectionTitle extends StatefulWidget {
  final double iconButtonSize;
  final double titleSize;
  final double titleUnderlineSize;
  final double spacerSize;

  const LanguagesSectionTitle(
      {Key? key,
        required this.iconButtonSize,
        required this.titleSize,
        required this.titleUnderlineSize,
        required this.spacerSize})
      : super(key: key);

  @override
  State<LanguagesSectionTitle> createState() => _LanguagesSectionTitleState();
}

class _LanguagesSectionTitleState extends State<LanguagesSectionTitle> {
  final languageController = TextEditingController();
  final percentageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    languageController.text = "";
    percentageController.text = "";
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> addLanguage(language) {
    return person
        .doc('personDetails')
        .set({
      'languages': FieldValue.arrayUnion(language),
    },
      SetOptions(merge: true),
    )
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Language successfully added!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to add Language!",
        ),
      ),
    ));
  }

  Future addLanguageDialog() => showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: const Color(0xff0d0d0f),
          title: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.language,
                      color: Colors.white,
                      size: widget.iconButtonSize,
                    ),
                  ),
                  const Text(
                    "Add Language",
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: double.infinity,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          content: SizedBox(
            height: 150,
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: languageController,
                  cursorColor: Colors.white54,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    fillColor: Color(0xff151518),
                    filled: true,
                    hintText: "Language",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white54,
                        )),
                  ),
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 60,
                  child: TextField(
                    controller: percentageController,
                    cursorColor: Colors.white54,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      fillColor: Color(0xff151518),
                      filled: true,
                      hintText: "%",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                          )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white54,
                          )),
                    ),
                    style: const TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.white54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            const SizedBox(
              width: double.infinity,
              child: Divider(
                color: Colors.white,
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white54,
                    ),
                    onPressed: () {
                      languageController.text = "";
                      percentageController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Color(0xff151518),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () async{
                      String fluency = "";

                      if (double.parse(percentageController.text) >= 0.96) {
                        fluency = "C2";
                      } else if (double.parse(percentageController.text) >= 0.80) {
                        fluency = "C1";
                      } else if (double.parse(percentageController.text) >= 0.64) {
                        fluency = "B2";
                      } else if (double.parse(percentageController.text) >= 0.48) {
                        fluency = "B1";
                      } else if (double.parse(percentageController.text) >= 0.32) {
                        fluency = "A2";
                      } else if (double.parse(percentageController.text) <= 0.16) {
                        fluency = "A1";
                      }
                      List<dynamic> language = [
                        {
                          'language': languageController.text,
                          'fluency': fluency,
                          'percentage': percentageController.text
                        }
                      ];
                      addLanguage(language);
                      languageController.text = "";
                      percentageController.text = "";
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LANGUAGES",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      addLanguageDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                    ),
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Color(0xff151518),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LANGUAGES",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.titleSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                    width: widget.titleUnderlineSize,
                    child: const Divider(
                      color: Colors.white,
                      thickness: 1.0,
                    )),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}

/// Languages
class Languages extends StatefulWidget {
  final String label;
  final String fluency;
  final double progressionBarWidth;
  final double labelFontSize;
  final String progression;
  final double spacerSize;

  const Languages(
      {Key? key,
      required this.label,
      required this.fluency,
      required this.progressionBarWidth,
      required this.labelFontSize,
      required this.progression,
      required this.spacerSize})
      : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  final labelController = TextEditingController();
  final progressionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.label;
    progressionController.text = widget.progression;
  }

  CollectionReference person = FirebaseFirestore.instance.collection('Person');

  Future<void> updateLanguage(language) {
    return person
        .doc('personDetails')
        .update({
      'languages': FieldValue.arrayUnion(language),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Languages successfully updated!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to update Languages!",
        ),
      ),
    ));
  }

  Future<void> deleteLanguage(language) {
    return person
        .doc('personDetails')
        .update({
      'languages': FieldValue.arrayRemove(language),
    })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Languages successfully deleted!",
        ),
      ),
    ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Unable to delete Languages!",
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white54)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white54,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: labelController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            fillColor: Color(0xff151518),
                            filled: true,
                            hintText: "Label",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white54,
                            )),
                          ),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: widget.progressionBarWidth,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white30,
                            color: Colors.white70,
                            minHeight: widget.labelFontSize,
                            value: double.parse(progressionController.text),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 60,
                          child: TextField(
                            controller: progressionController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              fillColor: Color(0xff151518),
                              filled: true,
                              hintText: "%",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white54,
                              )),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white54,
                              )),
                            ),
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: widget.labelFontSize,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Divider(
                            color: Colors.white,
                            thickness: 1.0,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (labelController.text != widget.label  || progressionController.text != widget.progression) {
                                    String updatedFluency = "";

                                    if (double.parse(progressionController.text) >= 0.96) {
                                      updatedFluency = "C2";
                                    } else if (double.parse(progressionController.text) >= 0.80) {
                                      updatedFluency = "C1";
                                    } else if (double.parse(progressionController.text) >= 0.64) {
                                      updatedFluency = "B2";
                                    } else if (double.parse(progressionController.text) >= 0.48) {
                                      updatedFluency = "B1";
                                    } else if (double.parse(progressionController.text) >= 0.32) {
                                      updatedFluency = "A2";
                                    } else if (double.parse(progressionController.text) <= 0.16) {
                                      updatedFluency = "A1";
                                    }

                                    List<dynamic> updatedLanguage = [
                                      {
                                        'language': labelController.text,
                                        'fluency': updatedFluency,
                                        'percentage': progressionController.text
                                      }
                                    ];
                                    updateLanguage(updatedLanguage);

                                    List<dynamic> outdatedLanguage = [
                                      {
                                        'language': widget.label,
                                        'fluency': widget.fluency,
                                        'percentage': widget.progression
                                      }
                                    ];
                                    deleteLanguage(outdatedLanguage);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.save_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  List<dynamic> language = [
                                    {
                                      'language': widget.label,
                                      'fluency': widget.fluency,
                                      'percentage': widget.progression
                                    }
                                  ];
                                  deleteLanguage(language);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Color(0xff151518),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          } else {
            // Normal View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.label} (${widget.fluency})",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: widget.labelFontSize,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  width: widget.progressionBarWidth,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white30,
                    color: Colors.white70,
                    minHeight: widget.labelFontSize,
                    value: double.parse(widget.progression),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: widget.spacerSize,
                ),
              ],
            );
          }
        });
  }
}
