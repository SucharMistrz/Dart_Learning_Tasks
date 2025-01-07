import 'dart:io';

void main(List<String> arguments) async {

  File inputFile = File('input_advent_of_code_day1.txt');
  List<String> fileContent = await inputFile.readAsLines();
  List<int> leftList = <int>[];
  List<int> rightList = <int>[];

  for (String line in fileContent)
    {
      List<String> splitString = line.split('   ');
      leftList.add(int.parse(splitString[0]));
      rightList.add(int.parse(splitString[1]));
    }

  if (leftList.length != rightList.length)
    {
      //This should never happen, input must be incorrect
      throw Error();
    }

  leftList.sort();
  rightList.sort();

  int totalDistance = 0;
  for (int i = 0; i < leftList.length ; i++)
    {
      totalDistance += (leftList[i] - rightList[i]).abs();
    }
  print(totalDistance);
}