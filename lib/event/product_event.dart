import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {}

class DefaultLoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class PayLoadProductEvent extends ProductEvent {
  final bool hasLicense;

  PayLoadProductEvent(this.hasLicense);

  @override
  List<Object?> get props => [hasLicense];
}
