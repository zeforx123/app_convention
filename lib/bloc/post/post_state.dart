part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostImageSelected extends PostState {
  final File image;
  const PostImageSelected(this.image);

  @override
  List<Object> get props => [image];
}

class PostLoading extends PostState {}

class PostSuccess extends PostState {}

class PostFailure extends PostState {
  final String message;
  const PostFailure(this.message);

  @override
  List<Object> get props => [message];
}
