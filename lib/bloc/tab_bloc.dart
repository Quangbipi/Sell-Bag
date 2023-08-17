import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/tab_event.dart';
import 'package:flutter_login/sate/tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial(index: 0)) {
    on<TabChange>(_handledTabChange);
  }

  FutureOr<void> _handledTabChange(TabChange event, Emitter<TabState> emit) {
    emit(TabInitial(index: event.indextInput));
  }
}
