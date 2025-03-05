import '../../base_package.dart';

class DataWithNameModel{
  final String name;
  final int id;

  DataWithNameModel({required this.name, required this.id});
}

class DataPageView extends DataWithNameModel{
  final Widget page;

  DataPageView({required super.name, required super.id, required this.page});
}