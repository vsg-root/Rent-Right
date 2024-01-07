class Range {
  double _min;
  double _max;

  Range({
    required double start,
    required double end,
  })  : _min = start,
        _max = end >= start
            ? end
            : throw 'Invalid Parameter: end must be bigger than the start';

  double get start => _min;
  set start(double value) {
    _min = value;
  }

  double get end => _max;
  set end(double value) {
    _max = value;
  }

  bool openIntervalCheck(double value) {
    return _min < value && value < _max;
  }

  bool closeIntervalCheck(double value) {
    return _min <= value && value <= _max;
  }

  @override
  String toString() {
    return '[ $_min -> $_max ]';
  }
}
