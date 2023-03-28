class RequestBloodDonation
{
  String? serviceType;
  String? bloodType;
  String? type;
  String? location;
  String? note;
  String? name;
  String? phone;
  String? uId;
  String? date;


  RequestBloodDonation({
    required this.serviceType,
    required this.location,
    required this.uId,
    required this.note,
    required this.name,
    required this.type,
    required this.phone,
    required this.bloodType,
    required this.date,
  });
  RequestBloodDonation.fromJson(Map<String,dynamic>json)
  {
    serviceType = json['serviceType'];
    bloodType = json['bloodType'];
    type = json['type'];
    location = json['location'];
    note = json['note'];
    uId = json['uId'];
    name = json['name'];
    phone = json['phone'];
    date = json['date'];
  }
  Map<String,dynamic> toMap()
  {
    return {
      'serviceType': serviceType,
      'location': location,
      'uId':uId,
      'note':note,
      'name':name,
      'phone':phone,
      'bloodType':bloodType,
      'type':type,
      'date':date,
    };
  }
}