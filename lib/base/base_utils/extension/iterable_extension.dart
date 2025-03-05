extension IterableEx on Iterable?{
  bool get isEmptyOrNull{
    if(this == null) return true;
    if(this!.isEmpty) return true;

    return false;
  }

  bool get isNotEmptyOrNull{
    return !isEmptyOrNull;
  }

  /*num get sumList {

    
    return this?.reduce((a, b) {
      
      return a + b;
    })??0;
  }*/
}

extension ListEx on List?{
  int get lengthOrZero{
    return this == null ? 0 : this!.length;
  }

  // num get sumList => this?.reduce((a, b) => a + b)??0;
}

extension ListExt<T> on List<T>{
  void addWithNull(T? item){
    if(item != null) add(item);
  }
}