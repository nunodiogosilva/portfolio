import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'background.dart';

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
        print(e);
      }
    }

    Future signInDialog() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xff151518),
            title: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset("images/admin_unlocked.png", height: widget.iconButtonSize),
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
                    color: Colors.white70,
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: const [
                        Text(
                          "If you're not Nuno Silva, you shouldn't be here!",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Curious on what's behind this? Here is a sneak peak!",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.white70,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: "Righteous",
                      color: Colors.white70,
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.white70,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(
                      fontFamily: "Righteous",
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: signIn,
                  child: const Text(
                    "Sign In",
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
        );

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white70)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: widget.imageSize,
                  backgroundImage: AssetImage(widget.image),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: 500.0,
                  child: TextField(
                    controller: nameController,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                    ),
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontSize: widget.nameSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  width: 500.0,
                  child: TextField(
                    controller: jobTitleController,
                    cursorColor: Colors.white70,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      hintText: "Job Title",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                    ),
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontSize: widget.jobTitleSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.spacerSize,
                  width: double.infinity,
                  child: const Divider(
                    color: Colors.white70,
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
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      icon: Image.asset("images/admin_unlocked.png"),
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
                    color: Colors.white70,
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

/// Section Title
class SectionTitle extends StatelessWidget {
  final String title;
  final double titleSize;
  final double titleUnderlineSize;
  final double spacerSize;

  const SectionTitle(
      {Key? key,
      required this.title,
      required this.titleSize,
      required this.titleUnderlineSize,
      required this.spacerSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: titleSize,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
            width: titleUnderlineSize,
            child: const Divider(
              color: Colors.white70,
              thickness: 1.0,
            )),
        SizedBox(
          height: spacerSize,
        ),
      ],
    );
  }
}

/// Personal Information
class PersonalInfoNationality extends StatefulWidget {
  final double iconSize;
  final String label;
  final double labelFontSize;

  const PersonalInfoNationality(
      {Key? key,
      required this.iconSize,
      required this.label,
      required this.labelFontSize})
      : super(key: key);

  @override
  State<PersonalInfoNationality> createState() =>
      _PersonalInfoNationalityState();
}

class _PersonalInfoNationalityState extends State<PersonalInfoNationality> {
  final labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Background(
                child: Center(
                    child: CircularProgressIndicator(color: Colors.white70)));
          } else if (snapshot.hasData) {
            // Admin View
            return Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.flag_outlined,
                              color: Colors.white, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Nationality: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            );/*Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.flag_outlined,
                              color: Colors.white, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Nationality: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: TextField(
                          controller: labelController,
                          cursorColor: Colors.white,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: widget.label,
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white70,
                            )),
                          ),
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            );*/
          } else {
            // Normal View
            return Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.flag_outlined,
                              color: Colors.white, size: widget.iconSize),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          "Nationality: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: widget.labelFontSize,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            );
          }
        });
  }
}

class PersonalInfoEmail extends StatefulWidget {
  final double iconSize;
  final double labelFontSize;
  final String email;

  const PersonalInfoEmail(
      {Key? key,
      required this.iconSize,
      required this.labelFontSize,
      required this.email})
      : super(key: key);

  @override
  State<PersonalInfoEmail> createState() => _PersonalInfoEmailState();
}

class _PersonalInfoEmailState extends State<PersonalInfoEmail> {
  _launchEmail(String email) async {
    launch("mailto:$email");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.email_outlined,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "Email: ",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: widget.labelFontSize,
                    color: Colors.white,
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
                      color: Colors.white70,
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
      ],
    );
  }
}

class PersonalInfoLinkedIn extends StatefulWidget {
  final double iconSize;
  final double labelFontSize;
  final String url;
  final String label;

  const PersonalInfoLinkedIn(
      {Key? key,
      required this.iconSize,
      required this.labelFontSize,
      required this.url,
      required this.label})
      : super(key: key);

  @override
  State<PersonalInfoLinkedIn> createState() => _PersonalInfoLinkedInState();
}

class _PersonalInfoLinkedInState extends State<PersonalInfoLinkedIn> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Couldn't redirect to $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.people_outline,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "LinkedIn: ",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: widget.labelFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {
                    _launchURL(widget.url);
                  },
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "OpenSans",
                      fontSize: widget.labelFontSize,
                      color: Colors.white70,
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
      ],
    );
  }
}

class PersonalInfoPhoneNumber extends StatefulWidget {
  final double iconSize;
  final double labelFontSize;
  final String phoneNumber;

  const PersonalInfoPhoneNumber(
      {Key? key,
      required this.iconSize,
      required this.labelFontSize,
      required this.phoneNumber})
      : super(key: key);

