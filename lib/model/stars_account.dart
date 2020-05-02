class StarsAccount {
  int accountID;
  String accountFullname;
  String accountEmail;
  int recordID;
  int profileID;
  bool valid;
  String errDescription;

  StarsAccount(
      {this.accountID,
      this.accountFullname,
      this.accountEmail,
      this.recordID,
      this.profileID});
}
