import 'dart:core';
import 'dart:io';

void main(List<String> arguments) async {
  File inputFile = File('input.txt');
  List<String> fileContent = await inputFile.readAsLines();

  int totalNumberOfFoundShapes = 0;
  String keyword = 'MAS';

  //Unlike Day 4 Part 1, here we do not allow just any random input
  if (keyword.length != 3) {
    throw Error();
  }

  for (int row = 1; row < fileContent.length - 1; row++) {
    for (int column = 1; column < fileContent[row].length - 1; column++) {
      //Find the middle of the X shape
      if (fileContent[row][column] != keyword[1]) {
        continue;
      }

      int localFoundWords = 0;

      //Once the middle has been found, iterate the X shape in all 4 directions
      if ((row > 0) && (column > 0)) {
        //Up Left
        if (hasFoundKeyword(fileContent, keyword, column + 1, row + 1,
                goUp: true, goDown: false, goLeft: true, goRight: false) ==
            true) {
          localFoundWords += 1;
        }
      }
      if ((row > 0) && (column < fileContent[row].length - 1)) {
        //Up Right
        if (hasFoundKeyword(fileContent, keyword, column - 1, row + 1,
            goUp: true, goDown: false, goLeft: false, goRight: true)) {
          localFoundWords += 1;
        }
      }
      if ((row < fileContent.length - 1) && (column > 0)) {
        //Down Left
        if (hasFoundKeyword(fileContent, keyword, column + 1, row - 1,
            goUp: false, goDown: true, goLeft: true, goRight: false)) {
          localFoundWords += 1;
        }
      }
      if ((row < fileContent.length - 1) &&
          column < fileContent[row].length - 1) {
        //Down Right
        if (hasFoundKeyword(fileContent, keyword, column - 1, row - 1,
            goUp: false, goDown: true, goLeft: false, goRight: true)) {
          localFoundWords += 1;
        }
      }

      //The input word has to be found in at least two directions to confirm they form an X shape
      if (localFoundWords == 2) {
        totalNumberOfFoundShapes++;
      }
    }
  }
  print(totalNumberOfFoundShapes);
}

bool hasFoundKeyword(
    List<String> fileContent, String keyword, int column, int row,
    {required bool goUp,
    required bool goDown,
    required bool goLeft,
    required bool goRight}) {
  if (goUp == true && goLeft == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row - i][column - i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        return true;
      }
    }
  } else if (goUp == true && goRight == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row - i][column + i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        return true;
      }
    }
  } else if (goDown == true && goLeft == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row + i][column - i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        return true;
      }
    }
  } else if (goDown == true && goRight == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row + i][column + i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        return true;
      }
    }
  }

  return false;
}
