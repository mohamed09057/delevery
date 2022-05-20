import 'package:deleveryapp/data/reposotory/auth_reposetory.dart';
import 'package:deleveryapp/models/response_model.dart';
import 'package:deleveryapp/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthReposetory authReposetory;
  AuthController({required this.authReposetory});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await authReposetory.registration(signUpBody);
    if (response.statusCode == 200) {
      authReposetory.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    authReposetory.getUserToken();
    _isLoading = true;
    update();
    late ResponseModel responseModel;
    Response response = await authReposetory.login(phone, password);
    if (response.statusCode == 200) {
      authReposetory.saveUserToken(response.body['token']);
      responseModel = ResponseModel(true, response.body['token']);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    authReposetory.saveUserNumberAndPassword(number, password);
  }

  bool userIsLogined() {
    return authReposetory.userIsLogined();
  }
   bool clearSharedData() {
    
    return authReposetory.clearSharedData();
  }
}
