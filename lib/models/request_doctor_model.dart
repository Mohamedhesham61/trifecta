class RequestDoctor
{
  String? serviceType;
  String? location;
  String? issue;
  String? uId;
  String? date;
  String? name;
  String? phone;


  RequestDoctor({
    required this.serviceType,
    required this.location,
    required this.uId,
    required this.issue,
    required this.date,
    required this.name,
    required this.phone,
  });
  RequestDoctor.fromJson(Map<String,dynamic>json)
  {
    serviceType = json['serviceType'];
    location = json['location'];
    uId = json['uId'];
    issue = json['issue'];
    date = json['date'];
    name = json['name'];
    phone = json['phone'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'serviceType': serviceType,
      'location': location,
      'uId':uId,
      'issue':issue,
      'date':date,
      'name':name,
      'phone':phone,
    };
  }
}