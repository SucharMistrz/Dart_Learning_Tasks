import 'dart:core';
import 'dart:io';

void main(List<String> arguments) async {
  File inputFile = File('input.txt');
  List<String> fileContent = await inputFile.readAsLines();

  List<int> rulesId = <int>[];
  List<int> updatesId = <int>[];
  //List<int> invalidatedUpdatesId = <int>[];
  int totalValue = 0;

  final RegExp findRulesAndUpdates = RegExp(r'(\d+\|)|(\d+\,)');
  final RegExp findNumbers = RegExp(r'\d+');

  //Parse data defining rules and updates
  for (int i = 0; i < fileContent.length; i++) {
    for (final RegExpMatch basicInfo
        in findRulesAndUpdates.allMatches(fileContent[i])) {
      if (basicInfo.group(1) != null) {
        rulesId.add(i);
        break;
      } else if (basicInfo.group(0) != null) {
        updatesId.add(i);
        break;
      }
    }
  }

  for (int updateId in updatesId) {
    List<int> numbers = <int>[];
    String line = fileContent[updateId];
    //Extract page numbers from the string
    for (final RegExpMatch number in findNumbers.allMatches(line)) {
      numbers.add(int.parse(number.group(0)!));
    }

    while (hasBrokenRule(fileContent, line, rulesId, numbers) != -1) {
      line = reorderLine(fileContent, line, rulesId, numbers,
          hasBrokenRule(fileContent, line, rulesId, numbers));
    }

    if (hasBrokenRule(fileContent, line, rulesId, numbers) == -1) {
      totalValue += getMiddlePageNumber(line);
    }
  }

  print(totalValue);
}

int hasBrokenRule(List<String> fileContent, String line, List<int> rulesId,
    List<int> numbersUpdate) {
  //Detect invalid updates
  final RegExp findNumbers = RegExp(r'\d+');
  for (int ruleId in rulesId) {
    List<int> numbersRule = <int>[];

    //Extract page numbers from the string
    for (final RegExpMatch number
        in findNumbers.allMatches(fileContent[ruleId])) {
      numbersRule.add(int.parse(number.group(0)!));
    }

    if (!line.contains(numbersRule[0].toString()) ||
        !line.contains(numbersRule[1].toString())) {
      continue;
    }

    if (line.indexOf(numbersRule[0].toString()) >
        line.indexOf(numbersRule[1].toString())) {
      return ruleId;
    }
  }
  return -1;
}

String reorderLine(List<String> fileContent, String line, List<int> rulesId,
    List<int> numbers, int brokenRuleId) {
  String brokenRule = fileContent[brokenRuleId];
  List<int> numbersRule = <int>[];

  final RegExp findNumbers = RegExp(r'\d+');

  for (final RegExpMatch number in findNumbers.allMatches(brokenRule)) {
    numbersRule.add(int.parse(number.group(0)!));
  }
  print(brokenRule);
  StringBuffer newLine = StringBuffer();

  for (int i = 0; i < numbers.length; i++) {
    if (i == numbers.indexOf(numbersRule[1])) {
      newLine
        ..write(numbersRule[0])
        ..write(',')
        ..write(numbersRule[1]);
    } else if (i == numbers.indexOf(numbersRule[0])) {
      continue;
    } else {
      newLine.write(numbers[i]); //.toString());
    }

    if (i < numbers.length - 1) {
      newLine.write(',');
    }
  }

  numbers.indexOf(numbersRule[0]);

  print(newLine.toString());
  return newLine.toString();
}

int getMiddlePageNumber(String line) {
  List<int> pageNumbers = <int>[];
  final RegExp findNumbers = RegExp(r'\d+');

  for (final RegExpMatch number in findNumbers.allMatches(line)) {
    pageNumbers.add(int.parse(number.group(0)!));
  }

  return pageNumbers[pageNumbers.length ~/ 2];
}
