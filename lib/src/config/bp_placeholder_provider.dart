import 'package:better_player/src/core/bp_data_source_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'bp_config_provider.dart';

final bpPlaceholderProvider = Provider.autoDispose((ref) {
  var bpDataSourceP = ref.watch(bpDataSourceProvider!.select((v) => v?.placeholder));
  var bpConfigP = ref.watch(bpConfigProvider!.select((v) => v.placeholder));
  return bpDataSourceP ?? bpConfigP ?? SizedBox();
});
