import 'package:flutter/material.dart';
import 'package:selectable_group_widgets/selectable_group_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        materialTapTargetSize: MaterialTapTargetSize.padded,

        useMaterial3: false,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum ComputerComponents { processor, memory, ssd, mainboard, graphicCard }

class _MyHomePageState extends State<MyHomePage> {
  ComputerComponents singleComputerComponent = ComputerComponents.processor;
  bool assembly = false;
  Axis direction = Axis.horizontal;
  WrapAlignment alignment = WrapAlignment.start;
  WrapCrossAlignment crossAlignment = WrapCrossAlignment.center;
  WrapAlignment runAlignment = WrapAlignment.start;

  bool wrap = true;

  @override
  Widget build(BuildContext context) {
    const betweenGroups = 12.0;
    const betweenTitleGroup = 8.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          buildOptions(),
          const SizedBox(height: 8.0),
          const Text('Material'),
          const SizedBox(
            height: betweenTitleGroup,
          ),
          Container(
            color: Colors.amber,
            height: 500.0,
            child: UndefinedSelectableGroup(
              alignment: alignment,
              crossAlignment: crossAlignment,
              runAlignment: runAlignment,
              selectedGroupTheme: SelectedGroupTheme.material,
              direction: direction,
              groups: [
                RadioGroup(
                    list: [
                      RadioSelectable<ComputerComponents>(
                          text: 'Processor',
                          value: ComputerComponents.processor),
                      RadioSelectable<ComputerComponents>(
                          text: 'Memory', value: ComputerComponents.memory),
                      RadioSelectable<ComputerComponents>(
                          text: 'Ssd', value: ComputerComponents.ssd),
                      RadioSelectable<ComputerComponents>(
                          text: 'Mainboard',
                          value: ComputerComponents.mainboard),
                      RadioSelectable<ComputerComponents>(
                          text: 'Graphic Card',
                          value: ComputerComponents.graphicCard)
                    ],
                    groupValue: singleComputerComponent,
                    onChange: onChangeComputerComponent),
                CheckGroup(list: [
                  CheckSelectable(
                      identifier: 'assembly', text: 'Assembly', value: assembly)
                ], onChange: onChangeCheckbox)
              ],
              wrap: wrap,
            ),
          ),
          // const SizedBox(
          //   height: betweenGroups,
          // ),
          // const Text('Material Inkwell'),
          // const SizedBox(
          //   height: betweenTitleGroup,
          // ),
          // UndefinedSelectableGroup(
          //   direction: direction,
          //   selectedGroupTheme: SelectedGroupTheme.materialInkWell,
          //   groups: [
          //     RadioGroup(
          //         list: [
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Processor', value: ComputerComponents.processor),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Memory', value: ComputerComponents.memory),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Ssd', value: ComputerComponents.ssd),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Mainboard', value: ComputerComponents.mainboard),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Graphic Card',
          //               value: ComputerComponents.graphicCard)
          //         ],
          //         groupValue: singleComputerComponent,
          //         onChange: onChangeComputerComponent),
          //     CheckGroup(list: [
          //       CheckSelectable(
          //           identifier: 'assembly', text: 'Assembly', value: assembly)
          //     ], onChange: onChangeCheckbox)
          //   ],
          //   wrap: true,
          // ),
          // const SizedBox(
          //   height: betweenGroups,
          // ),
          // const Text('Rounded Button'),
          // const SizedBox(
          //   height: betweenTitleGroup,
          // ),
          // UndefinedSelectableGroup(
          //   direction: direction,
          //   selectedGroupTheme: SelectedGroupTheme.button,
          //   groups: [
          //     RadioGroup(
          //         list: [
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Processor', value: ComputerComponents.processor),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Memory', value: ComputerComponents.memory),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Ssd', value: ComputerComponents.ssd),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Mainboard', value: ComputerComponents.mainboard),
          //           RadioSelectable<ComputerComponents>(
          //               text: 'Graphic Card',
          //               value: ComputerComponents.graphicCard)
          //         ],
          //         groupValue: singleComputerComponent,
          //         onChange: onChangeComputerComponent),
          //     CheckGroup(list: [
          //       CheckSelectable(
          //           identifier: 'assembly', text: 'Assembly', value: assembly)
          //     ], onChange: onChangeCheckbox),
          //   ],
          //   wrap: wrap,
          // ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildOptions() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Axis'),
          Row(children: [
            Radio<Axis>(
                value: Axis.horizontal,
                groupValue: direction,
                onChanged: (onChangeAxis)),
            const Text('Horizontal'),
            Radio<Axis>(
                value: Axis.vertical,
                groupValue: direction,
                onChanged: onChangeAxis),
            const Text('Vertical')
          ]),
          const Text('Wrap (No wrap is flex)'),
          Row(children: [
            Checkbox(
              value: wrap,
              onChanged: onChangeWrap,
            ),
            const Text('Wrap')
          ]),
          const Text('Alignment'),
          UndefinedSelectableGroup(
            selectedGroupTheme: SelectedGroupTheme.material,
            direction: Axis.horizontal,
            directionMaxWidgets: 2,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              RadioGroup(list: [
                RadioSelectable<WrapAlignment>(
                    text: 'Start', value: WrapAlignment.start),
                RadioSelectable<WrapAlignment>(
                    text: 'Center', value: WrapAlignment.center),
                RadioSelectable<WrapAlignment>(
                    text: 'End', value: WrapAlignment.end),
                RadioSelectable<WrapAlignment>(
                    text: 'SpaceAround', value: WrapAlignment.spaceAround),
                RadioSelectable<WrapAlignment>(
                    text: 'SpaceBetween', value: WrapAlignment.spaceBetween),
                RadioSelectable<WrapAlignment>(
                    text: 'SpaceEvenly', value: WrapAlignment.spaceEvenly),
              ], groupValue: alignment, onChange: onChangeAlignment),
            ],
            wrap: true,
          ),
          const Text('CrossAlignment'),
          UndefinedSelectableGroup(
            selectedGroupTheme: SelectedGroupTheme.material,
            direction: Axis.horizontal,
            directionMaxWidgets: 2,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              RadioGroup(list: [
                RadioSelectable<WrapCrossAlignment>(
                    text: 'Start', value: WrapCrossAlignment.start),
                RadioSelectable<WrapCrossAlignment>(
                    text: 'Center', value: WrapCrossAlignment.center),
                RadioSelectable<WrapCrossAlignment>(
                    text: 'End', value: WrapCrossAlignment.end),
              ], groupValue: crossAlignment, onChange: onChangeCrossAlignment),
            ],
            wrap: true,
          ),
          const Text('RunAlignment'),
          UndefinedSelectableGroup(
            selectedGroupTheme: SelectedGroupTheme.material,
            direction: Axis.horizontal,
            directionMaxWidgets: 2,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              RadioGroup(list: [
                RadioSelectable<WrapAlignment>(
                    text: 'Start', value: WrapAlignment.start),
                RadioSelectable<WrapAlignment>(
                    text: 'Center', value: WrapAlignment.center),
                RadioSelectable<WrapAlignment>(
                    text: 'End', value: WrapAlignment.end),
                RadioSelectable<WrapAlignment>(
                    text: 'SpaceAround', value: WrapAlignment.spaceAround),
                RadioSelectable<WrapAlignment>(
                    text: 'SpaceBetween', value: WrapAlignment.spaceBetween),
                RadioSelectable<WrapAlignment>(
                    text: 'SpaceEvenly', value: WrapAlignment.spaceEvenly),
              ], groupValue: runAlignment, onChange: onChangeRunAlignment),
            ],
            wrap: true,
          ),
        ],
      ),
    ));
  }

  onChangeAlignment(WrapAlignment? value) {
    if (value == null) return;
    setState(() {
      alignment = value;
    });
  }

  onChangeCrossAlignment(WrapCrossAlignment? value) {
    if (value == null) return;
    setState(() {
      crossAlignment = value;
    });
  }

  onChangeRunAlignment(WrapAlignment? value) {
    if (value == null) return;
    setState(() {
      runAlignment = value;
    });
  }

  onChangeAxis(Axis? value) {
    if (value == null) return;
    setState(() {
      direction = value;
    });
  }

  onChangeWrap(bool? value) {
    if (value == null) return;
    setState(() {
      print('value $value');
      wrap = value;
    });
  }

  onChangeComputerComponent(ComputerComponents? value) {
    if (value != null) {
      setState(() {
        singleComputerComponent = value;
      });
    }
  }

  onChangeCheckbox(identifier, value) {
    setState(() {
      switch (identifier) {
        case 'assembly':
          {
            assembly = !value;
            break;
          }
      }
    });
  }
}
