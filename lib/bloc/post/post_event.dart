part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class CreatePostRequested extends PostEvent {
  final String description;
  final File image;

  const CreatePostRequested({
    required this.description,
    required this.image,
  });

  @override
  List<Object> get props => [description, image];
}

class SelectImageRequested extends PostEvent {
  final File image;
  const SelectImageRequested(this.image);

  @override
  List<Object> get props => [image];
}
