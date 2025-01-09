import 'dart:io';

//this function makes sure the provided list meets all the requirements
bool isReportSafe(List<int> levels, {required bool calledAfterDampening}) {
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

    //the first two booleans below cannot be equal for the report to be considered safe
    if (isDecreasing == isIncreasing || maxAllowedDifferenceExceeded == true) {
      //An element has already been removed from that list, we do not want to do it again as only one bad level may be ignored
      if (calledAfterDampening == true) {
        return false;
      } else {
        if (isReportSafeAfterDampening(levels) == false) {
          return false;
        }
      }
    }
  }
  return true;
}

//if a list does not meet the requirements, this function modifies the list by deleting one element
//and then sends the modified list for a reanalysis
bool isReportSafeAfterDampening(List<int> originalLevels) {
  for (int i = 0; i < originalLevels.length; i++) {
    //according to the requirements, one bad level may exist
    //so we check if there is such a version of the list which meets the requirements if any of the elements was deleted
    List<int> dampenedLevels = <int>[...originalLevels]..removeAt(i);

    if (isReportSafe(dampenedLevels, calledAfterDampening: true) == true) {
      return true;
    }
  }
  return false;
}

void main(List<String> arguments) async {
  File inputFile = File('input.txt');
  List<String> fileContent = await inputFile.readAsLines();

  int numOfSafeReports = 0;

  for (String line in fileContent) {
    List<int> splitLines = line.split(' ').map(int.parse).toList();

    if (isReportSafe(splitLines, calledAfterDampening: false) == true) {
      numOfSafeReports++;
    }
  }
  print(numOfSafeReports);
}
