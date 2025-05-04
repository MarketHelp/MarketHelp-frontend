// import 'package:dio/dio.dart';
// import 'package:markethelp_frontend/feature/markethelp/data/repository/product_repository_impl.dart';
// import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';
// import 'package:share_plus/share_plus.dart';

// class AppScope extends IAppScope {
//   late final Dio _dio;

//   get dio => _dio;


//   AppScope() {
//     _dio = _initDio();
//   }

//   Dio _initDio() {
//     final dio = Dio();
//     return dio;
//   }

//   ShareParams _shareParams(String path) {
//     return ShareParams(
//               text: "Аналитика из MarketHelp",
//               files: [XFile(path)]
//     );
//   }

//   SharePlus _sharePlus() {
//     return SharePlus.instance;
//   }

//   ProductRepository _productRepository() {
//     return ProductRepositoryImpl();
//   }


// }

// abstract class IAppScope {}
