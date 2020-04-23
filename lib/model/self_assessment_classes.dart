//class StarsSelfAssessmentRangeParameter {}

class RangeValueList {
  List<RangeValue> rangeValue;
  Map<String, RangeParams> rangeTypes;

  RangeValueList({this.rangeValue});

  RangeValueList.fromJson(Map<String, dynamic> json) {
    rangeTypes = Map();
    if (json['RangeValue'] != null) {
      rangeValue = new List<RangeValue>();
      json['RangeValue'].forEach((v) {
        RangeValue rv = new RangeValue.fromJson(v);
        rangeValue.add(rv);
        rangeTypes.putIfAbsent(rv.rangeParams.name, () => rv.rangeParams);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rangeValue != null) {
      data['RangeValue'] = this.rangeValue.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RangeValue {
  RangeParams rangeParams;
  int surgicalProfileId;
  int rangeparamId;
  double value;
  String insertedAt;
  int id;

  RangeValue(
      {this.rangeParams,
      this.surgicalProfileId,
      this.rangeparamId,
      this.value,
      this.insertedAt,
      this.id});

  RangeValue.fromJson(Map<String, dynamic> json) {
    rangeParams = json['RangeParams'] != null
        ? new RangeParams.fromJson(json['RangeParams'])
        : null;
    surgicalProfileId = json['surgical_profile_id'];
    rangeparamId = json['rangeparam_id'];
    value = json['value'];
    insertedAt = json['inserted_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rangeParams != null) {
      data['RangeParams'] = this.rangeParams.toJson();
    }
    data['surgical_profile_id'] = this.surgicalProfileId;
    data['rangeparam_id'] = this.rangeparamId;
    data['value'] = this.value;
    data['inserted_at'] = this.insertedAt;
    data['id'] = this.id;
    return data;
  }
}

class RangeParams {
  List<RangeParamValues> rangeParamValues;
  int id;
  String name;
  double valueFrom;
  double valueUntil;
  double step;
  String unit;

  RangeParams(
      {this.rangeParamValues,
      this.id,
      this.name,
      this.valueFrom,
      this.valueUntil,
      this.step,
      this.unit});

  RangeParams.fromJson(Map<String, dynamic> json) {
    if (json['RangeParamValues'] != null) {
      rangeParamValues = new List<RangeParamValues>();
      json['RangeParamValues'].forEach((v) {
        rangeParamValues.add(new RangeParamValues.fromJson(v));
      });
    }
    id = json['id'];
    name = json['name'];
    valueFrom = json['value_from'];
    valueUntil = json['value_until'];
    step = json['step'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rangeParamValues != null) {
      data['RangeParamValues'] =
          this.rangeParamValues.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['value_from'] = this.valueFrom;
    data['value_until'] = this.valueUntil;
    data['step'] = this.step;
    data['unit'] = this.unit;
    return data;
  }
}

class RangeParamValues {
  int surgicalProfileId;
  int rangeparamId;
  double value;
  String insertedAt;
  int id;

  RangeParamValues(
      {this.surgicalProfileId,
      this.rangeparamId,
      this.value,
      this.insertedAt,
      this.id});

  RangeParamValues.fromJson(Map<String, dynamic> json) {
    surgicalProfileId = json['surgical_profile_id'];
    rangeparamId = json['rangeparam_id'];
    value = json['value'];
    insertedAt = json['inserted_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['surgical_profile_id'] = this.surgicalProfileId;
    data['rangeparam_id'] = this.rangeparamId;
    data['value'] = this.value;
    data['inserted_at'] = this.insertedAt;
    data['id'] = this.id;
    return data;
  }
}
