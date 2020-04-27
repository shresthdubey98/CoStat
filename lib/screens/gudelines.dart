import '../widgits/guideline_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgits/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuidelinesScreen extends StatelessWidget {
  showDialogue(BuildContext ctx, String title, String desc) {
    showDialog(
        context: ctx,
        builder: (ctx) => AlertDialog(
              title: Text(
                title,
                style: Theme.of(ctx)
                    .textTheme
                    .title
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
              content: SizedBox(
                height: 300,
                child: SingleChildScrollView(
                  child: Text(
                    desc,
                    style: Theme.of(ctx)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.grey[800]),
                  ),
                ),
              ),
            ));
  }

  final coughDes =
      'Coughing is your body’s way of getting rid of an irritant. When something irritates your throat or airway, your nervous system sends an alert to your brain. Your brain responds by telling the muscles in your chest and abdomen to contract and expel a burst of air.\nA cough is an important defensive reflex that helps protect your body from irritants like mucus, smoke, and allergens such as dust, mold, and pollen.\nCoughing is a symptom of many illnesses and conditions. Sometimes, the characteristics of your cough can give you a clue to its cause.';
  final feverDes =
      'A fever is a body temperature that is higher than normal. A normal temperature can vary from person to person, but it is usually around 98.6 F. A fever is not a disease. It is usually a sign that your body is trying to fight an illness or infection.';
  final breathingDes =
      'Experiencing breathing difficulty describes discomfort when breathing and feeling as if you can’t draw a complete breath. This can develop gradually or come on suddenly. Mild breathing problems, such as fatigue after an aerobics class, don’t fall into this category.\nBreathing difficulties can be caused by many different conditions. They can also develop as a result of stress and anxiety.\nIt’s important to note that frequent episodes of shortness of breath or sudden, intense breathing difficulty may be signs of a serious health issue that needs medical attention. You should discuss any breathing concerns with your doctor.';
  static const routeName = '/guideline-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guidelines"),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Symptoms of Covid-19",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () => showDialogue(context, "Cough", coughDes),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/cough.png',
                          width: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Cough",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialogue(context, "Fever", feverDes),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/fever.png',
                          width: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Fever",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () =>
                    showDialogue(context, "Breathing problem", breathingDes),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/breething.png',
                      width: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Breathing problem",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "DOs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.headSideMask,
                    size: 35,
                  ),
                  "Cover your nose and mouth with disposable tissue or handkerchief or  mask."),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.houseUser,
                    size: 35,
                  ),
                  "Stay at home."),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.handsWash,
                    size: 35,
                  ),
                  "Frequently wash your hands with soap and water. Avoid crowded places"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.peopleArrows,
                    size: 35,
                  ),
                  "Stay more than one arm's length distance from each other"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.bed,
                    size: 35,
                  ),
                  "Take adequate sleep and rest"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.glassWhiskey,
                    size: 35,
                  ),
                  "Drink plenty of water and eat nutritious food"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.userMd,
                    size: 35,
                  ),
                  "Person suspected with influenza like illness must consult doctor"),
              Divider(),
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "DONTs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.solidDizzy,
                    size: 35,
                  ),
                  "Do not panic."),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.handPaper,
                    size: 35,
                  ),
                  "Do not touch your face"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.headSideMask,
                    size: 35,
                  ),
                  "Do not stockpile on masks"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.walking,
                    size: 35,
                  ),
                  "Do not travel unless necessary"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.users,
                    size: 35,
                  ),
                  "Do not go to crowded places"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.newspaper,
                    size: 35,
                  ),
                  "Do not believe everything on the internet"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.thermometer,
                    size: 35,
                  ),
                  "Do not seek alternative treatments"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.capsules,
                    size: 35,
                  ),
                  "Do not take antibiotics"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.syringe,
                    size: 35,
                  ),
                  "Skip the flu shot"),
              GuideLineCard(
                  FaIcon(
                    FontAwesomeIcons.headSideCoughSlash,
                    size: 35,
                  ),
                  "Do not propagate hostility against Asians"),
            ],
          ),
        ),
      ),
    );
  }
}
