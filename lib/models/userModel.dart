class UserModel{

  String email;
  String? id;
  String? password;
  String userName;
  String city;
  String phone;
  String? urlImage;
  UserModel({required this.email,required this.userName,required this.city,required this.phone,this.password,this.id,this.urlImage });
  Map<String,dynamic> toMap(){
    return{
      "email":email,
      "userName":userName,
      "city":city,
      "phone":phone,
      "id":id,
      "urlImage":urlImage

    };
  }

 factory UserModel.fromeMap(Map<String,dynamic> map){
    return UserModel(
        email: map["email"] ,
        userName: map["userName"] ,
        city: map["city"] ,
        phone: map["phone"],
        id: map["id"],
        urlImage:map["urlImage"]??"https://raw.githubusercontent.com/flutter-devs/flutter_profileview_demo/master/assets/images/as.png",
      //"assets/images/as.png"
    );
  }

}