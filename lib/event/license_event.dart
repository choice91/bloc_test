import 'package:equatable/equatable.dart';

abstract class LicenseEvent extends Equatable {}

class BuyLicenseEvent extends LicenseEvent {
  @override
  List<Object?> get props => [];
}
