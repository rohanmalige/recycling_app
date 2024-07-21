import 'package:flutter/cupertino.dart';
import 'package:live_object_detection_ssd_mobilenet/models/screen_params.dart';

/// Represents the recognition output from the model
class Recognition {
  /// Index of the result
  final int _id;

  /// Label of the result
  final String _label;

  /// Confidence [0.0, 1.0]
  final double _score;

  /// Location of bounding box rect
  ///
  /// The rectangle corresponds to the raw input image
  /// passed for inference
  final Rect _location;
  String _classification = '';
  int _recyclableCount = 0;
  Recognition(this._id, this._label, this._score, this._location);

  int get id => _id;

  String get label => _label;

  double get score => _score;

  Rect get location => _location;

  /// Returns bounding box rectangle corresponding to the
  /// displayed image on screen
  ///
  /// This is the actual location where rectangle is rendered on
  /// the screen
  ///
  // New getter and setter for classification
  String get classification => _classification;
  int get recyclableCount => _recyclableCount;
  set classification(String value) {
    _classification = value;
  }

  void incrementRecyclableCount() {
    _recyclableCount++;
  }

  Rect get renderLocation {
    final double scaleX = ScreenParams.screenPreviewSize.width / 300;
    final double scaleY = ScreenParams.screenPreviewSize.height / 300;
    return Rect.fromLTWH(
      location.left * scaleX,
      location.top * scaleY,
      location.width * scaleX,
      location.height * scaleY,
    );
  }

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: $score, location: $location, classification: $classification, recyclableCount: $recyclableCount)';
  }
}
