class RequestHealthCare
{
  String? serviceType;
  String? type;
  String? location;
  String? issue;
  String? uId;
  String? date;
  String? name;
  String? phone;


  RequestHealthCare({
    required this.serviceType,
    required this.type,
    required this.location,
    required this.uId,
    required this.issue,
    required this.date,
    required this.name,
    required this.phone,
  });
  RequestHealthCare.fromJson(Map<String,dynamic>json)
  {
    serviceType = json['serviceType'];
    type = json['type'];
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
      'type': type,
      'location': location,
      'uId':uId,
      'issue':issue,
      'date':date,
      'name':name,
      'phone':phone,
    };
  }
}