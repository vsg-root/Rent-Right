class Range {
  double _min;
  double _max;

  Range({
    required start,
    required end,
  })  : _min = start,
        _max = end >= start
            ? end
            : {throw 'Invalid Parameter: end must be bigger than the start'};

  double getStart() {
    return _min;
  }

  double getEnd() {
    return _max;
  }

  void setStart(double value) {
    _min = value;
  }

  void setEnd(double value) {
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
