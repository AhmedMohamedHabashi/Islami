import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/di/injection_container.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> init() async {
  $initGetIt(sl);
}
