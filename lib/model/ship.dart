class Ship {
  late int id;
  late int tier;
  late String type;
  late bool isSpecial;
  late bool isPremium;
  late String nation;
  late String name;
  late String imgLink;
  late ShipAverageData? averageData;

  Ship({
    required this.id,
    required this.tier,
    required this.type,
    required this.isSpecial,
    required this.isPremium,
    required this.nation,
    required this.name,
    required this.imgLink,
    this.averageData,
  });

  factory Ship.fromJson(Map<String, dynamic> json,
      {Map<String, dynamic>? averageDataJson}) {
    return Ship(
      id: json['ship_id'],
      tier: json['tier'],
      type: json['type'],
      isSpecial: json['is_special'],
      isPremium: json['is_premium'],
      nation: json['nation'],
      name: json['name'],
      imgLink: json['images']['medium'],
      averageData: averageDataJson != null && averageDataJson.isNotEmpty
          ? ShipAverageData.fromJson(averageDataJson)
          : null,
    );
  }

  String getRomanTier() {
    var romanList = [
      "0",
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX",
      "X",
      "★"
    ];
    try {
      return romanList[tier];
    } catch (e) {
      return "Unknown";
    }
  }
}

class ShipAverageData {
  late double averageDamageDealt;
  late double averageFrags;
  late double winRate;

  ShipAverageData({
    required this.averageDamageDealt,
    required this.averageFrags,
    required this.winRate,
  });

  factory ShipAverageData.fromJson(Map<String, dynamic> json) {
    return ShipAverageData(
      averageDamageDealt: json['average_damage_dealt'],
      averageFrags: json['average_frags'],
      winRate: json['win_rate'],
    );
  }
}

class ShipProvider {
  List<Ship> ships = [];

  ShipProvider._privateConstructor();
  static final ShipProvider _instance = ShipProvider._privateConstructor();
  factory ShipProvider() {
    return _instance;
  }

  void update(
      Map<String, dynamic> shipsJson, Map<String, dynamic> averageDataJson) {
    ships.clear();
    shipsJson['data'].forEach((key, value) {
      int shipId = int.parse(key);
      Map<String, dynamic>? averageData = averageDataJson['data'][key];
      ships.add(Ship.fromJson({...value, 'ship_id': shipId},
          averageDataJson: averageData));
    });
  }
}
