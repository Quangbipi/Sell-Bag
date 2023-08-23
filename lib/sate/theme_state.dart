import 'package:equatable/equatable.dart';

class ThemeState extends Equatable{
  bool isDark;
  ThemeState({required this.isDark});

  ThemeState copyWith({
    bool? isDark,
  }){
    return ThemeState(isDark: isDark ?? this.isDark);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isDark];

}

