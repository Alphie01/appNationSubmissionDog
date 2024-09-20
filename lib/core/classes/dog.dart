import 'package:cached_network_image/cached_network_image.dart';

class Dog {
  final String dogName;
  final CachedNetworkImageProvider dogImage;
  final List dogSubBreeed;

  Dog({
    required this.dogName,
    required this.dogImage,
    this.dogSubBreeed = const [],
  });
}

abstract class DogEvent {}

class FetchDogs extends DogEvent {}

abstract class DogState {}

class DogInitial extends DogState {}

class DogLoading extends DogState {}

class DogLoaded extends DogState {
  final List<Dog> dogs;

  DogLoaded({required this.dogs});
}

class DogError extends DogState {
  final String message;

  DogError({required this.message});
}
