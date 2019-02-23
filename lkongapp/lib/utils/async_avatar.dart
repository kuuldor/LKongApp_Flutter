library async_avatar;

import 'package:flutter/foundation.dart';
import 'dart:ui' as ui;

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:lkongapp/utils/cache_manager.dart';
import 'package:lkongapp/utils/lkong.dart';

typedef void ErrorListener();

class AvatarLoaderState {
  bool disposed = false;
}

mixin AvatarCodecMixin implements ui.Codec {}
mixin ImageFrameInfoMixin implements ui.FrameInfo {}

class ImageFrameInfo extends Object with ImageFrameInfoMixin {
  final ui.Image image;
  final Duration duration;

  ImageFrameInfo(this.image, this.duration);
}

class AsyncAvatarProvider extends ImageProvider<AsyncAvatarProvider>
    with AvatarCodecMixin {
  static ui.Codec defaultCodec;
  static final defaultAvatar = "assets/noavatar.png";

  /// Creates an ImageProvider which loads an image from the [url], using the [scale].
  /// When the image fails to load [errorListener] is called.
  AsyncAvatarProvider(this.loader, this.url,
      {this.scale: 1.0,
      this.delayInMillies: 0,
      this.errorListener,
      this.headers})
      : assert(url != null),
        assert(scale != null);

  final AvatarLoaderState loader;
  final String url;

  final int delayInMillies;

  /// Scale of the image
  final double scale;

  /// Listener to be called when images fails to load.
  final ErrorListener errorListener;

  // Set headers for the image provider, for example for authentication
  final Map<String, String> headers;

  @override
  Future<AsyncAvatarProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<AsyncAvatarProvider>(this);
  }

  @override
  ImageStreamCompleter load(AsyncAvatarProvider key) {
    return MultiFrameImageStreamCompleter(
        codec: _getCodec(key),
        scale: key.scale,
        informationCollector: (StringBuffer information) {
          information.writeln('Image provider: $url');
          information.write('Image key: $key');
        });
  }

  Future<ui.Codec> _getCodec(AsyncAvatarProvider key) {
    return Future(() => this);
  }

  @override
  bool operator ==(dynamic other) {
    if (other.runtimeType != runtimeType) return false;
    final AsyncAvatarProvider typedOther = other;
    return url == typedOther.url &&
        loader == typedOther.loader &&
        scale == typedOther.scale;
  }

  @override
  int get hashCode => hashValues(url, loader, scale);

  @override
  String toString() => '$runtimeType("$url", scale: $scale)';

// ----- AvatarCodec -------------
  @override
  void dispose() {}

  int _frameCount = 2;
  @override
  int get frameCount {
    return _frameCount;
  }

  int _repetitionCount = -1;
  @override
  int get repetitionCount {
    return _repetitionCount;
  }

  bool defaultAvatarServed = false;
  ui.Codec avatarCodec;

  _loadCodec() {
    if (loader == null || !loader.disposed) {
      return _loadAsync().then((c) {
        avatarCodec = c;
        return c;
      });
    } else {
      return getDefaultCodec();
    }
  }

  @override
  Future<ui.FrameInfo> getNextFrame() async {
    if (avatarCodec != null) {
      return avatarCodec.getNextFrame();
    }
    var cacheManager = await CacheManager.getInstance();
    bool fetched = cacheManager.hasKey(url);
    if (fetched || defaultAvatarServed || delayInMillies == 0) {
      ui.Codec codec;
      if (!fetched && delayInMillies > 0) {
        codec = await Future.delayed(
          Duration(milliseconds: delayInMillies),
          () => _loadCodec(),
        );
      } else {
        codec = await _loadCodec();
      }
      _frameCount = codec.frameCount;
      _repetitionCount = codec.repetitionCount;

      return codec.getNextFrame();
    } else {
      await getDefaultCodec();

      final defaultFrame = await defaultCodec.getNextFrame();

      ImageFrameInfo frame =
          ImageFrameInfo(defaultFrame.image, Duration(milliseconds: 0));
      defaultAvatarServed = true;
      return frame;
    }
  }

  Future<ui.Codec> getDefaultCodec() async {
    if (defaultCodec == null) {
      defaultCodec = await rootBundle.load(defaultAvatar).then((bytes) {
        Uint8List lst = new Uint8List.view(bytes.buffer);
        return ui.instantiateImageCodec(lst);
      });
    }
    return defaultCodec;
  }

  Future<ui.Codec> _loadAsync() async {
    var cacheManager = await CacheManager.getInstance();
    var file = await cacheManager.getFile(url, headers: headers);
    if (file == null) {
      return getDefaultCodec();
    }
    return await _loadAsyncFromFile(file);
  }

  Future<ui.Codec> _loadAsyncFromFile(File file) async {
    final Uint8List bytes = await file.readAsBytes();

    if (bytes.lengthInBytes == 0) {
      throw new Exception("File was empty");
    }

    return await ui.instantiateImageCodec(bytes);
  }
}
