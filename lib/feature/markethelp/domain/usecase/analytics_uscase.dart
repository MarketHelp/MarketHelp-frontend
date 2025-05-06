import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

class AnalyticsUsecase {
  final Dio _dio = GetIt.I<Dio>();

  /// Downloads a file from the provided URL and saves it to a local path
  /// Returns the path to the downloaded file or throws an exception if download fails
  Future<String> downloadFile({
    required String url,
    String? customFileName,
    Function(double progress)? onProgressUpdate,
  }) async {
    try {
      // Create directory for download
      final directory = await getTemporaryDirectory();
      final fileName = customFileName ?? url.split('/').last;
      final savePath = '${directory.path}/$fileName';

      // Download with progress
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgressUpdate?.call(progress);
          }
        },
        deleteOnError: true,
      );

      // Verify file exists
      final file = File(savePath);
      if (await file.exists()) {
        return savePath;
      } else {
        throw Exception('Downloaded file not found at $savePath');
      }
    } catch (e) {
      throw Exception('Failed to download file: ${e.toString()}');
    }
  }

  /// Downloads multiple files concurrently and returns a list of file paths
  Future<List<String>> downloadMultipleFiles({
    required List<String> urls,
    Function(double overallProgress)? onProgressUpdate,
  }) async {
    final List<String> downloadedFilePaths = [];
    final int totalFiles = urls.length;
    int completedFiles = 0;

    try {
      final futures = urls.map((url) async {
        final path = await downloadFile(url: url);
        downloadedFilePaths.add(path);

        // Update overall progress
        completedFiles++;
        final progress = completedFiles / totalFiles;
        onProgressUpdate?.call(progress);

        return path;
      });

      // Wait for all downloads to complete
      await Future.wait(futures);
      return downloadedFilePaths;
    } catch (e) {
      // Clean up any partial downloads
      for (final path in downloadedFilePaths) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
      throw Exception('Failed to download one or more files: ${e.toString()}');
    }
  }

  /// Cleans up temporary downloaded files
  Future<void> cleanupDownloadedFiles(List<String> filePaths) async {
    for (final path in filePaths) {
      try {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        // Log error but don't throw - cleanup should be best effort
        print('Failed to delete file $path: ${e.toString()}');
      }
    }
  }

  String urlProcessing(String url) {
    Map<String, String> imageUrls = {
      'id1': 'assets/mvp_charts/bar1.png',
      'id2': 'assets/mvp_charts/pie1.png',
      'id3': 'assets/mvp_charts/share_graph1.png',
      'id4': 'assets/mvp_charts/bar2.png',
      'id5': 'assets/mvp_charts/pie2.png',
      'id6': 'assets/mvp_charts/share_graph2.png',
    };

    return imageUrls[url] ?? 'assets/mvp_charts/bar1.png';
  }
}
