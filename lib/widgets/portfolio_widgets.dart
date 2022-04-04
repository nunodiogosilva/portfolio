import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  final String image;
  final double imageSize;
  final String name;
  final double nameSize;
  final String jobTitle;
  final double jobTitleSize;
  final double jobTitleSpacing;
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
      required this.spacerSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: imageSize,
          backgroundImage: AssetImage(image),
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: "Righteous",
            fontSize: nameSize,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          jobTitle,
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: jobTitleSize,
            letterSpacing: jobTitleSpacing,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: spacerSize,
          width: double.infinity,
          child: const Divider(
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

class JobTitle extends StatelessWidget {
  final double iconSize;
  final String jobTitle;
  final double labelFontSize;

  const JobTitle(
      {Key? key,
      required this.iconSize,
      required this.jobTitle,
      required this.labelFontSize})
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
                text: jobTitle,
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: labelFontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}

class JobDescription extends StatelessWidget {
  final String jobDescription;
  final double labelFontSize;
  final double spacerSize;

  const JobDescription(
      {Key? key,
      required this.jobDescription,
      required this.labelFontSize,
      required this.spacerSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          jobDescription,
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

class ProgressionBar extends StatelessWidget {
  final String label;
  final double labelFontSize;
  final double progression;

  const ProgressionBar(
      {Key? key,
      required this.label,
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
          width: 300.0,
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
  final String urlLabel;

  const PersonalInfoLinkedIn(
      {Key? key,
      required this.iconSize,
      required this.labelFontSize,
      required this.url,
      required this.urlLabel})
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
                    widget.urlLabel,
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
