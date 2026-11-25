import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/project.dart';

void main() {
  test('Project uses the existing Django project payload', () {
    const project = Project(
      title: 'My Portfolio',
      description: 'A personal portfolio project.',
      category: 'website',
      status: 'ongoing',
    );

    expect(project.toJson(), {
      'title': 'My Portfolio',
      'description': 'A personal portfolio project.',
      'category': 'website',
      'status': 'ongoing',
    });
  });
}
