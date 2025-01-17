import 'dart:core';
import 'dart:io';

void main(List<String> arguments) async {
  File inputFile = File('input.txt');
  List<String> fileContent = await inputFile.readAsLines();

  List<int> rulesId = <int>[];
  List<int> updatesId = <int>[];
  List<int> invalidatedUpdatesId = <int>[];
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

  for (int ruleId in rulesId) {
    List<int> numbers = <int>[];

    //Extract page numbers from the string
    for (final RegExpMatch number
        in findNumbers.allMatches(fileContent[ruleId])) {
      numbers.add(int.parse(number.group(0)!));
    }

    //Detect invalid updates
    for (int updateId in updatesId) {
      if (!fileContent[updateId].contains(numbers[0].toString()) ||
          !fileContent[updateId].contains(numbers[1].toString())) {
        continue;
      }
      if (fileContent[updateId].indexOf(numbers[0].toString()) >
          fileContent[updateId].indexOf(numbers[1].toString())) {
        invalidatedUpdatesId.add(updateId);
      }
    }
  }

  for (int updateId in updatesId) {
    if (invalidatedUpdatesId.contains(updateId)) {
      continue;
    }
    totalValue += getMiddlePageNumber(fileContent[updateId]);
  }

  print(totalValue);
}

int getMiddlePageNumber(String line) {
  List<int> pageNumbers = <int>[];
  final RegExp findNumbers = RegExp(r'\d+');

  for (final RegExpMatch number in findNumbers.allMatches(line)) {
    pageNumbers.add(int.parse(number.group(0)!));
  }

  return pageNumbers[pageNumbers.length ~/ 2];
}
