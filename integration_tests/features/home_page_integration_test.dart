import 'package:bloc_test/bloc_test.dart';
import 'package:degreed/core/colors.dart';
import 'package:degreed/core/di/injection_container.dart';
import 'package:degreed/feature/home/domain/entities/dad_joke_entity.dart';
import 'package:degreed/feature/home/presentation/bloc/home_bloc.dart';
import 'package:degreed/feature/home/presentation/view/home_page.dart';
import 'package:degreed/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late Widget homeWidget;
  late ThemeData themeData;
  late HomeBloc homeBloc;
  late DadJokeEntity dadJokeEntity;
  setUpAll(() {
    injectionContainer();
    themeData = ThemeData(
      textTheme: textTheme(),
      cardColor: greenShade400,
      scaffoldBackgroundColor: whiteColor,
      indicatorColor: greyColor,
    );
    homeWidget = MaterialApp(
      home: const HomePage(),
      theme: themeData,
    );
    homeBloc = MockHomeBloc();
    dadJokeEntity = DadJokeEntity(id: "236", joke: "Nothing To See Here!");
  });

  setUp(() {});

  testWidgets("Open Home Page", (tester) async {
    final initialState = DadJokesInitialState();
    whenListen(
      homeBloc,
      Stream.fromIterable([homeBloc, initialState]),
      initialState: initialState,
    );

    await tester.pumpWidget(homeWidget);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    expect(homeBloc.state, equals(isA<DadJokesInitialState>()));
  });

  testWidgets("Search for Jokes", (tester) async {
    await tester.pumpWidget(homeWidget);
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key("HomeTextField")), "what");
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 4));
    await tester.tap(find.byKey(const Key("HomeScaffoldGestureDetector")));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 4));
  });

  testWidgets("Search for Jokes", (tester) async {
    final initialState = DadJokesInitialState();
    final fetchSingleDadJokeState =
        FetchSingleDadJokeState(dadJokeEntity: dadJokeEntity);
    whenListen(
      homeBloc,
      Stream.fromIterable([initialState, fetchSingleDadJokeState]),
      initialState: initialState,
    );

    await tester.pumpWidget(homeWidget);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    await expectLater(
        homeBloc.stream,
        emitsInOrder(
          <Matcher>[
            equals(initialState),
            equals(fetchSingleDadJokeState),
            emitsDone
          ],
        ));
  });

  tearDownAll(() {});
}
