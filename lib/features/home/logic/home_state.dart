part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeGroupLoading extends HomeState {
  final List<GroupChatModel> groups;
  HomeGroupLoading(this.groups);
}


