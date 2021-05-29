class User {
  String contactEmail;
  String password; 
  User(this.contactEmail,this.password 
  );

  User.fromJson(Map<String, dynamic>json){
    contactEmail= json['contactEmail'];
    password = json['password'];
    
  }
}
