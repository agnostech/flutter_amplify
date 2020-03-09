class UserCodeDeliveryDetails {
  final String _destination;
  final String _deliveryMedium;
  final String _attributeName;

  UserCodeDeliveryDetails(
      String destination, String deliveryMedium, String attributeName)
      : _destination = destination,
        _deliveryMedium = deliveryMedium,
        _attributeName = attributeName;

  String get destination => _destination;

  String get deliveryMedium => _deliveryMedium;

  String get attributeName => _attributeName;
}
