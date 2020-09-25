import 'model.dart';

class NivelModel extends Model<NivelModel> {
  String descricao;
  int qtdhoras;

  NivelModel({this.descricao, this.qtdhoras});

  @override
  NivelModel fromJson(Map<String, dynamic> json) {
    this.descricao = json['descricao'];
    this.qtdhoras = json['qtdhoras'];
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = Map();
    json['descricao'] = this.descricao;
    json['qtdhoras'] = this.qtdhoras;
    return json;
  }
}
