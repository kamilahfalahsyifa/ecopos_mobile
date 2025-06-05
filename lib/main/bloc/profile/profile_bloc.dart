import 'package:bloc/bloc.dart';
import 'package:ecopos/models/profile_model.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) {
      final profile = UserProfile(
        name: "John Doe",
        email: "manager@gmai.com",
        role: "Product Manager",
        outletId: "d53158b8-45d3-4cff-aeb5-e6bcb1ff6cf1",
        password: "12345678",
      );
      emit(ProfileLoaded(profile));
    });

    on<UpdateProfile>((event, emit) {
      emit(ProfileLoaded(event.profile));
    });
  }
}
