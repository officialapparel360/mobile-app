part of 'catelog_bloc.dart';

@immutable
abstract class CatelogState {}

class CatelogInitial extends CatelogState {}

class CatelogLoadedState extends CatelogState{
  List<ProductData> data;

  CatelogLoadedState(this.data);
}
