class SignUpBody {
  String email;
  String password;
  String name;
  String phone;

  SignUpBody(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone});

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['f_name']=name;
    data['phone']=phone;
    data['email']=email;
    data['password']=password;
    
    return data;
  }
}
