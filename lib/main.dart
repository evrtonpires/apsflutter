import 'package:aps_5p/api_dados/api.dart';
import 'package:aps_5p/blocs/twitter_bloc.dart';
import 'package:aps_5p/screen/home/home_screen.dart';
import 'package:aps_5p/theme.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      tagText: "twitter",
      blocs: [
        Bloc((i) => TwitterBloc()),
      ],
      child: MaterialApp(
          title: 'Twitter',
          theme: myTheme,
          debugShowCheckedModeBanner: false,
          home: HomeScreen()),
    );
  }
}
