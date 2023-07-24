class Event {
  late BigInt event_id;
  late String title;
  late String content;
  late String date;
  late String exp_date;
  late String user_id;
  Event(BigInt event_id, String title, String content, String date,
      String exp_date, String user_id) {
    this.event_id = event_id;
    this.title = title;
    this.content = content;
    this.date = date;
    this.exp_date = exp_date;
    this.user_id = user_id;
  }
}
