import 'package:cuidapet_mobile/app/models/place_model.dart';

abstract interface class AddressService {
Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern);
}