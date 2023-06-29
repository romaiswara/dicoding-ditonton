import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/domain/domain.dart';

class MovieWatchlistStatusCubit extends Cubit<bool> {
  final GetWatchListStatus getWatchListStatus;

  MovieWatchlistStatusCubit({
    required this.getWatchListStatus,
  }) : super(false);

  void get({required int id}) async {
    final result = await getWatchListStatus.execute(id);
    emit(result);
  }
}
