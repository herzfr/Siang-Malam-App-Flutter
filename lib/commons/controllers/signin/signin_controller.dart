import 'package:get/get.dart';
import 'package:siangmalam/models/signin/signin.dart';
import 'package:siangmalam/services/auth/auth_service.dart';

class SignInController extends GetxController {
  var signIn = SignInModel('', '').obs;
  var count = 0.obs;

  changeUsername(usernameVal) {
    signIn.value.username = usernameVal;
  }

  changePassword(passwordVal) {
    signIn.value.password = passwordVal;
  }

  void change() {
    count++;
  }

  @override
  void onInit() {
    //anti ddos menggunakan debounce
    debounce(count, (_) {
      sendLoginRequest();
    }, time: const Duration(seconds: 2));

    // AuthService.sendApiTest();

    super.onInit(); 
  }

  sendLoginRequest() {
    AuthService.sendLogin(signIn.value.username, signIn.value.password);
  }
  
}
