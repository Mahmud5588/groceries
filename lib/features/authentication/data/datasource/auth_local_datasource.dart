import 'package:flutter/cupertino.dart';
import 'package:groceries/features/authentication/data/model/user_credentials_model.dart';
import 'package:hive/hive.dart';

abstract class AuthLocalDatasource {
  Future<void> saveCredentials(UserCredentialsModel credentials);

  Future<UserCredentialsModel?> getCredentials();

  Future<void> deleteCredentials();

  Future<bool> hasCredentials();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const String _boxName = 'user_credentials';

  Future<Box<UserCredentialsModel>> _openBox() async {
    return await Hive.openBox<UserCredentialsModel>(_boxName);
  }

  @override
  Future<void> deleteCredentials()async {
    final box=await _openBox();
    await box.delete('credentials');
  }

  @override
  Future<UserCredentialsModel?> getCredentials()async {
    final box=await _openBox();
    final credentials=box.get('credentials');
    return credentials;
  }

  @override
  Future<bool> hasCredentials() async{
    final box = await _openBox();
    final bool hasData = box.containsKey('credentials');
    return hasData;
  }

  @override
  Future<void> saveCredentials(UserCredentialsModel credentials)async {
    final box=await _openBox();
    await box.put('credentials', credentials);

  }
}
