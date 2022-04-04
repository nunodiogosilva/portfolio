import 'package:flutter/material.dart';
import 'package:portfolio/widgets/body/body_background.dart';
import 'package:portfolio/widgets/portfolio_body.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({Key? key}) : super(key: key);

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    return BodyBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(150.0, 50.0, 150.0, 50.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Header(image: "images/nunosilva.jpg", name: "Nuno Silva", jobTitle: "SOFTWARE DEVELOPER"),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SectionTitle(title: "PERSONAL INFORMATION"),
                            PersonalInfoItem(icon: Icons.flag_outlined, label: "Nationality: ", info: "Portuguese"),
                            PersonalInfoEmail(email: "xnunosilva@gmail.com"),
                            PersonalInfoLinkedIn(url: "https://www.linkedin.com/in/nunodiogosilva/", urlLabel: "linkedin.com/in/nunodiogosilva"),
                            PersonalInfoPhoneNumber(phoneNumber: "+351 936901566"),
                            SizedBox(
                              height: 40.0,
                            ),
                            SectionTitle(title: "SKILLS"),
                            ProgressionBar(label: "Python", progression: 0.9),
                            ProgressionBar(label: "JavaScript", progression: 0.80),
                            SizedBox(
                              height: 40.0,
                            ),
                            SectionTitle(title: "LANGUAGES"),
                            ProgressionBar(label: "Portuguese (Native)", progression: 1.0),
                            ProgressionBar(label: "English (Fluent)", progression: 0.95),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: VerticalDivider(
                          thickness: 2,
                          color: Colors.white70,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            SectionTitle(title: "PROFESSIONAL EXPERIENCE"),
                            JobTitle(jobTitle: "Google Search Feature Quality Specialist & Developer via Qualitest"),
                            JobDescription(jobDescription: "Member of a sub-group of Search Language Specialists (trusted team partner to Google Search and other Google engineering teams) who leverage end-to-end i18n experience to provide scaled defect triage, release reviews and approval and real-time production feature monitoring."),
                            JobTitle(jobTitle: "Nokia SoftWare - FullStack Developer"),
                            JobDescription(jobDescription: "My ultimate goal was to develop a tool that would replace MS Excel from being our day to day tool. Alongside another co-worker we've created a platform where all team's workflows were available. This tool increased work reliability, performance and generated monthly reports and performance statistics for team leaders."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 300.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
