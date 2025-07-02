import 'dart:convert';
import 'package:apparel_360/data/model/catelog.dart';
import 'package:apparel_360/data/model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../core/network/repository.dart';
import '../../../../core/services/service_locator.dart';

part 'catelog_event.dart';

part 'catelog_state.dart';

class CatelogBloc extends Bloc<CatelogEvent, CatelogState> {
  final NetworkRepository _networkRepository = getIt<NetworkRepository>();
  final List<Map<String, String>> productList = [];

  CatelogBloc(super.initialState) {
    on<LoadedCatelogData>((event, emit) async {
      emit(CatelogInitial());
      Future.delayed(Duration(seconds: 10));
      final data = await _networkRepository.getProductList();
      if (data["type"] == "success") {
        List<ProductData> productList = List<ProductData>.from(
            data["data"].map((x) => ProductData.fromJson(x))
        );
        emit(CatelogLoadedState(productList));
      }
    });
  }
}
