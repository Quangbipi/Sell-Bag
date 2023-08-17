import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/search_event.dart';
import 'package:flutter_login/sate/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(input: '')) {
    on<SearchInputChange>(_handeldSearchInputChange);
  }

  FutureOr<void> _handeldSearchInputChange(
      SearchInputChange event, Emitter<SearchState> emit) async {
    emit(state.copyWith(input: event.inputString));
  }
}
