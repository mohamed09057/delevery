import 'package:deleveryapp/data/reposotory/user_repository.dart';
import 'package:deleveryapp/models/response_model.dart';
import 'package:deleveryapp/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepository userRepository;
  UserController({required this.userRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late UserModel _userModel;

  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    _isLoading = true;
    Response response = await userRepository.getUserInfo();
    //print(response.body);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel =  UserModel.fromJson(response.body);
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false; 
    update();
    return responseModel;
  }
   
}
