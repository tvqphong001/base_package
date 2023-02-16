enum EDate { today, yesterday, previous7days, previous30days, week, previousWeek, month, previousMonth, custom }

extension DateName on EDate {
  String get name {
    switch (this) {
      case EDate.today:
        return 'Hôm nay';
      case EDate.yesterday:
        return 'Hôm qua';
      case EDate.week:
        return 'Tuần này';
      case EDate.previousWeek:
        return 'Tuần trước';
      case EDate.month:
        return 'Tháng này';
      case EDate.previousMonth:
        return 'Tháng trước';
      case EDate.custom:
        return 'Tùy chỉnh';
      case EDate.previous7days:
        return '7 ngày qua';
      case EDate.previous30days:
        return '30 ngày qua';
    }
  }
}

extension DateGetStartDate on EDate {
  static DateTime now = DateTime.now();
  DateTime? get start {
    switch (this) {
      case EDate.today:
        return now;
      case EDate.yesterday:
        return DateTime(now.year, now.month, now.day - 1);
      case EDate.week:
        return now.subtract(Duration(days: now.weekday - 1));
      case EDate.previousWeek:
        DateTime previousWeek = DateTime(now.year, now.month, now.day - 7);
        return previousWeek.subtract(Duration(days: previousWeek.weekday - 1));
      case EDate.month:
        return DateTime(now.year, now.month, 1);
      case EDate.previousMonth:
        return DateTime(now.year, now.month - 1, 1);
      case EDate.custom:
        return null;
      case EDate.previous7days:
        return DateTime(now.year, now.month, now.day - 7);
      case EDate.previous30days:
        return DateTime(now.year, now.month, now.day - 30);
    }
  }
}

extension DateGetEndDate on EDate {
  static DateTime now = DateTime.now();
  DateTime? get end {
    switch (this) {
      case EDate.today:
        return now;
      case EDate.yesterday:
        return DateTime(now.year, now.month, now.day - 1);
      case EDate.week:
        return DateTime(now.year, now.month, now.day);
      case EDate.previousWeek:
        DateTime previousWeek = DateTime(now.year, now.month, now.day - 7);
        return previousWeek.add(Duration(days: DateTime.daysPerWeek - previousWeek.weekday));
      case EDate.month:
        return DateTime(now.year, now.month, now.day);
      case EDate.previousMonth:
        return DateTime(now.year, now.month, 0);
      case EDate.custom:
        return null;
      case EDate.previous7days:
        return now;
      case EDate.previous30days:
        return now;
    }
  }
}
