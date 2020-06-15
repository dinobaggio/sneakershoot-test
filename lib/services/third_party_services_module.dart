import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

// ignore: deprecated_member_use
@registerModule
abstract class ThirdPartyServicesModule {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
}
