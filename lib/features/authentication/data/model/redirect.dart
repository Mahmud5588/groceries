import 'package:groceries/features/authentication/domain/entities/redirect_entities.dart';

class RedirectModel extends RedirectEntities{
  RedirectModel({required super.redirect_url});
  factory RedirectModel.fromJson(Map<String,dynamic>json){
    return RedirectModel(redirect_url: json['redirect_url']);
  }

}