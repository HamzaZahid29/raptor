import 'package:flutter/material.dart';

import '../../../../core/theme/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Color _getMockColor(int index) {
    if (index % 7 == 0) {
      return Colors.green[700]!; // Higher contributions
    } else if (index % 6 == 0) {
      return Colors.green[500]!;
    } else if (index % 5 == 0) {
      return Colors.green[300]!;
    } else if (index % 4 == 0) {
      return Colors.green[100]!;
    } else {
      return Colors.grey[300]!; // No contribution
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        SliverAppBar(
          centerTitle: false,
          title: Text('Your Monthly Attendance'),
          floating: true,
          pinned: true,
          expandedHeight: 200.0, // Adjust this height as needed
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Additional Information',
                    style:AppTextStyles.headlineSmall(context)
                  ),
                  SizedBox(height: 10), // Add some spacing if needed
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ListTile(
                title: Text('Item 1'),
              ),
              ListTile(
                title: Text('Item 2'),
              ),
              ListTile(
                title: Text('Item 3'),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}