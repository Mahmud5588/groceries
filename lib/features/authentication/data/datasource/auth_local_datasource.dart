import 'package:hive/hive.dart';
import 'package:groceries/features/authentication/data/model/user_credentials_model.dart';
import 'package:logger/logger.dart';

abstract class AuthLocalDatasource {
  Future<void> saveCredentials(UserCredentialsModel credentials);
  Future<UserCredentialsModel?> getCredentials();
  Future<void> deleteCredentials();
  Future<bool> hasCredentials();
  Future<String?> getToken();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const String _credentialsBoxName = 'user_credentials';
  static const String _tokenBoxName = 'auth_token_box';
  final Logger _logger = Logger();

  Future<Box<UserCredentialsModel>> _openCredentialsBox() async {
    if (Hive.isBoxOpen(_credentialsBoxName)) {
      _logger.d('Hive box $_credentialsBoxName already open. Returning existing instance.');
      return Hive.box<UserCredentialsModel>(_credentialsBoxName);
    }
    _logger.d('Opening Hive box: $_credentialsBoxName');
    return await Hive.openBox<UserCredentialsModel>(_credentialsBoxName);
  }

  Future<Box<String>> _openTokenBox() async {
    if (Hive.isBoxOpen(_tokenBoxName)) {
      _logger.d('Hive box $_tokenBoxName already open. Returning existing instance.');
      return Hive.box<String>(_tokenBoxName);
    }
    _logger.d('Opening Hive box: $_tokenBoxName');
    return await Hive.openBox<String>(_tokenBoxName);
  }

  @override
  Future<void> deleteCredentials() async {
    try {
      final credentialsBox = await _openCredentialsBox();
      await credentialsBox.delete('credentials');
      _logger.i('User credentials deleted from Hive.');

      final tokenBox = await _openTokenBox();
      await tokenBox.delete('auth_token'); // Tokenni ham o'chirish
      _logger.i('Auth token deleted from Hive.');
    } catch (e) {
      _logger.e('Error deleting credentials from Hive: $e');
      rethrow;
    }
  }

  @override
  Future<UserCredentialsModel?> getCredentials() async {
    try {
      final box = await _openCredentialsBox();
      final credentials = box.get('credentials');
      if (credentials != null) {
        _logger.i('User credentials retrieved from Hive.');
      } else {
        _logger.i('No user credentials found in Hive.');
      }
      return credentials;
    } catch (e) {
      _logger.e('Error getting credentials from Hive: $e');
      return null;
    }
  }

  @override
  Future<bool> hasCredentials() async {
    try {
      final box = await _openCredentialsBox();
      final bool hasData = box.containsKey('credentials');
      _logger.d('Checking for credentials in Hive: $hasData');
      return hasData;
    } catch (e) {
      _logger.e('Error checking for credentials in Hive: $e');
      return false;
    }
  }

  @override
  Future<void> saveCredentials(UserCredentialsModel credentials) async {
    try {
      final credentialsBox = await _openCredentialsBox();
      await credentialsBox.put('credentials', credentials);
      _logger.i('User credentials saved to Hive.');

      if (credentials.token != null) {
        final tokenBox = await _openTokenBox();
        // Tokenni alohida String Boxga saqlash
        await tokenBox.put('auth_token', credentials.token!);
        _logger.i('Auth token saved to Hive.');
      } else {
        _logger.w('User credentials saved to Hive, but token was null.');
      }
    } catch (e) {
      _logger.e('Error saving credentials to Hive: $e');
      rethrow;
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      final tokenBox = await _openTokenBox();
      final token = tokenBox.get('auth_token');
      if (token != null) {
        _logger.i('Auth token retrieved from Hive.');
      } else {
        _logger.i('No auth token found in Hive.');
      }
      return token;
    } catch (e) {
      _logger.e('Error getting token from Hive: $e');
      return null;
    }
  }
}