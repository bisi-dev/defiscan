import 'package:defiscan/features/explorer/repository/explorer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var repositoryProviders = [
  RepositoryProvider<ExplorerRepository>(
    create: (context) => ExplorerRepositoryImpl(),
  ),
];
