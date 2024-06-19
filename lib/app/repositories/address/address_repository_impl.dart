import 'package:google_place/google_place.dart';

import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/helpers/environments.dart';
import 'package:cuidapet_mobile/app/models/address_model.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';

import './address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  SqliteConnectionFactory _sqliteConnectionFactory;

  AddressRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(
      String addressPattern) async {
    final googleApiKey = Environments.param('google_api_key');
    if (googleApiKey == null) {
      throw Failure(message: 'Google API key not found');
    }
    final googlePlace = GooglePlace(googleApiKey);
    final addressResult =
        await googlePlace.search.getTextSearch(addressPattern);
    final candidates = addressResult?.results;
    if (candidates != null) {
      return candidates.map<PlaceModel>((searchResult) {
        final location = searchResult.geometry?.location;
        final address = searchResult.formattedAddress;

        return PlaceModel(
            address: address ?? '',
            lat: location?.lat ?? 0,
            lng: location?.lng ?? 0);
      }).toList();
    }

    return [];
  }

  @override
  Future<void> deleteAll() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.delete('address');
  }

  @override
  Future<List<AddressModel>> getAddress() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final result = await conn.rawQuery('select * from address');
    return result.map<AddressModel>((e) => AddressModel.fromMap(e)).toList();
  }

  @override
  Future<int> saveAddress(AddressModel address) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    return await conn.rawInsert('insert into address values(?,?,?,?,?)', [
      null,
      address.address,
      address.lat,
      address.lng,
      address.additional,
    ]);
  }
}
