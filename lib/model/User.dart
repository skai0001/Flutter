class User{

  String firstName;
  String lastName;
  String emailId;

  User(this.firstName, this.lastName,this.emailId);

  User.fromMap(Map map) {
    firstName = map[firstName];
    lastName = map[lastName];
    emailId = map[emailId];
  }

}