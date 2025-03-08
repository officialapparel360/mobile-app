part of 'catelog_bloc.dart';

@immutable
abstract class CatelogState {}

class CatelogInitial extends CatelogState {}

class CatelogLoadedState extends CatelogState{
  List<MensClothe> clothes;

  CatelogLoadedState(this.clothes);
}
