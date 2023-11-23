import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String judul;
  String keterangan;
  String tanggal;
  bool isLike;
  String pembicara;

  EventModel({
    this.id,
    required this.judul,
    required this.keterangan,
    required this.tanggal,
    required this.isLike,
    required this.pembicara,
  });

  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'keterangan': keterangan,
      'pembicara': pembicara,
      'is_like': isLike,
      'tanggal': tanggal,
    };
  }

  EventModel.fromDocSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        judul = doc.data()?['judul'],
        keterangan = doc.data()?['keterangan'],
        pembicara = doc.data()?['pembicara'],
        isLike = doc.data()?['is_like'],
        tanggal = doc.data()?['tanggal'];
}
