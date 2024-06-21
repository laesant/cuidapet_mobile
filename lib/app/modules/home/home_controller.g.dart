// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$_addressModelAtom =
      Atom(name: 'HomeControllerBase._addressModel', context: context);

  AddressModel? get addressModel {
    _$_addressModelAtom.reportRead();
    return super._addressModel;
  }

  @override
  AddressModel? get _addressModel => addressModel;

  @override
  set _addressModel(AddressModel? value) {
    _$_addressModelAtom.reportWrite(value, super._addressModel, () {
      super._addressModel = value;
    });
  }

  late final _$_getAddressSelectedAsyncAction =
      AsyncAction('HomeControllerBase._getAddressSelected', context: context);

  @override
  Future<void> _getAddressSelected() {
    return _$_getAddressSelectedAsyncAction
        .run(() => super._getAddressSelected());
  }

  late final _$goToAddressPageAsyncAction =
      AsyncAction('HomeControllerBase.goToAddressPage', context: context);

  @override
  Future<void> goToAddressPage() {
    return _$goToAddressPageAsyncAction.run(() => super.goToAddressPage());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
