import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

  @override
  Widget build(BuildContext context) {
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
                _launchURL("https://github.com/nunodiogosilva/portfolio");
              },
              icon: Image.asset("images/github.png"),
              iconSize: widget.iconButtonSize,
              tooltip: "Github Repository",
            ),
            SizedBox(
              width: widget.iconButtonSpacerSize,
            ),
            IconButton(
              onPressed: () {},
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
}

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
            )),
        SizedBox(
          height: spacerSize,
        ),
      ],
    );
  }
}

/// Personal Information
class PersonalInfoNationality extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.flag_outlined,
                      color: Colors.white, size: iconSize),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "Nationality: ",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: labelFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              WidgetSpan(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: labelFontSize,
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
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.email_outlined,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              TextSpan(
                text: "Email: ",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: widget.labelFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.people_outline,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              TextSpan(
                text: "LinkedIn: ",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: widget.labelFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.phone_outlined,
                      color: Colors.white, size: widget.iconSize),
                ),
              ),
              TextSpan(
                text: "Phone Number: ",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: widget.labelFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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

class PersonalInfoLocation extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.room_outlined,
                      color: Colors.white, size: iconSize),
                ),
              ),
              WidgetSpan(
                child: Text(
                  "Location: ",
                  style: TextStyle(
                    fontFamily: "Righteous",
                    fontSize: labelFontSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              WidgetSpan(
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: labelFontSize,
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
}

/// Job
class Job extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.work_outline,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
              TextSpan(
                text: title,
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: iconSize,
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
          time,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: labelFontSize,
            color: Colors.white70,
          ),
        ),
        SizedBox(
          height: labelFontSize,
        ),
        Text(
          description,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: labelFontSize,
            color: Colors.white70,
          ),
        ),
        SizedBox(
          height: spacerSize,
        ),
      ],
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
