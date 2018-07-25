import 'package:flutter/material.dart';
import 'dart:async';
import 'package:coins_east/NetWork.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'dart:ui' as ui show instantiateImageCodec, Codec;
import 'dart:ui' show Size, Locale, TextDirection, hashValues;

class DioImage extends ImageProvider<DioImage> {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments must not be null.
  const DioImage(this.url, {this.scale = 1.0, this.headers})
      : assert(url != null),
        assert(scale != null);

  /// The URL from which the image will be fetched.
  final String url;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  final Map<String, String> headers;

  @override
  Future<DioImage> obtainKey(ImageConfiguration configuration) {
    return new SynchronousFuture<DioImage>(this);
  }

  @override
  ImageStreamCompleter load(DioImage key) {
    return new MultiFrameImageStreamCompleter(
        codec: _loadAsync(key),
        scale: key.scale,
        informationCollector: (StringBuffer information) {
          information.writeln('Image provider: $this');
          information.write('Image key: $key');
        });
  }

  Future<ui.Codec> _loadAsync(DioImage key) async {
    assert(key == this);
//    headers?.forEach((String name, String value) {
//      request.headers.add(name, value);
//    });
    final Response<HttpClientResponse> response = await NetWork()
        .dio
        .request(key.url, options: Options(responseType: ResponseType.STREAM));
//    if (response.statusCode != HttpStatus.ok)
//      throw new Exception(
//          'HTTP request failed, statusCode: ${response?.statusCode}');

    print('xxxxxxxxxxxxxx$response');
    final Uint8List bytes =
    await consolidateHttpClientResponseBytes(response.data);
    if (bytes.lengthInBytes == 0)
      throw new Exception('NetworkImage is an empty file:');

    return await ui.instantiateImageCodec(bytes);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final DioImage typedOther = other;
    return url == typedOther.url && scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';
}