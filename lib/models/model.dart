abstract class Model<T> {

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  @override
  String toString() {
    return this.toJson().toString();
  }
}
