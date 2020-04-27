import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GuideLineCard extends StatelessWidget{
  final FaIcon icon;
  final String guideline;

  GuideLineCard(this.icon, this.guideline);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(guideline, style: Theme.of(context).textTheme.title,),
      enabled: false,
    );
  }
}