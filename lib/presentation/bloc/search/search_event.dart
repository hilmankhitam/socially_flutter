part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchEventInitial extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchQueryEvent extends SearchEvent {
  final String text;
  const SearchQueryEvent({required this.text});

  @override
  List<Object?> get props => [];
}
