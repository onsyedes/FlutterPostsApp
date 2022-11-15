import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts/core/network/network_info.dart';
import 'package:posts/features/posts/data/data_sources/local_data_source.dart';
import 'package:posts/features/posts/data/data_sources/remote_data_source.dart';
import 'package:posts/features/posts/domain/useCases/get_all_posts.dart';
import 'package:posts/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/posts/data/repositories/post_repository_impl.dart';
import 'features/posts/domain/repositories/postsRepository.dart';
import 'features/posts/domain/useCases/add_post.dart';
import 'features/posts/domain/useCases/delete_post.dart';
import 'features/posts/domain/useCases/update_post.dart';
import 'features/posts/presentation/bloc/add_delete_update_post/add_delete_update_posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() =>
      AddDeleteUpdatePostsBloc(
          addPostUseCase: sl(),
          updatePostUseCase: sl(),
          deletePostUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() =>
      PostRepositoryImpl(
          localDataSource: sl(), remoteDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<PostsRemoteDataSource>(
          () => PostsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostsLocalDataSource>(
          () => PostsLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImp(internetConnectionChecker: sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}