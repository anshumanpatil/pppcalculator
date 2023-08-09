import 'package:flutter/material.dart';

class ResultText extends StatelessWidget {
  final String selectedSourceCountry;
  final String selectedTargetCountry;

  final String sourceAmount;
  final String targetAmount;

  final bool isVisible;

  const ResultText({
    Key? key,
    required this.selectedSourceCountry,
    required this.selectedTargetCountry,
    required this.sourceAmount,
    required this.targetAmount,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
              text: ' In ',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: ' $selectedTargetCountry You need to earn ',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: '$sourceAmount \n\n',
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.teal,
                    fontSize: 18,
                  ),
                ),
                const TextSpan(
                  text: ' To maintain lifestyle, same as earning ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: '$targetAmount \n',
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.teal,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: ' in $selectedSourceCountry ',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
