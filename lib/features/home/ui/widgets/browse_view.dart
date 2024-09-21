import 'package:chat_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(S.of(context).there_is_nothing_to_browse),);
  }
}