import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_2/models/profile_model.dart';
import 'package:test_2/models/user_model.dart';

class UserRepository {
  static String mainUrl = "http://localhost:8000";
  var loginUrl = '$mainUrl/api/login';
  var registerUrl = '$mainUrl/api/register';
  var userProfileUrl = '$mainUrl/api/user';

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String ?token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
    await storage.deleteAll();
  }

  Future<Either<String, User>> login(String email, String password) async {
    try {
      final response = await _dio.post(loginUrl, data: {
        "email": email,
        "password": password,
      });
      
      // Verificamos si la respuesta es exitosa
      if (response.statusCode == 200) {

        if(response.data["success"] == false && response.data["message"] == 'Unauthorized') {
          return const Left('Login error');
        } else {
          print(response.data["data"]);
          var userData = User.fromJson(response.data["data"]);
          return Right(userData); // Retornamos el JSON como un mapa
        }
      } else {
        return Left('Error: ${response.statusCode} - ${response.statusMessage}');
      }

    } on DioException catch (dioError) {
      // Manejo específico de errores de Dio
      if (dioError.type == DioExceptionType.connectionTimeout) {
        return const Left('Connection timeout');
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        return const Left('Receive timeout');
      } else if (dioError.type == DioExceptionType.unknown) {
        // Error relacionado con red, DNS, etc.
        return Left('Network error: ${dioError.message}');
      } else {
        return Left('Unexpected error: ${dioError.message}');
      }
    } catch (e) {
      // Manejo de cualquier otra excepción
      return Left('Unexpected exception: ${e.toString()}');
    }
  }

  Future<Either<String, String>> register(
    String username,
    String email,
    String password,
    String confimPassword
  ) async {
    try {
      final response = await _dio.post(registerUrl, data: {
        "username": username,
        "email": email,
        "password": password,
        "confirm_password": confimPassword,
      });

      // Verificamos si la respuesta es exitosa
      if (response.statusCode == 200) {
        print(response.data);
        return const Right('Register succefull'); // Retornamos el JSON como un mapa
      } else {
        return Left('Error: ${response.statusCode} - ${response.statusMessage}');
      } 

    } on DioException catch (dioError) {
      // Manejo específico de errores de Dio
      if (dioError.type == DioExceptionType.connectionTimeout) {
        return const Left('Connection timeout');
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        return const Left('Receive timeout');
      } else if (dioError.type == DioExceptionType.unknown) {
        // Error relacionado con red, DNS, etc.
        return Left('Network error: ${dioError.message}');
      } else {
        return Left('Unexpected error: ${dioError.message}');
      }
    } catch (e) {
      // Manejo de cualquier otra excepción
      return Left('Unexpected exception: ${e.toString()}');
    }
  }

  Future<Either<String, Profile>> userProfile() async {
    var value = await storage.read(key: 'token');

    try {
      final response = await _dio.get(userProfileUrl, options: Options(
        headers: {
          'Authorization': 'Bearer $value',
        },
      ));

      // Verificamos si la respuesta es exitosa
      if (response.statusCode == 200) {
        print(response.data);
        
        if(response.data["success"] == false && response.data["message"] == 'Unauthorized') {
          return const Left('Login error');
        } else {
          print(response.data);
          var profileData = Profile.fromJson(response.data);
          print(profileData);
          return Right(profileData); // Retornamos el JSON como un mapa
        }
      } else {
        return Left('Error: ${response.statusCode} - ${response.statusMessage}');
      } 

    } on DioException catch (dioError) {
      // Manejo específico de errores de Dio
      if (dioError.type == DioExceptionType.connectionTimeout) {
        return const Left('Connection timeout');
      } else if (dioError.type == DioExceptionType.receiveTimeout) {
        return const Left('Receive timeout');
      } else if (dioError.type == DioExceptionType.unknown) {
        // Error relacionado con red, DNS, etc.
        return Left('Network error: ${dioError.message}');
      } else {
        return Left('Unexpected error: ${dioError.message}');
      }
    } catch (e) {
      // Manejo de cualquier otra excepción
      return Left('Unexpected exception: ${e.toString()}');
    }
  }
}