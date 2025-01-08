import 'dart:core';
import 'dart:io';

void main(List<String> arguments) async {

  File inputFile = File('input_advent_of_code_day3.txt');
  String fileContent = await inputFile.readAsString();

  int totalValue = 0;
  final RegExp findMul = RegExp(r'mul\(\d+,\d+\)');
  final RegExp findNumbers = RegExp(r'\d+');

  for (final RegExpMatch expressionsFound in findMul.allMatches(fileContent))
  {
    String? s = expressionsFound.group(0);
    List<int> numbers = <int>[];

    for (final RegExpMatch numbersFound in findNumbers.allMatches(s!))
    {
      numbers.add(int.parse(numbersFound.group(0)!));
    }
    totalValue += numbers[0] * numbers[1];
  }
  print(totalValue);
}
