import 'package:bganalysis/page/splashScreenPage.dart';
import 'package:bganalysis/provider/salesProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SalesProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 250, 250, 250),
      colorScheme: ColorScheme(
        primary: Color.fromARGB(255, 97, 99, 99),
        primaryContainer: Colors.tealAccent,
        secondary: Colors.amber,
        secondaryContainer: Colors.amberAccent,
        surface: Colors.white,
        background: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(250, 250, 250, 250),
        titleTextStyle:
            TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        iconTheme: IconThemeData(color: Color.fromARGB(255, 10, 10, 10)),
      ),
      useMaterial3: true,
      primaryColor: Colors.teal,
      hintColor: Color.fromARGB(255, 99, 94, 94),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color.fromARGB(255, 57, 58, 58),
        textTheme: ButtonTextTheme.primary,
      ),
      iconTheme: IconThemeData(color: Colors.teal),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  Color.fromARGB(255, 226, 224, 224)), // Default border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Color.fromARGB(255, 216, 218,
                  218)), // Border color when the field is enabled
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Color.fromARGB(
                  255, 85, 84, 83)), // Border color when the field is focused
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 1,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        contentTextStyle: TextStyle(color: Colors.grey, fontSize: 16),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.teal,
        unselectedLabelColor: Colors.grey,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey,
        thickness: 1,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.teal,
        contentTextStyle: TextStyle(color: Colors.white),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.teal,
        inactiveTrackColor: Colors.grey,
        thumbColor: Colors.teal,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(Colors.teal),
        trackColor: MaterialStateProperty.all(Colors.teal.withOpacity(0.5)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200],
        disabledColor: Colors.grey[400],
        selectedColor: Colors.teal,
        secondarySelectedColor: Colors.tealAccent,
        padding: EdgeInsets.all(4),
        labelStyle: TextStyle(color: Colors.black),
        secondaryLabelStyle: TextStyle(color: Colors.white),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BUSINESS GURU',
      theme: appTheme,
      initialRoute: '/splashScreen', // Initial route
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => SplashScreenPage());
  }
}
