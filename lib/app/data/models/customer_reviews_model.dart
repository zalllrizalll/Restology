class CustomerReviews {
  String? name;
  String? review;
  String? date;

  CustomerReviews({
    this.name,
    this.review,
    this.date,
  });

  CustomerReviews.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    review = json['review'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['review'] = review;
    data['date'] = date;
    return data;
  }
}
