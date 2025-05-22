import 'package:apparel_360/core/network/network_utils.dart';
import 'package:apparel_360/core/network/repository.dart';
import 'package:apparel_360/core/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final networkRepo = getIt<NetworkRepository>();

  LoginBloc(super.initialState) {
    on<GetOtpEvent>((event, emit) async {
      emit(GetOtpLoadingState());
      bool isInternetAvailable = await ConnectionUtil().checkInternetStatus();
      if (isInternetAvailable) {
        final data = await networkRepo.login(event.mobileNumber);
        if (data["type"] == "success") {
          var otp = data['data']['otp'];
          emit(GetOtpSuccessState(otp: otp));
        } else {
          emit(GetOtpFailState(errorMessage: 'Something went wrong!'));
        }
      } else {
        emit(GetOtpFailState(
            errorMessage: 'Please check your internet connection!'));
      }
    });
  }
}
