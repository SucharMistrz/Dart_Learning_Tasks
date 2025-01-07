import 'dart:io';

void main(List<String> arguments) async {

  File file = File('input.txt');
  List<String> fileContent = await file.readAsLines();
  List<int> leftList = <int>[];
  List<int> rightList = <int>[];

  for (String line in fileContent)
    {
      List<String> splitString = line.split('   ');
      leftList.add(int.parse(splitString[0]));
      rightList.add(int.parse(splitString[1]));
    }

  int rightListSummary = 0;
  int leftListSummary = 0;
  int answer = 0;

  for (int element in rightList)
    {
      rightListSummary += element;
    }
  for (int element in leftList)
    {
      leftListSummary += element;
    }
  print('\n$rightListSummary');
  print('\n$leftListSummary\n');
  print(answer = (rightListSummary - leftListSummary).abs());
}