  @override
  State<PersonalInfoPhoneNumber> createState() =>
      _PersonalInfoPhoneNumberState();
}

class _PersonalInfoPhoneNumberState extends State<PersonalInfoPhoneNumber> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw "Couldn't call $phoneNumber";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.phone_outlined,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "Phone Number: ",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: widget.labelFontSize,
                    color: Colors.white,
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
                      color: Colors.white70,
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
      ],
    );
  }
}

class PersonalInfoLocation extends StatefulWidget {
  final double iconSize;
  final String label;
  final double labelFontSize;

  const PersonalInfoLocation(
      {Key? key,
      required this.iconSize,
      required this.label,
      required this.labelFontSize})
      : super(key: key);

  @override
  State<PersonalInfoLocation> createState() => _PersonalInfoLocationState();
}

class _PersonalInfoLocationState extends State<PersonalInfoLocation> {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Couldn't redirect to $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.room_outlined,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "Location: ",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: widget.labelFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () {
                    _launchURL(
                        "https://www.google.pt/maps/place/Set%C3%BAbal+Municipality/@38.5237045,-8.8641017,12z");
                  },
                  child: Text(
                    widget.label,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "OpenSans",
                      fontSize: widget.labelFontSize,
                      color: Colors.white70,
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
      ],
    );
  }
}

/// Profile
class Profile extends StatefulWidget {
  final String profile;
  final double labelFontSize;
  final double spacerSize;

  const Profile(
      {Key? key,
      required this.profile,
      required this.labelFontSize,
      required this.spacerSize})
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Background(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.white70)));
        } else if (snapshot.hasData) {
          // Admin View
          return Column(
            children: [
              TextField(
                controller: profileController,
                maxLines: 6,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "Profile description",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                ),
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
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
            children: [
              Text(
                widget.profile,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: widget.spacerSize,
              ),
            ],
          );
        }
      }
    );
  }
}

/// Job
class Job extends StatefulWidget {
  final double iconSize;
  final String title;
  final String time;
  final String description;
  final double labelFontSize;
  final double spacerSize;

  const Job(
      {Key? key,
      required this.iconSize,
      required this.title,
      required this.time,
      required this.description,
      required this.labelFontSize,
      required this.spacerSize})
      : super(key: key);

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    timeController.text = widget.time;
    descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Background(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.white70)));
        } else if (snapshot.hasData) {
          // Admin View
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
                          color: Colors.white,
                          size: widget.iconSize,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: widget.title,
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: widget.iconSize,
                        color: Colors.white,
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
                widget.time,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
                ),
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
                  hintText: "Job description",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                ),
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
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
                          color: Colors.white,
                          size: widget.iconSize,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: widget.title,
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: widget.iconSize,
                        color: Colors.white,
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
                widget.time,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
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
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: widget.spacerSize,
              ),
            ],
          );
        }
      }
    );
  }
}

/// Education
class Education extends StatefulWidget {
  final double iconSize;
  final String academy;
  final String course;
  final String time;
  final double labelFontSize;
  final double spacerSize;

  const Education(
      {Key? key,
      required this.iconSize,
      required this.academy,
      required this.course,
      required this.time,
      required this.labelFontSize,
      required this.spacerSize})
      : super(key: key);

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  final courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    courseController.text = widget.course;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Background(
              child: Center(
                  child: CircularProgressIndicator(color: Colors.white70)));
        } else if (snapshot.hasData) {
          // Admin View
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
                          color: Colors.white,
                          size: widget.iconSize,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: widget.academy,
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: widget.iconSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
                  hintText: "Course",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white70,
                      )),
                ),
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.iconSize,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                widget.time,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
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
                          color: Colors.white,
                          size: widget.iconSize,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: widget.academy,
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: widget.iconSize,
                        color: Colors.white,
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
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                widget.time,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
                ),
              ),
              SizedBox(
                height: widget.spacerSize,
              ),
            ],
          );
        }
      }
    );
  }
}

/// Skills / Languages
class ProgressionBar extends StatelessWidget {
  final String label;
  final double progressionBarWidth;
  final double labelFontSize;
  final double progression;

  const ProgressionBar(
      {Key? key,
      required this.label,
      required this.progressionBarWidth,
      required this.labelFontSize,
      required this.progression})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: labelFontSize,
            color: Colors.white70,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        SizedBox(
          width: progressionBarWidth,
          child: LinearProgressIndicator(
            backgroundColor: Colors.white30,
            color: Colors.white,
            minHeight: labelFontSize,
            value: progression,
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
