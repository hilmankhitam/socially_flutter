import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/domain/usecase/firestore_user/search_user_use_case.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUserUseCase searchUserUseCase;

  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    Stream<Transition<SearchEvent, SearchState>> Function(
      SearchEvent event,
    )
        transitionFn,
  ) {
    return events
        .debounceTime(const Duration(milliseconds: 300))
        .switchMap(transitionFn);
  }

  SearchBloc({
    required this.searchUserUseCase,
  }) : super(SearchEmptyState()) {
    on<SearchEventInitial>((event, emit) => emit(SearchEmptyState()));
    on<SearchQueryEvent>((event, emit) async {
      final String query = event.text;
      if (query.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchLoadingState());
        try {
          final result = await searchUserUseCase.execute(query);
          await result.fold((failure) async {
            emit(SearchErrorState(failure.message));
          }, (users) async {
            emit(SearchSuccessState(users));
          });
        } catch (error) {
          emit(SearchErrorState(error.toString()));
        }
      }
    });
  }
}
