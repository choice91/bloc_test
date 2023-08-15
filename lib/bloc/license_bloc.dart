import 'package:bloc_to_communication/event/license_event.dart';
import 'package:bloc_to_communication/repository/license_repository.dart';
import 'package:bloc_to_communication/state/license_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LicenseBloc extends Bloc<LicenseEvent, LicenseState> {
  final LicenseRepository _licenseRepository;

  // final ProductBloc _productBloc;

  LicenseBloc(
    this._licenseRepository,
    // this._productBloc,
  ) : super(const LicenseState(false)) {
    on<BuyLicenseEvent>((BuyLicenseEvent event, emit) async {
      bool result = await _licenseRepository.buyLicense();
      emit(LicenseState(result));
      // _productBloc.add(PayLoadProductEvent(result));
    });
  }
}
