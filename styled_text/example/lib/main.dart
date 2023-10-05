import 'package:flutter/material.dart';
import 'package:styled_text/styled_text.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StyledText Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  String text = 'Test: editable <b>bold</b> text.';

  void _alert(BuildContext context, {String text = 'Tapped'}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _openLink(BuildContext context, Map<String?, String?> attrs) {
    final String? link = attrs['href'];

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Open Link'),
          content: Text(link ?? 'Unknown link'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('StyledText Demo'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Simple formatted text
//                 StyledText(
//                   text: 'Test: <b>bold</b> text.',
//                   tags: {
//                     'b': StyledTextTag(
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   },
//                 ),

//                 // Nested multiple styles
//                 StyledText(
//                   text: 'Test: <b>bold <i>italic</i> bold</b> text.',
//                   tags: {
//                     'b': StyledTextTag(
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     'i': StyledTextTag(
//                       style: const TextStyle(fontStyle: FontStyle.italic),
//                     ),
//                   },
//                 ),

//                 // Text with quotes
//                 StyledText(
//                   text: 'Quote test: <b>&quot;bold&quot;</b> text.',
//                   tags: {
//                     'b': StyledTextTag(
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   },
//                 ),

//                 // Multiline text without breaks
//                 const SizedBox(height: 20),
//                 StyledText(
//                   newLineAsBreaks: false,
//                   text: """Multiline text
// (wo breaks)""",
//                   tags: {
//                     'b': StyledTextTag(
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   },
//                 ),

//                 // Multiline text with breaks
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text: """Multiline text
// (with breaks)""",
//                   tags: {
//                     'b': StyledTextTag(
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   },
//                 ),

//                 // Text with icon
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text: 'Text with alarm <alarm/> icon.',
//                   tags: {
//                     'alarm': StyledTextIconTag(
//                       Icons.alarm,
//                       color: Colors.teal,
//                       size: 18,
//                       onTap: (text, attributes) =>
//                           _alert(context, text: 'Alarm Tapped'),
//                     ),
//                   },
//                 ),

//                 // Text with icon inside styled text
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text: 'Text with <red>alarm <alarm/> icon</red>.',
//                   tags: {
//                     'red': StyledTextTag(
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                     'alarm': StyledTextIconTag(
//                       Icons.alarm,
//                       color: Colors.teal,
//                       size: 18,
//                       onTap: (text, attributes) =>
//                           _alert(context, text: 'Alarm Tapped'),
//                     ),
//                   },
//                 ),

//                 // Text with link
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text:
//                       'Text with <link href="https://flutter.dev">link</link> inside.',
//                   tags: {
//                     'link': StyledTextActionTag(
//                       (_, attrs) => _openLink(context, attrs),
//                       style:
//                           const TextStyle(decoration: TextDecoration.underline),
//                     ),
//                   },
//                 ),

//                 // Text with action
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text:
//                       'Text with <action><red>red</red> action</action> inside.',
//                   tags: {
//                     'red': StyledTextTag(
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                     'action': StyledTextActionTag(
//                       (text, attributes) => _alert(context),
//                       style:
//                           const TextStyle(decoration: TextDecoration.underline),
//                     ),
//                   },
//                 ),

//                 // Text with superscript
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text: "Famous equation: E=mc<sup>2</sup>",
//                   tags: {
//                     'sup': StyledTextWidgetBuilderTag(
//                       (_, attributes, textContent) {
//                         return Transform.translate(
//                           offset: const Offset(0.5, -4),
//                           child: Text(
//                             textContent ?? "",
//                             textScaleFactor: 0.85,
//                           ),
//                         );
//                       },
//                     ),
//                   },
//                 ),

//                 // Text with subscript
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text: "The element of life: H<sub>2</sub>0",
//                   tags: {
//                     'sub': StyledTextWidgetBuilderTag(
//                       (_, attributes, textContent) {
//                         return Transform.translate(
//                           offset: const Offset(0.5, 4),
//                           child: Text(
//                             textContent ?? "",
//                             textScaleFactor: 0.8,
//                           ),
//                         );
//                       },
//                     ),
//                   },
//                 ),

//                 // Text with widget
//                 const SizedBox(height: 20),
//                 StyledText(
//                   text: 'Text with <input/> inside.',
//                   tags: {
//                     'input': StyledTextWidgetTag(
//                       const TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Input',
//                         ),
//                       ),
//                       size: const Size.fromWidth(200),
//                       constraints: BoxConstraints.tight(const Size(100, 50)),
//                     ),
//                   },
//                 ),

//                 const Divider(height: 40),

//                 // Selectable text
//                 StyledText.selectable(
//                   text: 'Test: selectable <b>bold</b> text.',
//                   tags: {
//                     'b': StyledTextTag(
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   },
//                 ),

//                 const Divider(height: 40),

                // Editable text
                StyledText.editable(
                  text: text,
                  showCursor: true,
                  onChange: (value) {
                    setState(() {
                      text = value;
                    });
                  },
                  tags: {
                    'b': StyledTextTag(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  },
                ),

                const Divider(height: 40),

                // Text with custom color tag
                // StyledText(
                //   text:
                //       'Text with custom <color text="#ff5500">color</color> text.',
                //   tags: {
                //     'color': StyledTextCustomTag(
                //         baseStyle: const TextStyle(fontStyle: FontStyle.italic),
                //         parse: (baseStyle, attributes) {
                //           if (attributes.containsKey('text') &&
                //               (attributes['text']!.substring(0, 1) == '#') &&
                //               attributes['text']!.length >= 6) {
                //             final String hexColor =
                //                 attributes['text']!.substring(1);
                //             final String alphaChannel = (hexColor.length == 8)
                //                 ? hexColor.substring(6, 8)
                //                 : 'FF';
                //             final Color color = Color(int.parse(
                //                 '0x$alphaChannel${hexColor.substring(0, 6)}'));
                //             return baseStyle?.copyWith(color: color);
                //           } else {
                //             return baseStyle;
                //           }
                //         }),
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
