import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_project/domain/core/di/injection.config.dart';

final getit = GetIt.instance;

@InjectableInit()
Future<void> initGetIt() async {
  await $initGetIt(getit, environment: Environment.prod);
}
