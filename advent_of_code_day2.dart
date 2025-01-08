import 'dart:io';

bool isReportSafe(List<int> levels, {required bool calledAfterDampening})  {

  bool isIncreasing = false;
  bool isDecreasing = false;
  bool maxAllowedDifferenceExceeded = false;

  for (int i = 1; i < levels.length; i++) {
    if (levels[i] > levels[i - 1]) {
      isIncreasing = true;
    } else if (levels[i] < levels[i - 1]) {
      isDecreasing = true;
    }

    if ((levels[i] - levels[i - 1]).abs() > 3) {
      maxAllowedDifferenceExceeded = true;
    }
    if ((levels[i] - levels[i - 1]).abs() < 1) {
      maxAllowedDifferenceExceeded = true;
    }

    if (isDecreasing == isIncreasing || maxAllowedDifferenceExceeded == true) {
      if (calledAfterDampening == true)
        {
          return false;
        }
      else
        {
          if (isReportSafeAfterDampening(levels) == false)
            {
              return false;
            }
        }
    }
  }
  return true;
}

bool isReportSafeAfterDampening(List<int> originalLevels)
{
  for (int i = 0; i < originalLevels.length; i++) {
    List<int> dampenedLevels = <int>[...originalLevels]
      ..removeAt(i);

    if (isReportSafe(dampenedLevels, calledAfterDampening: true) == true) {
      return true;
    }
  }
  return false;
}

void main(List<String> arguments) async {
  File inputFile = File('input_advent_of_code_day2.txt');
  List<String> fileContent = await inputFile.readAsLines();

  int numOfSafeReports = 0;
  for (String line in fileContent) {
    List<int> splitLines = line.split(' ').map(int.parse).toList();

    if (isReportSafe(splitLines, calledAfterDampening: false) == true){
      numOfSafeReports++;
    }
  }
  print(numOfSafeReports);
}
