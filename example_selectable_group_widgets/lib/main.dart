import 'package:flutter/material.dart';
import 'package:selectable_group_widgets/selectable_group_widgets.dart';
import 'package:selectable_group_widgets/selected_group_themes/material_inkwell_group.dart';

import 'selectable_group_themes.dart';

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
        useMaterial3: true,
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Selectable group'),
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

const betweenGroups = 12.0;
const betweenTitleGroup = 8.0;

class _MyHomePageState extends State<MyHomePage> {
  ComputerComponents singleComputerComponent = ComputerComponents.processor;
  bool assembly = false;
  Axis direction = Axis.horizontal;
  WrapAlignment alignment = WrapAlignment.start;
  WrapCrossAlignment crossAlignment = WrapCrossAlignment.center;
  WrapAlignment runAlignment = WrapAlignment.start;
  int maxNumberOfWidgets = 6;
  bool constrainHeight = false;
  double maximumHeight = 300.0;
  bool constrainWidth = false;
  double maximumWidth = 300.0;

  bool wrap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          buildOptions(),
          buildGroup(
              context: context,
              backgroundColor: Colors.white,
              title: 'Material',
              groupTheme: SelectedGroupTheme.material),
          buildGroup(
              context: context,
              title: ' Inkwell',
              groupTheme: SelectedGroupTheme.materialInkWell),
          buildGroup(
              context: context,
              backgroundColor: Colors.white,
              title: 'Button',
              groupTheme: SelectedGroupTheme.button),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  buildOptions() {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child: Text('Options', style: TextStyle(fontSize: 16.0))),
          const Divider(
            thickness: 1.0,
          ),
          const Text('Axis'),
          UndefinedSelectableGroup(
            direction: Axis.horizontal,
            directionMaxWidgets: 2,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              MyRadioGroup(
                  groupTheme: SelectedGroupTheme.materialInkWell,
                  list: [
                    RadioSelectable<Axis>(
                        text: 'Horizontal', value: Axis.horizontal),
                    RadioSelectable<Axis>(
                        text: 'Vertical', value: Axis.vertical),
                  ],
                  groupValue: direction,
                  onChange: onChangeAxis)
            ],
            wrap: true,
          ),
          const Text('Wrap (No wrap is flex)'),
          MaterialInkWellSelectableCheckBox(
            text: "Wrap",
            value: wrap,
            onChange: onChangeWrap,
          ),
          const Text('Alignment'),
          UndefinedSelectableGroup(
            direction: Axis.horizontal,
            directionMaxWidgets: 2,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              MyRadioGroup(
                  groupTheme: SelectedGroupTheme.materialInkWell,
                  list: [
                    RadioSelectable<WrapAlignment>(
                        text: 'Start', value: WrapAlignment.start),
                    RadioSelectable<WrapAlignment>(
                        text: 'Center', value: WrapAlignment.center),
                    RadioSelectable<WrapAlignment>(
                        text: 'End', value: WrapAlignment.end),
                    RadioSelectable<WrapAlignment>(
                        text: 'SpaceAround', value: WrapAlignment.spaceAround),
                    RadioSelectable<WrapAlignment>(
                        text: 'SpaceBetween',
                        value: WrapAlignment.spaceBetween),
                    RadioSelectable<WrapAlignment>(
                        text: 'SpaceEvenly', value: WrapAlignment.spaceEvenly),
                  ],
                  groupValue: alignment,
                  onChange: onChangeAlignment),
            ],
            wrap: true,
          ),
          const Text('CrossAlignment'),
          UndefinedSelectableGroup(
            direction: Axis.horizontal,
            directionMaxWidgets: 3,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              MyRadioGroup(
                  groupTheme: SelectedGroupTheme.materialInkWell,
                  list: [
                    RadioSelectable<WrapCrossAlignment>(
                        text: 'Start', value: WrapCrossAlignment.start),
                    RadioSelectable<WrapCrossAlignment>(
                        text: 'Center', value: WrapCrossAlignment.center),
                    RadioSelectable<WrapCrossAlignment>(
                        text: 'End', value: WrapCrossAlignment.end),
                  ],
                  groupValue: crossAlignment,
                  onChange: onChangeCrossAlignment),
            ],
            wrap: true,
          ),
          const Text('RunAlignment'),
          UndefinedSelectableGroup(
            direction: Axis.horizontal,
            directionMaxWidgets: 3,
            alignment: WrapAlignment.start,
            crossAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            groups: [
              MyRadioGroup(
                  groupTheme: SelectedGroupTheme.materialInkWell,
                  enabled: wrap,
                  list: [
                    RadioSelectable<WrapAlignment>(
                        text: 'Start', value: WrapAlignment.start),
                    RadioSelectable<WrapAlignment>(
                        text: 'Center', value: WrapAlignment.center),
                    RadioSelectable<WrapAlignment>(
                        text: 'End', value: WrapAlignment.end),
                    RadioSelectable<WrapAlignment>(
                        text: 'SpaceAround', value: WrapAlignment.spaceAround),
                    RadioSelectable<WrapAlignment>(
                        text: 'SpaceBetween',
                        value: WrapAlignment.spaceBetween),
                    RadioSelectable<WrapAlignment>(
                        text: 'SpaceEvenly', value: WrapAlignment.spaceEvenly),
                  ],
                  groupValue: runAlignment,
                  onChange: onChangeRunAlignment),
            ],
            wrap: true,
          ),
          const Text('Maximum Widgets in direction'),
          Slider(
            onChanged: onChangeMaxNumberOfWidgets,
            min: 2,
            max: 6,
            divisions: 6 - 2,
            value: maxNumberOfWidgets.toDouble(),
          ),
          const Text('Constrain'),
          MaterialInkWellSelectableCheckBox(
              onChange: onChangeConstrainHeight,
              text: 'Height',
              value: constrainHeight),
          Slider(
            onChanged: constrainHeight ? onChangeMaxHeight : null,
            min: 50.0,
            max: 600.0,
            divisions: 550,
            value: maximumHeight,
          ),
          const Text('Width'),
          MaterialInkWellSelectableCheckBox(
              onChange: onChangeConstrainWidth,
              text: 'Constrain width',
              value: constrainWidth),
          Slider(
            onChanged: constrainWidth ? onChangeMaxWidth : null,
            min: 50.0,
            max: 600.0,
            divisions: 550,
            value: maximumWidth,
          )
        ],
      ),
    ));
  }

  Widget buildGroup(
      {required BuildContext context,
      required String title,
      Color? backgroundColor,
      required SelectedGroupTheme groupTheme}) {
    Widget group = UndefinedSelectableGroup<SelectableGroupOptions>(
      options: SelectableGroupOptions('options test $title'),
      alignment: alignment,
      crossAlignment: crossAlignment,
      runAlignment: runAlignment,
      direction: direction,
      directionMaxWidgets: maxNumberOfWidgets,
      groups: [
        MyRadioGroup(
            groupTheme: groupTheme,
            list: [
              RadioSelectable<ComputerComponents>(
                  text: 'Processor', value: ComputerComponents.processor),
              RadioSelectable<ComputerComponents>(
                  text: 'Memory', value: ComputerComponents.memory),
              RadioSelectable<ComputerComponents>(
                  text: 'Ssd', value: ComputerComponents.ssd),
              RadioSelectable<ComputerComponents>(
                  text: 'Mainboard', value: ComputerComponents.mainboard),
              RadioSelectable<ComputerComponents>(
                  text: 'Graphic Card', value: ComputerComponents.graphicCard)
            ],
            groupValue: singleComputerComponent,
            onChange: onChangeComputerComponent),
        MyCheckGroup(
            groupTheme: groupTheme,
            list: [
              CheckSelectable(
                  identifier: 'assembly', text: 'Assembly', value: assembly)
            ],
            onChange: onChangeCheckbox)
      ],
      wrap: wrap,
    );

    group = Material(
        color: const Color.fromARGB(255, 254, 249, 237),
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(12.0),
        child: group);

    if (constrainWidth || constrainHeight) {
      group = Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
            width: constrainWidth ? maximumWidth : null,
            height: constrainHeight ? maximumHeight : null,
            child: group),
      );
    }
    return Card(
      color: const Color.fromARGB(255, 154, 206, 34),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(title,
                    style:
                        const TextStyle(fontSize: 24.0, color: Colors.white))),
            const Divider(
              thickness: 1.0,
            ),
            group
          ],
        ),
      ),
    );
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

  onChangeMaxNumberOfWidgets(double? value) {
    if (value == null) return;

    setState(() {
      maxNumberOfWidgets = value.toInt();
    });
  }

  onChangeConstrainHeight(bool? value) {
    if (value == null) return;

    setState(() {
      constrainHeight = value;
    });
  }

  onChangeMaxHeight(double? value) {
    if (value == null) return;

    setState(() {
      maximumHeight = value;
    });
  }

  onChangeConstrainWidth(bool? value) {
    if (value == null) return;

    setState(() {
      constrainWidth = value;
    });
  }

  onChangeMaxWidth(double? value) {
    if (value == null) return;

    setState(() {
      maximumWidth = value;
    });
  }
}
