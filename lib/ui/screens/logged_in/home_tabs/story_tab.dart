import 'package:flutter/material.dart';

import '../../../widgets/list_item/story_item.dart';

class StoryTab extends StatefulWidget {
  const StoryTab({Key? key}) : super(key: key);

  @override
  State<StoryTab> createState() => _StoryTabState();
}

class _StoryTabState extends State<StoryTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            const StoryItem(self: true,),
            for (int i = 0; i < 10; i++)
              const StoryItem()
          ],
        ),
      ),
    );
  }
}