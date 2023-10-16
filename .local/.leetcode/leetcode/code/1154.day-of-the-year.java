// Category: algorithms
// Level: Easy
// Percent: 49.01885%

// Given a string date representing a Gregorian calendar date formatted as
// YYYY-MM-DD, return the day number of the year.
//
//  
// Example 1:
//
// Input: date = "2019-01-09"
// Output: 9
// Explanation: Given date is the 9th day of the year in 2019.
//
//
// Example 2:
//
// Input: date = "2019-02-10"
// Output: 41
//
//
//  
// Constraints:
//
//
// 	date.length == 10
// 	date[4] == date[7] == '-', and all other date[i]'s are digits
// 	date represents a calendar date between Jan 1st, 1900 and Dec 31th,
// 2019.
//

// start_marker
class Solution {
  public int dayOfYear(String date) {
    int days[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int year = Integer.parseInt(date.substring(0, 4));
    int month = Integer.parseInt(date.substring(5, 7));
    int day = Integer.parseInt(date.substring(8));

    if (month > 2 && year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) {
      day++;
    }

    while (--month > 0) {
      day += days[month - 1];
    }
    return day;
  }
}
// end_marker
