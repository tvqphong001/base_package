extension IterableEx on Iterable?{
  bool get isEmptyOrNull{
    if(this == null) return true;
    if(this!.isEmpty) return true;

    return false;
  }

  bool get isNotEmptyOrNull{
    return !isEmptyOrNull;
  }
}

extension ListEx on List?{
  int get lengthOrZero{
    return this == null ? 0 : this!.length;
  }
}