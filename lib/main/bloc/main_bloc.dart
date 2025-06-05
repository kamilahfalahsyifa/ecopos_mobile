import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainInitial(0)) {
    on<ChangeTabEvent>((event, emit) {
      emit(MainInitial(event.tabIndex));
    });
  }
}
