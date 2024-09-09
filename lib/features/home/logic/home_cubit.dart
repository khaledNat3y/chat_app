import 'package:bloc/bloc.dart';
import 'package:chat_app/features/home/data/models/group_chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';
@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<GroupChatModel> groups = [];
  void createGroupChat(GroupChatModel groupChatModel) {
    groups.add(groupChatModel);
    emit(HomeGroupLoading(groups));
  }
}
