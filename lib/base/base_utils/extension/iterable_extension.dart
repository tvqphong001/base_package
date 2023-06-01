extension IterableEx on Iterable?{
  bool get isEmptyOrNull{
    if(this == null) return true;
    if(this!.isEmpty) return true;

    return false;
  }
}