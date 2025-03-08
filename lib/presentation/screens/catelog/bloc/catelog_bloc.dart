import 'dart:convert';
import 'package:apparel_360/data/model/catelog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'catelog_event.dart';

part 'catelog_state.dart';

class CatelogBloc extends Bloc<CatelogEvent, CatelogState> {
  CatelogBloc() : super(CatelogInitial()) {
    on<LoadedCatelogData>((event, emit) async {
      String catelogData =
          await rootBundle.loadString('assets/raw/catelog.json');
      final jsonResult = jsonDecode(catelogData) as Map<String, dynamic>;
      List<MensClothe> mensClothes =
      (jsonResult['mens_clothes'] as List<dynamic>).map((e) => MensClothe.fromJson(e)).toList();
      emit(CatelogLoadedState(mensClothes));
    });
  }
}
