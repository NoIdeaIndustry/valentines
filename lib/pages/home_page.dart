import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/answer_type.dart';
import '../utils/sentences.dart';
import '../utils/urls.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final answerNotifier = ValueNotifier<bool>(false);
  final noCounterNotifier = ValueNotifier(0);
  final deltaWidthNotifer = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();

    // Dirty but whatever
    AnswerType.kYes.onPressed = () {
      answerNotifier.value = true;
    };
    AnswerType.kNo.onPressed = () {
      if (noCounterNotifier.value >= Sentences.lines.length - 1) {
        noCounterNotifier.value = 1;
        return;
      }

      noCounterNotifier.value += 1;
    };
  }

  @override
  Widget build(BuildContext context) {
    return _buildAppContent();
  }

  Center _buildAppContent() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ValueListenableBuilder(
            valueListenable: answerNotifier,
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  if (value) ...[
                    ..._buildAcceptedContent()
                  ] else ...[
                    ..._buildAskOutContent()
                  ],
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAskOutContent() {
    return [
      Image.network(height: 200, Urls.kBearAskingOut),
      const SizedBox(height: 10),
      Text(
        'Will you be my Valentine?',
        style: _buildStyle(),
      ),
      const SizedBox(height: 10),
      ValueListenableBuilder(
        valueListenable: noCounterNotifier,
        builder: (context, value, child) {
          final double delta = value * 7.2 + deltaWidthNotifer.value;

          if (value >= 1) {
            AnswerType.kNo.label = Sentences.lines.elementAt(value);

            if (value >= Sentences.lines.length - 1) {
              deltaWidthNotifer.value = delta;
            }
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildChoiceButton(
                AnswerType.kYes,
                50 + delta,
                w: 45 + delta,
              ),
              const SizedBox(height: 10),
              _buildChoiceButton(
                AnswerType.kNo,
                50,
                w: value <= 0 ? 45 : AnswerType.kNo.label.length * 15,
              ),
            ],
          );
        },
      )
    ];
  }

  List<Widget> _buildAcceptedContent() {
    return [
      Image.network(height: 200, Urls.kBearKissing),
      const SizedBox(height: 10),
      Text(
        'Yay!!! See you on the 14th ',
        style: _buildStyle(),
      ),
      const SizedBox(height: 10),
    ];
  }

  ElevatedButton _buildChoiceButton(
    final AnswerType type,
    final double h, {
    final double? w,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: type.color,
      ),
      child: SizedBox(
        width: w,
        height: h,
        child: _buildChoiceButtonContent(type.label),
      ),
      onPressed: () => type.onPressed.call(),
    );
  }

  Center _buildChoiceButtonContent(final String label) {
    return Center(
      child: Text(
        label,
        style: _buildStyle(color: Colors.white),
      ),
    );
  }

  TextStyle _buildStyle({Color color = Colors.black54}) {
    return GoogleFonts.poppins(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    );
  }
}
