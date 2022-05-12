class Section {
  int start; // in millisecond
  int? end; // in millisecond
  int? duration; // in millisecond

  String title;
  String? desc;
  String? imgUrl;

  Section(this.title, {required this.start, this.duration, this.end, this.imgUrl, this.desc})
      : assert(duration != null || end != null, "duration or end must be filled."),
        assert(
          !(duration != null && end != null && end - start != duration),
          "should be match(duration = end - start).",
        ) {
    if (duration != null) {
      end = start + duration!;
    }
    if (end != null) {
      duration = end! - start;
    }
  }
}
