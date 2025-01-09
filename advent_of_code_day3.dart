import 'dart:core';
import 'dart:io';

void main(List<String> arguments) async {
  File inputFile = File('input_advent_of_code_day3.txt');
  String fileContent = await inputFile.readAsString();

  bool mulEnabled = true;
  int totalMulValue = 0;

  /*Find one of the following statements:
  Group 1: do()
  Group 2: don't()
  Group 3: mul(<number>,<number>)
   */
  final RegExp findBasicInfo = RegExp(r"(do\(\))|(don't\(\))|(mul\(\d+,\d+\))");

  //Find just the numbers within the Mul statement (Group 3 of the previous RegExp)
  //in order to use them to calculate the final value
  final RegExp findNumbers = RegExp(r'\d+');

  for (final RegExpMatch basicInfo in findBasicInfo.allMatches(fileContent)) {
    if (basicInfo.group(1) != null) {
      mulEnabled = true;
    } else if (basicInfo.group(2) != null) {
      mulEnabled = false;
    } else if (mulEnabled == true && basicInfo.group(3) != null) {
      List<int> mulArgs = <int>[];

      for (final RegExpMatch numbersFound
          in findNumbers.allMatches(basicInfo.group(3)!)) {
        mulArgs.add(int.parse(numbersFound.group(0)!));
      }
      totalMulValue += mulArgs[0] * mulArgs[1];
    }
  }
  print(totalMulValue);
}
