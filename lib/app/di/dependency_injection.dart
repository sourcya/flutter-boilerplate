import 'package:boilerplate_ui/core/network/api_client.dart';
import 'package:boilerplate_ui/core/network/network_service.dart';
import 'package:boilerplate_ui/features/posts/data/datasource/posts_remote_datasource.dart';
import 'package:boilerplate_ui/features/posts/data/datasource/posts_remote_datasource_impl.dart';
import 'package:boilerplate_ui/features/posts/data/repository/posts_repository.dart';
import 'package:boilerplate_ui/features/posts/data/repository/posts_repository_impl.dart';
import 'package:boilerplate_ui/features/posts/presentation/cubit/post_details_cubit/post_details_cubit.dart';
import 'package:boilerplate_ui/features/posts/presentation/cubit/posts_cubit/posts_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class DI {
  DI._();

  static void init() {
    // Network
    sl.registerLazySingleton<Dio>(ApiClient.create);
    sl.registerLazySingleton<NetworkService>(
      () => NetworkService(dio: sl<Dio>()),
    );

    // Datasources
    sl.registerLazySingleton<PostsRemoteDatasource>(
      () => PostsRemoteDatasourceImpl(api: sl<NetworkService>()),
    );

    // Repositories
    sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(datasource: sl<PostsRemoteDatasource>()),
    );

    // Cubits
    sl.registerFactory<PostsCubit>(
      () => PostsCubit(repository: sl<PostsRepository>()),
    );
    sl.registerFactory<PostDetailsCubit>(
      () => PostDetailsCubit(repository: sl<PostsRepository>()),
    );
  }
}
