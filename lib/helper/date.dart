extension CompareDateOnly on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension ConvertToDateOnly on DateTime {
  DateTime onlyDate() {
    return DateTime(year, month, day);
  }
}
