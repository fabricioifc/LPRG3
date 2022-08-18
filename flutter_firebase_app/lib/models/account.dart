class Account {
  String? sigla;
  String? name;
  String? icone;
  double? saldo;

  Account({
    this.sigla,
    this.name,
    this.icone,
    this.saldo,
  });

  Account.fromJson(Map<String, dynamic> json) {
    sigla = json['sigla'];
    name = json['name'];
    icone = json['icone'];
    saldo = json['saldo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sigla'] = this.sigla;
    data['name'] = this.name;
    data['icone'] = this.icone;
    data['saldo'] = this.saldo;
    return data;
  }
}
