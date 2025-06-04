import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/entity/visualization_entity.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/repository/product_repository.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/usecase/analytics_uscase.dart';
import 'package:retrofit/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChartWidget extends StatelessWidget {
  final VisualizationEntity visual;
  final double height;
  final double? width;
  final Widget? placeholder;

  ChartWidget({
    super.key,
    required this.visual,
    this.height = 120,
    this.width,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    AnalyticsUsecase analyticsUsecase = GetIt.I<AnalyticsUsecase>();
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade300, width: 1.5),
      ),
      child: Stack(
        children: [
          FutureBuilder<HttpResponse<List<int>>>(
            future: analyticsUsecase.getimage(visual),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      minWidth:
                          MediaQuery.of(context).size.width *
                          0.85, // Force minimum width
                    ),
                    child:
                        Image.memory(
                          Uint8List.fromList(snapshot.data!.data),
                          fit:
                              BoxFit
                                  .contain, // Changed to contain to avoid distortion
                          alignment: Alignment.center,
                        ) ??
                        _buildPlaceholder(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
    // FutureBuilder<String>(
    //   future: analyticsUsecase.getVisualContent(visual),
    //   builder: (context, snapshot) {
    //     print("In chart builder");
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       print("Waiting for data...");
    //       return const Center(child: CircularProgressIndicator());
    //     }

    //     if (snapshot.hasError) {
    //       print("Error: ${snapshot.error}");
    //       return Center(child: Text('Error: ${snapshot.error}'));
    //     }

    //     if (snapshot.hasData && snapshot.data!.isNotEmpty) {
    //       print("Content: ${snapshot.data}");

    //       String content = snapshot.data!;

    //   final cssOverrides = '''
    //     <style>
    //       html, body {
    //         margin: 0 !important;
    //         padding: 0 !important;
    //         width: ${(width == double.infinity ? 300 : width ?? 300).toInt()}px !important;
    //           height: ${height.toInt()}px !important;
    //           min-height: ${height.toInt()}px !important;
    //           max-height: 100% !important;
    //         overflow: hidden !important;
    //         box-sizing: border-box !important;
    //       }
    //       .chart-container {
    //         width: 100% !important;
    //         height: 100% !important;
    //         max-width: ${(width == double.infinity ? 300 : width ?? 300).toInt()}px !important;
    //         max-height: ${height.toInt()}px !important;
    //         overflow: hidden !important;
    //       }
    //       .metric-bar {
    //         font-size: 12px !important;
    //         padding: 5px 10px !important;
    //         margin-bottom: 5px !important;
    //       }
    //     </style>
    //   ''';

    //   // Add viewport meta tag and CSS overrides
    //   if (content.contains('<head>')) {
    //     content = content.replaceFirst('<head>', '''<head>
    //         <meta name="viewport" content="width=${(width == double.infinity ? 300 : width ?? 300).toInt()}, height=${height.toInt()}, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0">
    //         $cssOverrides''');
    //   } else {
    //     content = '''<head>
    //       <meta name="viewport" content="width=${(width == double.infinity ? 300 : width ?? 300).toInt()}, height=${height.toInt()}, initial-scale=1.0, user-scalable=no">
    //       $cssOverrides
    //     </head>$content''';
    //   }
    //   return SizedBox(
    //     width: width ?? double.infinity,
    //     height: height,
    //     child: ClipRRect(
    //       borderRadius: BorderRadius.circular(10),
    //       child: WebViewWidget(
    //         controller:
    //             WebViewController()
    //               ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //               ..setBackgroundColor(Colors.transparent)
    //               ..setNavigationDelegate(
    //                 NavigationDelegate(
    //                   onPageFinished: (String url) {
    //                     // Optional: Handle page load completion
    //                   },
    //                 ),
    //               )
    //               ..loadHtmlString(content),
    //       ),
    //     ),
    //   );
    //     FutureBuilder<String>(
    //       future: analyticsUsecase.downloadFile(
    //         url:
    //             'http://minecraftslaves.duckdns.org:8082/shops/1/products/227be1d1-41a9-4d4d-a174-83d979dd3995/visualizations/2eceec3f-5a16-49a7-b7cf-7f9c92f95043',
    //       ),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return const Center(child: CircularProgressIndicator());
    //         }
    //         if (snapshot.hasError) {
    //           return Center(child: Text('Error: ${snapshot.error}'));
    //         }
    //         return ClipRRect(
    //           borderRadius: BorderRadius.circular(10),
    //           child: Image.asset(
    //             snapshot.data!,
    //             fit: BoxFit.cover,
    //             width: double.infinity,
    //             height: double.infinity,
    //             errorBuilder: (context, error, stackTrace) {
    //               return _buildPlaceholder();
    //             },
    //           ),
    //         );
    //       },
    //     ),
    //   ],
    // ),

    // Chart image or placeholder
    // if (visual != null && visual!.isNotEmpty)
    //   ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: Image(
    //       image: AssetImage(analyticsUsecase.urlProcessing(visual!)),
    //     ),
    // Image.network(
    // imageUrl!,
    // fit: BoxFit.cover,
    // width: double.infinity,
    // height: double.infinity,
    // errorBuilder: (context, error, stackTrace) {
    //   return _buildPlaceholder();
    // },
    // loadingBuilder: (context, child, loadingProgress) {
    //   if (loadingProgress == null) return child;
    //   return Center(
    //     child: CircularProgressIndicator(
    //       value:
    //           loadingProgress.expectedTotalBytes != null
    //               ? loadingProgress.cumulativeBytesLoaded /
    //                   loadingProgress.expectedTotalBytes!
    //               : null,
    //       valueColor: AlwaysStoppedAnimation<Color>(
    //         Colors.purple.shade300,
    //       ),
    //     ),
    //   );
    // },
    // else
    //   _buildPlaceholder(),

    // Analytics icon in the bottom right
    //           Positioned(
    //             bottom: 8,
    //             right: 8,
    //             child: Container(
    //               padding: const EdgeInsets.all(4),
    //               child: Image.asset(
    //                 'assets/chart/logo_icon.png',
    //                 width: 24,
    //                 height: 24,
    //                 // Remove the color property to show the original PNG colors
    //                 errorBuilder: (context, error, stackTrace) {
    //                   print('Error loading image: $error');
    //                   // If loading fails, show a fallback icon that matches the design
    //                   return Container(
    //                     width: 16,
    //                     height: 16,
    //                     decoration: BoxDecoration(
    //                       color: Colors.white,
    //                       borderRadius: BorderRadius.circular(2),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ),
    //         }
    //               ),
    //             ),
    //           ),
    //                   ;
    //         }
    //       )],
    //   ),
    // );
  }

  Widget _buildPlaceholder() {
    return placeholder ??
        Center(
          child: Text(
            'Chart Placeholder',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        );
  }
}
