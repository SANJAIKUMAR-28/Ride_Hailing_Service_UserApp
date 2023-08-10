class UserModel{
  String? uid;
  String? email;
  String? name;
  String? phoneno;

  UserModel({this.uid,this.email,this.name,this.phoneno});
  //recieve data from server
  factory UserModel.fromMap(map){
    return UserModel(
        uid:map['uid'],
        email:map['email'],
        name:map['name'],
        phoneno: map['phoneno']
    );
  }
  //send data to server
  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'email':email,
      'name':name,
      'phoneno':phoneno
    };
  }

}