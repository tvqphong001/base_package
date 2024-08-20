// extension EnumEx on List<dynamic>{
//   g
// }

extension EnumByNameOrNull<T extends Enum> on Iterable<T> {
  /// Finds the enum value in this list with name [name].
  ///
  /// Goes through this collection looking for an enum with
  /// name [name], as reported by [EnumName.name].
  /// Returns the first value with the given name. Such a value must be found.
  T? byNameOrNull(String? name) {
    if(name == null) return null;
    
    for (var value in this) {
      if (value.name == name) return value;
    }
    return null;
  }
}