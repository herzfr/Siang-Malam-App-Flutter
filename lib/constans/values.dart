//general
const appTitle = 'Siang Malam';
const tapBackAgainMsg = 'Tekan back sekali lagi untuk keluar';
const errorHappen = 'Terjadi kesalahan';
const errorLabel = 'Error';
const errorGetData = 'Gagal mendapatkan data!';

//server config
// const String serverHost = 'https://api.rmsiangmalam.com/';
const String serverHost = 'https://app.rmsiangmalam.com/';
const String serverSocketHost = 'https://ws.rmsiangmalam.com/';
const String timeApiHost = 'https://www.timeapi.io/';
// const String serverHost = 'http://192.168.1.13/';
const connectTimeOut = 30000; //30 Second
const receiveTimeOut = 30000; //30 Second
const fileSizeLimit = 2000000; //2MB

//Splash Screen values
const int splashScreenDelay = 3;

//http value
const httpOK = 200;

//routes values
const String signInRoutes = '/signin';
const String homeRoutes = '/home';

//custom dialog values
const double padding = 20;
const double avatarRadius = 45;

//SignIn Values
const String signInTitle = 'SignIn';
const String headerTitle = 'Selamat Datang';
const String subHeaderTitle = 'Masuk dengan username dan password anda';
const String userNameInputLabel = 'Username';
const String userNameInputVldMsg = 'Minimal 3 karakter';
const String passwordInputLabel = 'Kata Sandi';
const String passwordInputHint = 'Input kata sandi';
const String passwordInputVldMsg = 'Minimal 3 karakter';
const String loginBtnLabel = 'Masuk';

//confirmation values
const confirmYes = "Ya";
const confirmNo = "Tidak";

//animation default duration
const defaultDuration = Duration(milliseconds: 250);

//image values
const backgroundimage = 'assets/images/bg.png';
const backgroundimagerm = 'assets/images/bg_home.png';
const avatarImage = 'assets/images/userimage.png';
const noPicImage = 'assets/images/no_pic.png';
const noPicImageSquare = 'assets/images/no_pic_square.png';
// 'https://cdn.dribbble.com/users/1577045/screenshots/4914645/media/028d394ffb00cb7a4b2ef9915a384fd9.png?compress=1&resize=400x300&vertical=top';

//icons values
const iconBack = 'assets/icons/back_icon.svg';

//image upload values
const double maxImageWidth = 500;
const double maxImageHeight = 500;
const imageQuality = 50;

//map
const markerImage = 'assets/icons/position_marker.png';

// suplier value
const String min3inputVldMsg = 'Minimal 3 karakter';

//attendance values
const String placeChoiceLabel = 'Pilih lokasi absensi';

// ADMIN, MANAGER, SPV, KASIR, USER
const role = ['ADMIN', 'MANAGER', 'SPV', 'KASIR', 'USER'];
