import 'dart:io';

import 'package:app_convention/services/post_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostService postService;

  PostBloc(this.postService) : super(PostInitial()) {
    on<CreatePostRequested>(_onCreatePostRequested);
    on<SelectImageRequested>((event, emit) {
      emit(PostImageSelected(event.image));
    });
  }

  Future<void> _onCreatePostRequested(
    CreatePostRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      await postService.createPost(event.description, event.image);
      emit(PostSuccess());
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  }
}
