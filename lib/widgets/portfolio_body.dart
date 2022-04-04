import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Header extends StatelessWidget {
  final String image;
  final String name;
  final String jobTitle;

  const Header({Key? key, required this.image, required this.name, required this.jobTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        CircleAvatar(
          radius: 100.0,
          backgroundImage: AssetImage(image),
        ),
        Text(
          name,
          style: const TextStyle(
            fontFamily: "Righteous",
            fontSize: 80.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          jobTitle,
          style: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 40.0,
            letterSpacing: 2.5,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 50.0,
          width: double.infinity,
          child: Divider(
            color: Colors.white70,
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 30.0,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
            width: 100.0,
            child: Divider(
              color: Colors.white70,
            )),
        const SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}

class JobTitle extends StatelessWidget {
  final String jobTitle;

  const JobTitle({Key? key, required this.jobTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(
                    Icons.work_outline,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              TextSpan(
                text:
                jobTitle,
                style: const TextStyle(
                  fontFamily: "Righteous",
                  fontSize: 25.0,
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
  const JobDescription({Key? key, required this.jobDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          jobDescription,
          style: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20.0,
            color: Colors.white70,
          ),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}

class ProgressionBar extends StatelessWidget {
  final String label;
  final double progression;

  const ProgressionBar({Key? key, required this.label, required this.progression}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20.0,
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
            minHeight: 20.0,
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

class PersonalInfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String info;

  const PersonalInfoItem({Key? key, required this.icon, required this.label, required this.info}) : super(key: key);

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
                  child: Icon(icon,
                      color: Colors.white),
                ),
              ),
              WidgetSpan(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontFamily: "Righteous",
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              WidgetSpan(
                child: Text(
                  info,
                  style: const TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20.0,
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
  final String email;

  const PersonalInfoEmail({Key? key, required this.email}) : super(key: key);

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
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.email_outlined,
                      color: Colors.white),
                ),
              ),
              const TextSpan(
                text: "Email: ",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: TextButton(
                  onPressed: () {
                    _launchEmail(widget.email);
                  },
                  child: Text(
                    widget.email,
                    style: const TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20.0,
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
  final String url;
  final String urlLabel;

  const PersonalInfoLinkedIn({Key? key, required this.url, required this.urlLabel}) : super(key: key);

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
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.people_outline,
                      color: Colors.white),
                ),
              ),
              const TextSpan(
                text: "LinkedIn: ",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: TextButton(
                  onPressed: () {
                    _launchURL(widget.url);
                  },
                  child: Text(
                    widget.urlLabel,
                    style: const TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20.0,
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
  final String phoneNumber;

  const PersonalInfoPhoneNumber({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PersonalInfoPhoneNumber> createState() => _PersonalInfoPhoneNumberState();
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
              const WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Icon(Icons.phone_outlined,
                      color: Colors.white),
                ),
              ),
              const TextSpan(
                text: "Phone Number: ",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              WidgetSpan(
                child: TextButton(
                  onPressed: () => setState(() {
                    _makePhoneCall(widget.phoneNumber);
                  }),
                  child: Text(
                    widget.phoneNumber,
                    style: const TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20.0,
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