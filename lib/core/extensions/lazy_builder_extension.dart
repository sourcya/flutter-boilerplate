import 'package:flutter/material.dart';

extension LazyBuilderFunction on Widget Function() {
  Widget get lazy => Builder(builder: (_) => this());
}
