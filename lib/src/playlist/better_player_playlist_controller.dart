import 'dart:async';
import 'package:better_player/better_player.dart';

///Controller used to manage playlist player.
class BPPlaylistController {
  ///List of data sources set for playlist.
  final List<BPDataSource> _bpDataSourceList;

  //General configuration of Better Player
  final BPCfg bpCfg;

  ///Playlist configuration of Better Player
  final BPPlaylistCfg bpPlaylistCfg;

  ///BPController instance
  BPController? _bpController;

  ///Currently playing data source index
  int _currentDataSourceIndex = 0;

  ///Next video change listener subscription
  StreamSubscription? _nextVideoTimeStreamSubscription;

  ///Flag that determines whenever player is changing video
  bool _changingToNextVideo = false;

  BPPlaylistController(
    this._bpDataSourceList, {
    this.bpCfg = const BPCfg(),
    this.bpPlaylistCfg = const BPPlaylistCfg(),
  }) : assert(_bpDataSourceList.isNotEmpty, "Better Player data source list can't be empty") {
    _setup();
  }

  ///Initialize controller and listeners.
  void _setup() {
    _bpController ??= BPController(
      bpCfg,
      bpPlaylistCfg: bpPlaylistCfg,
    );

    var initialStartIndex = bpPlaylistCfg.initialStartIndex;
    if (initialStartIndex >= _bpDataSourceList.length) {
      initialStartIndex = 0;
    }

    _currentDataSourceIndex = initialStartIndex;
    setupDataSource(_currentDataSourceIndex);
    _bpController!.addEventsListener(_handleEvent);
    _nextVideoTimeStreamSubscription = _bpController!.nextVideoTimeStream.listen((time) {
      if (time != null && time == 0) {
        _onVideoChange();
      }
    });
  }

  /// Setup new data source list. Pauses currently played video and init new data
  /// source list. Previous data source list will be removed.
  void setupDataSourceList(List<BPDataSource> dataSourceList) {
    _bpController?.pause();
    _bpDataSourceList.clear();
    _bpDataSourceList.addAll(dataSourceList);
    _setup();
  }

  ///Handle video change signal from BPController. Setup new data
  ///source based on configuration.
  void _onVideoChange() {
    if (_changingToNextVideo) {
      return;
    }
    final int nextDataSourceId = _getNextDataSourceIndex();
    if (nextDataSourceId == -1) {
      return;
    }
    if (_bpController!.isFullScreen) {
      _bpController!.exitFullScreen();
    }
    _changingToNextVideo = true;
    setupDataSource(nextDataSourceId);

    _changingToNextVideo = false;
  }

  ///Handle BPEvent from BPController. Used to control
  ///startup of next video timer.
  void _handleEvent(BPEvent bpEvent) {
    if (bpEvent.bpEventType == BPEventType.finished) {
      if (_getNextDataSourceIndex() != -1) {
        _bpController!.startNextVideoTimer();
      }
    }
  }

  ///Setup data source with index based on [_bpDataSourceList] provided
  ///in constructor. Index must
  void setupDataSource(int index) {
    assert(
        index >= 0 && index < _bpDataSourceList.length,
        "Index must be greater than 0 and less than size of data source "
        "list - 1");
    if (index <= _dataSourceLength) {
      _currentDataSourceIndex = index;
      _bpController!.setupDataSource(_bpDataSourceList[index]);
    }
  }

  ///Get index of next data source. If current index is less than
  ///[_bpDataSourceList] size then next element will be picked, otherwise
  ///if loops is enabled then first element of [_bpDataSourceList] will
  ///be picked, otherwise -1 will be returned, indicating that player should
  ///stop changing videos.
  int _getNextDataSourceIndex() {
    final currentIndex = _currentDataSourceIndex;
    if (currentIndex + 1 < _dataSourceLength) {
      return currentIndex + 1;
    } else {
      if (bpPlaylistCfg.loopVideos) {
        return 0;
      } else {
        return -1;
      }
    }
  }

  ///Get index of currently played source, based on [_bpDataSourceList]
  int get currentDataSourceIndex => _currentDataSourceIndex;

  ///Get size of [_bpDataSourceList]
  int get _dataSourceLength => _bpDataSourceList.length;

  ///Get BPController instance
  BPController? get bpController => _bpController;

  ///Cleanup BPPlaylistController
  void dispose() {
    _nextVideoTimeStreamSubscription?.cancel();
  }
}
