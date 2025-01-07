import 'dart:io';

void main(List<String> arguments) async {
  File inputFile = File('input_advent_of_code_day2.txt');
  List<String> fileContent = await inputFile.readAsLines();

  int numOfSafeReports = 0;
  for (String line in fileContent) {
    List<int> splitLines = line.split(' ').map(int.parse).toList();

    bool isIncreasing = false;
    bool isDecreasing = false;
    bool maxAllowedDifferenceExceeded = false;

    for (int i = 1; i < splitLines.length; i++) {
      if (splitLines[i] > splitLines[i - 1]) {
        isIncreasing = true;
      } else if (splitLines[i] < splitLines[i - 1]) {
        isDecreasing = true;
      }

      if ((splitLines[i] - splitLines[i - 1]).abs() > 3) {
        maxAllowedDifferenceExceeded = true;
      }
      if ((splitLines[i] - splitLines[i - 1]).abs() < 1) {
        maxAllowedDifferenceExceeded = true;
      }
    }

    if (isDecreasing == isIncreasing) {
      //Only one should ever be true at once
      continue;
    }
    if (maxAllowedDifferenceExceeded == true) {
      continue;
    }
    numOfSafeReports++;
    //print(levels);
  }
  print(numOfSafeReports);
}
