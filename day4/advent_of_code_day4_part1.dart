import 'dart:core';
import 'dart:io';

bool isPalindrome(String word) {
  for (int i = 0; i < word.length ~/ 2; i++) {
    if (word[i] != word[word.length - i - 1]) {
      return false;
    }
  }
  return true;
}

int findKeyword(List<String> fileContent, String keyword, int column, int row,
    {required bool goUp,
    required bool goDown,
    required bool goLeft,
    required bool goRight}) {
  int numberOfWordsAtThisLocation = 0;

  if (goUp == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row - i][column] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goDown == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row + i][column] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goRight == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row][column + i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goLeft == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row][column - i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goUp == true && goLeft == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row - i][column - i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goUp == true && goRight == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row - i][column + i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goDown == true && goLeft == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row + i][column - i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }
  if (goDown == true && goRight == true) {
    for (int i = 0; i < keyword.length; i++) {
      if (fileContent[row + i][column + i] != keyword[i]) {
        break;
      }
      if (i == keyword.length - 1) {
        numberOfWordsAtThisLocation++;
      }
    }
  }

  return numberOfWordsAtThisLocation;
}

void main(List<String> arguments) async {
  File inputFile = File('input.txt');
  List<String> fileContent = await inputFile.readAsLines();

  int numberOfFoundWords = 0;
  String keyword = 'XMAS';

  for (int row = 0; row < fileContent.length; row++) {
    for (int column = 0; column < fileContent[row].length; column++) {
      if (fileContent[row][column] != keyword[0]) {
        continue;
      }
      bool goUp = false;
      bool goDown = false;
      bool goLeft = false;
      bool goRight = false;

      if (row >= keyword.length - 1) {
        goUp = true;
      }
      if (row <= fileContent.length - keyword.length) {
        goDown = true;
      }
      if (column >= keyword.length - 1) {
        goLeft = true;
      }
      if (column <= fileContent[row].length - keyword.length) {
        goRight = true;
      }

      numberOfFoundWords += findKeyword(fileContent, keyword, column, row,
          goUp: goUp, goDown: goDown, goLeft: goLeft, goRight: goRight);
    }
  }

  if (!isPalindrome(keyword)) {
    print(numberOfFoundWords);
  } else {
    print(numberOfFoundWords / 2);
  }
}
