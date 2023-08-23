import 'package:equatable/equatable.dart';

class ThemeEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ChangeTheme extends ThemeEvent{
  final bool isDark;
  ChangeTheme({required this.isDark});
}