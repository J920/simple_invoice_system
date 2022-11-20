import 'dart:io';

class LocalUser{
  String? name;
  String? vatNumber;
  String? address;
  String? email;
  String? password;
  File? logo;
  String? logoExtension;
  String? logoUrl;

  LocalUser({this.name, this.vatNumber, this.address,
    this.email, this.password, this.logo});
}