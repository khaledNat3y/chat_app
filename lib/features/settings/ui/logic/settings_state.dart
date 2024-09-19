part of 'settings_cubit.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {
  final Locale locale;
  SettingInitial(this.locale);
}

final class LanguageChanged extends SettingState {
  final Locale locale;
  LanguageChanged(this.locale);
}