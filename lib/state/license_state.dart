import 'package:equatable/equatable.dart';

class LicenseState extends Equatable {
  final bool hasLicense;

  const LicenseState(this.hasLicense);

  @override
  List<Object?> get props => [hasLicense];
}
