import 'package:flutter/material.dart';

double responsiveScreenRatio(BuildContext context) {
  var size = MediaQuery.of(context).size;

  if (size.width < size.height) return 14 / 15;
  if (size.width > size.height) return 4 / 3;
  return 1 / 1;
}

bool inBounds(int row, int col) {
  if ((row < 0) || (col < 0)) {
    return false;
  }
  if ((row > 14) || (col > 14)) {
    return false;
  }
  if (!((row == 0) || (col == 0))) {
    if (!((row) == 14 || (col == 14))) {
      if (!((row == 7) || (col == 7))) {
        if (!((row == 2) && (col <= 12 && col >= 2))) {
          if (!((row == 4) && (col <= 10 && col >= 4))) {
            if (!((row == 10) && (col <= 10 && col >= 4))) {
              if (!((row == 12) && (col <= 12 && col >= 2))) {
                if (!((col == 12) && (row <= 12 && row >= 2))) {
                  if (!((col == 10) && (row <= 10 && row >= 4))) {
                    if (!((col == 4) && (row <= 10 && row >= 4))) {
                      if (!((col == 2) && (row <= 12 && row >= 2))) {
                        if (!((row >= 0 && row <= 2) &&
                            (col >= 0 && col <= 2) &&
                            (row == col))) {
                          if (!((row >= 12 && row <= 14) &&
                              (col >= 12 && col <= 14) &&
                              (row == col))) {
                            if (!((row == 13) && (col == 1))) {
                              if (!((row == 1) && (col == 13))) {
                                return false;
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return true;
}
