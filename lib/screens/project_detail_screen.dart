import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({required this.project, super.key});
  final Project project;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(project.title)),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(project.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        Text('Category: ${project.category}'),
        const SizedBox(height: 12),
        Text('Status: ${project.status}'),
        const SizedBox(height: 12),
        Text(project.description),
      ],
    ),
  );
}
