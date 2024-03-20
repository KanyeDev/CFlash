import 'package:cflash/features/login/data/data%20source/login_data_source.dart';
import 'package:cflash/features/login/data/repository/login_repository_impl.dart';
import 'package:cflash/features/login/domain/repository/login_in_repository.dart';
import 'package:cflash/features/login/domain/usecase/login_user.dart';
import 'package:cflash/features/login/presentation/bloc/login_bloc.dart';
import 'package:cflash/features/sign_up/data/data%20source/sign_up_data_source.dart';
import 'package:cflash/features/sign_up/data/repository/sign_up_repository_impl.dart';
import 'package:cflash/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:cflash/features/sign_up/domain/usecases/register_user.dart';
import 'package:cflash/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:cflash/features/subject/data/data%20source/subject_data_source.dart';
import 'package:cflash/features/subject/data/repository/subject_repository_impl.dart';
import 'package:cflash/features/subject/domain/repository/subject_repository.dart';
import 'package:cflash/features/subject/domain/usecase/add_subject.dart';
import 'package:cflash/features/subject/domain/usecase/viewAllSubject.dart';
import 'package:cflash/features/subject/domain/usecase/viewSubject.dart';
import 'package:cflash/features/subject/presentation/bloc/subject_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async{
  /// Features
  /// - Signup
  // Bloc
  sl.registerFactory(() => SignUpBloc(registerUser: sl()));

  //use cases
  sl.registerLazySingleton(() => RegisterUser(sl()));

  //repository
  sl.registerLazySingleton<SignUpRepository>(() => SignUpRepositoryImpl(signUpDataSource: sl()));

  //Data Sources
  sl.registerLazySingleton<SignUpDataSource>(() => SignupDataSourceImpl());



  /// - Login
  // Bloc
  sl.registerFactory(() => LoginBloc(loginUser: sl()));

  //use cases
  sl.registerLazySingleton(() => LoginUser(sl()));

  //repository
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginDataSource: sl()));

  //Data source
  sl.registerLazySingleton<LoginDataSource>(() => LoginDataSourceImpl());

  /// - Subject



  // Bloc
  sl.registerFactory(() => SubjectBloc(addSubject: sl(), viewSubject: sl(), viewAllSubject: sl()));

  //use cases
  sl.registerLazySingleton(() => AddSubject(sl()));
  sl.registerLazySingleton(() => ViewSubject(sl()));
  sl.registerLazySingleton(() => ViewAllSubject(sl()));

  //repository
  sl.registerLazySingleton<SubjectRepository>(() => SubjectRepositoryImpl(subjectDataSource: sl()));

  //data source
  sl.registerLazySingleton<SubjectDataSource>(() => SubjectDataSourceImpl());


}