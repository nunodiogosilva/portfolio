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
                      fillColor: Color(0xff151518),
                      filled: true,
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
                      fillColor: Color(0xff151518),
                      filled: true,
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
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white70,
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
                                  final results = await FilePicker.platform.pickFiles(
                                    allowMultiple: false,
                                    type: FileType.any,
                                  );

                                  if (results == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "No image selected."
                                        ),
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: jobTitleController,
                          cursorColor: Colors.white70,
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
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white70,
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
                            child: const Icon(Icons.save_outlined, color: Color(0xff151518),),
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
                    color: Colors.white70,
                    thickness: 1.0,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signed out!"),),);
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
class PersonalInfo extends StatefulWidget {
  final double iconSize;
  final String nationality;
  final String email;
  final String linkedInUrl;
  final String linkedInLabel;
  final String phoneNumber;
  final String locationLabel;
  final String locationUrl;
  final double labelFontSize;

  const PersonalInfo(
      {Key? key,
        required this.iconSize,
        required this.nationality,
        required this.email,
        required this.linkedInUrl,
        required this.linkedInLabel,
        required this.phoneNumber,
        required this.locationLabel,
        required this.locationUrl,
        required this.labelFontSize})
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
                    child: CircularProgressIndicator(color: Colors.white70)));
          } else if (snapshot.hasData) {
            // Admin View
            return Container(
              decoration: BoxDecoration(
                color: const Color(0xff0d0d0f),
                border: Border.all(
                  color: Colors.white70,
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
                              color: Colors.white, size: widget.iconSize),
                        ),
                        Text(
                          "Nationality: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 350,
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
                              color: Colors.white, size: widget.iconSize),
                        ),
                        Text(
                          "Email: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 350,
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
                              color: Colors.white, size: widget.iconSize),
                        ),
                        Text(
                          "LinkedIn: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 175,
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
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 175,
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
                              color: Colors.white, size: widget.iconSize),
                        ),
                        Text(
                          "Phone Number: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 350,
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
                              color: Colors.white, size: widget.iconSize),
                        ),
                        Text(
                          "Location: ",
                          style: TextStyle(
                            fontFamily: "Righteous",
                            fontSize: widget.labelFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 175,
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
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 1,
                          child: SizedBox(
                            width: 175,
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
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Divider(
                          color: Colors.white70,
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
                        child: const Icon(Icons.save_outlined, color: Color(0xff151518),),
                      ),
                    ),
                  ],
                ),
              ),
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
                          widget.nationality,
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
                            _launchURL(widget.linkedInUrl);
                          },
                          child: Text(
                            widget.linkedInLabel,
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
                                widget.locationUrl);
                          },
                          child: Text(
                            widget.locationLabel,
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
        });
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff0d0d0f),
                  border: Border.all(
                    color: Colors.white70,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: Colors.white70,
                            thickness: 1.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              child: const Icon(Icons.save_outlined, color: Color(0xff151518),),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: const Icon(Icons.delete_forever_outlined, color: Colors.white,),
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
            children: [
              Text(
                widget.profile,
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: widget.labelFontSize,
                  color: Colors.white70,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Divider(
                    color: Colors.white70,
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
  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.title;
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff0d0d0f),
                  border: Border.all(
                    color: Colors.white70,
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
                              color: Colors.white,
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
                                      color: Colors.white70,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white70,
                                    )),
                              ),
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.iconSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                          fillColor: Color(0xff151518),
                          filled: true,
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: Colors.white70,
                            thickness: 1.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              child: const Icon(Icons.save_outlined, color: Color(0xff151518),),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: const Icon(Icons.delete_forever_outlined, color: Colors.white,),
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
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Divider(
                    color: Colors.white70,
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
  final academyController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    academyController.text = widget.academy;
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
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xff0d0d0f),
                  border: Border.all(
                    color: Colors.white70,
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
                              color: Colors.white,
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
                                      color: Colors.white70,
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white70,
                                    )),
                              ),
                              style: TextStyle(
                                fontFamily: "Righteous",
                                fontSize: widget.iconSize,
                                color: Colors.white,
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
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Divider(
                            color: Colors.white70,
                            thickness: 1.0,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                              child: const Icon(Icons.save_outlined, color: Color(0xff151518),),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                              ),
                              child: const Icon(Icons.delete_forever_outlined, color: Colors.white,),
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
              const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Divider(
                    color: Colors.white70,
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
      }
    );
  }
}

/// Skills / Languages
class ProgressionBar extends StatefulWidget {
  final String label;
  final double progressionBarWidth;
  final double labelFontSize;
  final String progression;

  const ProgressionBar(
      {Key? key,
      required this.label,
      required this.progressionBarWidth,
      required this.labelFontSize,
      required this.progression})
      : super(key: key);

  @override
  State<ProgressionBar> createState() => _ProgressionBarState();
}

class _ProgressionBarState extends State<ProgressionBar> {
  final labelController = TextEditingController();
  final progressionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    labelController.text = widget.label;
    progressionController.text = widget.progression;
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
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff0d0d0f),
                    border: Border.all(
                      color: Colors.white70,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.progressionBarWidth,
                          child: TextField(
                            controller: labelController,
                            cursorColor: Colors.white,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              fillColor: Color(0xff151518),
                              filled: true,
                              hintText: "Label",
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
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: widget.progressionBarWidth,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.white30,
                            color: Colors.white,
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
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Divider(
                              color: Colors.white70,
                              thickness: 1.0,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                                child: const Icon(Icons.save_outlined, color: Color(0xff151518),),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                child: const Icon(Icons.delete_forever_outlined, color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
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
                    color: Colors.white,
                    minHeight: widget.labelFontSize,
                    value: double.parse(widget.progression),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: widget.progressionBarWidth,
                    child: const Divider(
                      color: Colors.white70,
                      thickness: 1.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            );
          }
        }
    );
  }
}
