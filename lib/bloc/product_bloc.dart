import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_to_communication/event/product_event.dart';
import 'package:bloc_to_communication/repository/license_repository.dart';
import 'package:bloc_to_communication/repository/product_repository.dart';
import 'package:bloc_to_communication/state/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  final LicenseRepository _licenseRepository;

  ProductBloc(this._productRepository, this._licenseRepository)
      : super(InitProductState()) {
    on<ProductEvent>((event, emit) async {
      if (event is DefaultLoadProductEvent) {
        await _defaultLoadProduct(event, emit);
      }
      if (event is PayLoadProductEvent) {
        await _payLoadProduct(event, emit);
      }
    }, transformer: sequential());
    add(DefaultLoadProductEvent());
    add(PayLoadProductEvent(false));
    _licenseRepository.stream.listen((event) {
      if (event) {
        add(PayLoadProductEvent(event));
      }
    });
  }

  _defaultLoadProduct(DefaultLoadProductEvent event, emit) async {
    emit(
      LoadingProductState(
        defaultItems: state.defaultItems,
        payItems: state.payItems,
      ),
    );
    var result = await _productRepository.loadDefaultProduct();
    emit(LoadedProductState(defaultItems: result, payItems: state.payItems));
  }

  _payLoadProduct(PayLoadProductEvent event, emit) async {
    emit(
      LoadingProductState(
        defaultItems: state.defaultItems,
        payItems: state.payItems,
      ),
    );
    var result =
        await _productRepository.loadPayDefaultProduct(event.hasLicense);
    emit(
        LoadedProductState(defaultItems: state.defaultItems, payItems: result));
  }

  @override
  void onChange(Change<ProductState> change) {
    super.onChange(change);
  }

  @override
  void onTransition(Transition<ProductEvent, ProductState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
