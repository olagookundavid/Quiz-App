import 'package:flutter/material.dart';
import 'package:quiz_app/quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();
void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Quiz App',
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: Container(
            color: Colors.black26,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: const QuizPage()),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> icons = [];
  void checkanswer(bool pickedanswer) {
    setState(
      () {
        if (quizbrain.isfinished() == true) {
          Alert(
                  context: context,
                  title: 'Finished!',
                  desc: 'you have reached the end of this quiz')
              .show();
          quizbrain.reset();
          icons.clear();
        } else {
          if (pickedanswer == quizbrain.getanswer()) {
            icons.add(
              const Icon(Icons.check, color: Colors.green),
            );
          } else {
            icons.add(
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
            );
          }
        }

        quizbrain.nextquestion();
      },
    );
  }

  Expanded widgetbuilder(bool truth, Color color, String text) {
    return Expanded(
        child: TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () {
        checkanswer(truth);
      },
      child: Expanded(
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 7,
          child: Center(
            child: Text(
              quizbrain.getquestion(),
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        widgetbuilder(true, Colors.blue, 'True'),
        const SizedBox(
          height: 20,
        ),
        widgetbuilder(false, Colors.red, 'False'),
        SizedBox(
          child: Row(children: icons),
          height: 40,
        )
      ],
    );
  }
}
