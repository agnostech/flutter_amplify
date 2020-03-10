class Device {
  final DateTime _createDate;
  final String _deviceKey;
  final DateTime _lastAuthenticatedDate;
  final DateTime _lastModifiedDate;
  final Map<String, String> _attributes;

  Device(DateTime createDate, String deviceKey, DateTime lastAuthenticatedDate,
      DateTime lastModifiedDate, Map<String, String> attributes)
      : _createDate = createDate,
        _deviceKey = deviceKey,
        _lastAuthenticatedDate = lastAuthenticatedDate,
        _lastModifiedDate = lastModifiedDate,
        _attributes = attributes;

  DateTime get createDate => _createDate;

  String get deviceKey => _deviceKey;

  DateTime get lastAuthenticatedDate => _lastAuthenticatedDate;

  DateTime get lastModifiedDate => _lastModifiedDate;

  Map<String, String> get attributes => _attributes;
}
