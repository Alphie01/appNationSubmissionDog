import 'package:appnationdoggy/core/classes/dog.dart';
import 'package:appnationdoggy/core/http/http_request.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc() : super(DogInitial()) {
    // Register event handler for FetchDogs
    on<FetchDogs>(_onFetchDogs);
  }

  Future<void> _onFetchDogs(FetchDogs event, Emitter<DogState> emit) async {
    emit(DogLoading());

    try {
      Map<String, dynamic> response = await HTTP_Requests.sendGetRequest(
          url: 'https://dog.ceo/api/breeds/list/all');
      Map<String, dynamic> dogMaps = response['message'];

      List<Dog> dogs = [];
      for (var element in dogMaps.keys) {
        print(dogMaps[element]);
        String dogName = element;
        CachedNetworkImageProvider dogImage = await fetchDogImages(element);
        List dogSubBreeds = dogMaps[element] ?? [];
        dogs.add(Dog(
          dogName: dogName,
          dogImage: dogImage,
          dogSubBreeed: dogSubBreeds,
        ));
      }

      emit(DogLoaded(dogs: dogs)); // Data successfully loaded
    } catch (error) {
      emit(DogError(message: 'Failed to load data. $error'));
    }
  }

  Future<CachedNetworkImageProvider> fetchDogImages(String breed) async {
    Map<String, dynamic> response = await HTTP_Requests.sendGetRequest(
        url: 'https://dog.ceo/api/breed/$breed/images/random');

    return CachedNetworkImageProvider(response['message'], );
  }
}
