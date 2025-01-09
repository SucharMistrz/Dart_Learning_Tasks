import 'dart:io';

void main(List<String> arguments) async {
  File inputFile = File('input.txt');
  List<String> fileContent = await inputFile.readAsLines();

  List<int> leftList = <int>[];
  List<int> rightList = <int>[];

  //analyse lines and compile lists correctly based on input
  for (String line in fileContent) {
    List<String> splitString = line.split('   ');
    //each line contains 2 integers, the first one should always be assigned to the left list while the second one should always end up in the right list
    leftList.add(int.parse(splitString[0]));
    rightList.add(int.parse(splitString[1]));
  }

  //This should never happen, input must be incorrect
  if (leftList.length != rightList.length) {
    throw Error();
  }

  leftList.sort();
  rightList.sort();

  int totalDistance = 0;
  for (int i = 0; i < leftList.length; i++) {
    totalDistance += (leftList[i] - rightList[i]).abs();
  }
  print(totalDistance);

  int totalSimilarity = 0;
  for (int i = 0; i < leftList.length; i++) {
    int totalNumberOfRepetitions = 0;
    for (int j = 0; j < leftList.length; j++) {
      if (leftList[i] == rightList[j]) {
        totalNumberOfRepetitions += 1;
      }
    }
    totalSimilarity += leftList[i] * totalNumberOfRepetitions;
  }
  print(totalSimilarity);
}
