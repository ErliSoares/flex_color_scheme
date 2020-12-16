import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import '../shared/constants.dart';
import '../shared/flex_theme_mode_switch.dart';
import '../shared/page_body.dart';
import '../shared/show_theme_colors.dart';
import '../shared/theme_showcase.dart';

void main() => runApp(const DemoApp());

// -----------------------------------------------------------------------------
// EXAMPLE 2)
//
// This example shows how you can define your own FlexSchemeData and create a
// FlexColorScheme based theme from it.
// A theme showcase widget shows the theme with several common Material widgets.
// -----------------------------------------------------------------------------

// Create a custom FlexSchemeData scheme with name, description and a light
// and dark FlexSchemeColor.
const FlexSchemeData customFlexScheme = FlexSchemeData(
  name: 'Custom purple',
  description: 'Purple theme created from custom defined colors.',
  light: FlexSchemeColor(
    primary: Color(0xFF4E0028),
    primaryVariant: Color(0xFF320019),
    secondary: Color(0xFF003419),
    secondaryVariant: Color(0xFF002411),
  ),
  dark: FlexSchemeColor(
    primary: Color(0xFF9E7389),
    primaryVariant: Color(0xFF775C69),
    secondary: Color(0xFF738F81),
    secondaryVariant: Color(0xFF5C7267),
  ),
);

class DemoApp extends StatefulWidget {
  const DemoApp({Key key}) : super(key: key);

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  // Used to select if we use the dark or light theme.
  ThemeMode themeMode;

  @override
  void initState() {
    themeMode = ThemeMode.light;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlexColorScheme',
      // Use the custom light scheme to define a light FlexColorScheme for the
      // app and call .toTheme method to create the slightly opinionated theme
      // from the defined custom flex scheme data.
      theme: FlexColorScheme.light(colors: customFlexScheme.light).toTheme,
      // We do the exact same definition for the dark theme, but using
      // FlexColorScheme.dark factory and the flexSchemeColor dark scheme.
      darkTheme: FlexColorScheme.dark(colors: customFlexScheme.dark).toTheme,
      // Use the above dark or light theme based on active themeMode.
      themeMode: themeMode,
      // This simple example app has only one page.
      home: HomePage(
        // We pass it the current theme mode.
        themeMode: themeMode,
        // On the home page we toggle theme mode between light and dark.
        onThemeModeChanged: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
        // Pass in the FlexSchemeData we use for active theme. Not really
        // needed to use FlexColorScheme, but we will use it to show the
        // active theme's name, descriptions and colors in the demo.
        // We also use it for a custom theme mode switch that shows the theme's
        // color's in the different theme modes.
        flexSchemeData: customFlexScheme,
      ),
    );
  }
}

// The content of the HomePage below is not relevant for using FlexColorScheme
// based application theming. The critical parts are in the above MaterialApp
// theme definitions. The HomePage just contains UI to visually show what the
// defined example looks like in an application and with commonly used Widgets.
class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
    @required this.themeMode,
    @required this.onThemeModeChanged,
    @required this.flexSchemeData,
  }) : super(key: key);
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeModeChanged;
  final FlexSchemeData flexSchemeData;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headline4 = textTheme.headline4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlexColorScheme Example 2'),
        elevation: 0,
      ),
      body: PageBody(
        child: ListView(
          padding: const EdgeInsets.all(kEdgePadding),
          children: <Widget>[
            Text('Theme', style: headline4),
            const Text(
              'This example shows how you can define your own '
              'FlexSchemeData and create a FlexColorScheme based theme '
              'from it. '
              'A theme showcase widget shows the theme with several '
              'common Material widgets.',
            ),
            // A 3-way theme mode toggle switch.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kEdgePadding),
              child: FlexThemeModeSwitch(
                themeMode: themeMode,
                onThemeModeChanged: onThemeModeChanged,
                flexSchemeData: flexSchemeData,
              ),
            ),
            const Divider(),
            // Show theme name and description.
            ListTile(
              title: Text('${flexSchemeData.name} theme'),
              subtitle: Text(flexSchemeData.description),
            ),
            // Show all key active theme colors.
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: kEdgePadding),
              child: ShowThemeColors(),
            ),
            const Divider(),
            Text('Theme Showcase', style: headline4),
            const ThemeShowcase(),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
