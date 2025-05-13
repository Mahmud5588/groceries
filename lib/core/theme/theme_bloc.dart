import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:groceries/core/theme/theme_event.dart';

import 'theme_state.dart';

class ThemeBloc  extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc():super(const ThemeState(ThemeMode.system)){
    on<ToggleThemeEvent>((event,emit){
      final newThemeMode=state.themeMode==ThemeMode.light?ThemeMode.dark:ThemeMode.light;
      emit(ThemeState(newThemeMode));
    });
  }
}