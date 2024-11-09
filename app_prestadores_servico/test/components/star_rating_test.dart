import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_prestadores_servico/components/star_rating.dart';

void main() {
  testWidgets('StarRating exibe o número correto de estrelas preenchidas', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StarRating(rating: 3.5),
        ),
      ),
    );

    expect(find.byIcon(Icons.star), findsNWidgets(3));
    expect(find.byIcon(Icons.star_half), findsOneWidget);
    expect(find.byIcon(Icons.star_border), findsNWidgets(1));
  });

  testWidgets('StarRating chama onRatingChanged ao tocar em uma estrela', (WidgetTester tester) async {
    double? selectedRating;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StarRating(
            rating: 0,
            onRatingChanged: (rating) {
              selectedRating = rating;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.star_border).at(3));
    expect(selectedRating, 4.0);
  });
}
