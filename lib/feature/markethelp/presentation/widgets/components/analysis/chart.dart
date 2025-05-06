import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:markethelp_frontend/feature/markethelp/domain/usecase/analytics_uscase.dart';

class ChartWidget extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final double? width;
  final Widget? placeholder;

  const ChartWidget({
    Key? key,
    this.imageUrl,
    this.height = 120,
    this.width,
    this.placeholder,
  }) : super(key: key);

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
          // Chart image or placeholder
          if (imageUrl != null && imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(analyticsUsecase.urlProcessing(imageUrl!)),
              ),
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
            )
          else
            _buildPlaceholder(),

          // Analytics icon in the bottom right
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),

              child: Image.asset(
                'assets/chart/logo_icon.png',
                width: 24,
                height: 24,
                // Remove the color property to show the original PNG colors
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  // If loading fails, show a fallback icon that matches the design
                  return Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
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
