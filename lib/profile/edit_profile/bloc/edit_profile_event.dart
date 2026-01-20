part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

class EditProfileOnAppear extends EditProfileEvent {}

class EditProfileOnBackButtonTapped extends EditProfileEvent {}

class EditProfileOnBagButtonTapped extends EditProfileEvent {}

class EditProfileOnTextChanged extends EditProfileEvent {
  final TextFieldKey key;
  final dynamic newValue;

  EditProfileOnTextChanged({required this.key, required this.newValue});

  @override
  List<Object?> get props => [super.props, key, newValue];
}

class EditProfileOnButtonTapped extends EditProfileEvent {
  final Map<String, String> fields;

  EditProfileOnButtonTapped({required this.fields});

  @override
  List<Object?> get props => [super.props, fields];
}
