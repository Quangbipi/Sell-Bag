import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/event/theme_event.dart';
import 'package:flutter_login/sate/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState>{
  ThemeBloc() : super(ThemeState(isDark: false)){
    on<ChangeTheme>(_handlerChangeThemeEvent);
  }


  FutureOr<void> _handlerChangeThemeEvent(
      ChangeTheme event, Emitter<ThemeState> emit) {

    emit(state.copyWith(isDark: event.isDark));
  }
}