import 'package:better_player/src/types/bp_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

late final StateNotifierProvider<BPDataSourceNotifier, BPDataSource?> bpDataSourceProvider;

void initBpDataSourceProvider(BPDataSource bpDataSource) {
  bpDataSourceProvider = StateNotifierProvider<BPDataSourceNotifier, BPDataSource?>(
    (ref) => BPDataSourceNotifier(bpDataSource: bpDataSource),
  );
}

class BPDataSourceNotifier extends StateNotifier<BPDataSource?> {
  BPDataSourceNotifier({BPDataSource? bpDataSource}) : super(bpDataSource);

  void setBpDataSource(BPDataSource bpDataSource) {
    state = bpDataSource;
  }
}
