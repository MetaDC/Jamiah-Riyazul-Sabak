import 'package:cloud_firestore/cloud_firestore.dart';

class Studentmodel {
  final String docId;
  final String grNO;
  final String name;
  final String addressHouseNo;
  final String addressHouseArea;
  final DateTime dob;
  final String phoneNumber;
  final String? email;
  final bool isMale;
  final String? prevSchoolName;
  final String? prevSchoolClass;
  final String? prevMadrasaName;
  final String? prevDeeniyatDetail;
  final String? currentSchoolStd;
  final String currentDeeniyat;
  // final String feeType;
  final DateTime addmissonDate;
  final DateTime createdAt;
  final String? feeRemarks;
  final String feeType;

  Studentmodel({
    required this.docId,
    required this.grNO,
    required this.addressHouseNo,
    required this.addressHouseArea,
    required this.name,
    required this.dob,
    required this.phoneNumber,
    required this.email,
    required this.isMale,
    required this.prevSchoolName,
    required this.prevSchoolClass,
    required this.prevMadrasaName,
    required this.prevDeeniyatDetail,
    required this.currentSchoolStd,
    required this.currentDeeniyat,
    // required this.feeType,
    required this.addmissonDate,
    required this.createdAt,
    required this.feeRemarks,
    required this.feeType,
  });
  Map<String, dynamic> toMap() {
    return {
      'studId': docId,
      'grNO': grNO,
      'name': name,
      'addressHouseNo': addressHouseNo,
      'addressHouseArea': addressHouseArea,
      'dob': Timestamp.fromDate(dob),
      'phoneNumber': phoneNumber,
      'email': email,
      'isMale': isMale,
      'prevSchoolName': prevSchoolName,
      'prevSchoolClass': prevSchoolClass,
      'prevMadrasaName': prevMadrasaName,
      'prevDeeniyatDetail': prevDeeniyatDetail,
      'currentSchoolStd': currentSchoolStd,
      'currentDeeniyat': currentDeeniyat,
      // 'feeType': feeType,
      'addmissonDate': Timestamp.fromDate(addmissonDate),
      'createdAt': Timestamp.fromDate(createdAt),
      'feeRemarks': feeRemarks,
      'feeType': feeType,
    };
  }

  factory Studentmodel.fromJson(Map<String, dynamic> json) {
    return Studentmodel(
      docId: json['studId'],
      grNO: json['grNO'],
      name: json['name'],
      addressHouseNo: json['addressHouseNo'],
      addressHouseArea: json['addressHouseArea'],
      dob: (json['dob'] as Timestamp).toDate(),
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      isMale: json['isMale'] ?? false,
      prevSchoolName: json['prevSchoolName'],
      prevSchoolClass: json['prevSchoolClass'],
      prevMadrasaName: json['prevMadrasaName'],
      prevDeeniyatDetail: json['prevDeeniyatDetail'],
      currentSchoolStd: json['currentSchoolStd'],
      currentDeeniyat: json['currentDeeniyat'],
      // feeType: json['feeType'],
      addmissonDate: (json['addmissonDate'] as Timestamp).toDate(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      feeRemarks: json['feeRemarks'] ?? '',
      feeType: json['feeType'],
    );
  }

  factory Studentmodel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('Student document ${doc.id} has no data');
    }

    return Studentmodel(
      docId: doc.id,

      grNO: data['grNO'] ?? '',
      name: data['name'] ?? '',

      addressHouseNo: data['addressHouseNo'] ?? '',
      addressHouseArea: data['addressHouseArea'] ?? '',

      dob: (data['dob'] as Timestamp?)?.toDate() ?? DateTime(2000),

      phoneNumber: data['phoneNumber'] ?? '',
      email: data['email'],

      isMale: data['isMale'] ?? false,

      prevSchoolName: data['prevSchoolName'],
      prevSchoolClass: data['prevSchoolClass'],
      prevMadrasaName: data['prevMadrasaName'],
      prevDeeniyatDetail: data['prevDeeniyatDetail'],

      currentSchoolStd: data['currentSchoolStd'],
      currentDeeniyat: data['currentDeeniyat'] ?? '',

      addmissonDate:
          (data['addmissonDate'] as Timestamp?)?.toDate() ?? DateTime.now(),

      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),

      feeType: data['feeType'] ?? 'unknown',
      feeRemarks: data['feeRemarks'],
    );
  }
}
