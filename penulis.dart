class Penulis {
  final int idPenulis;
  final String namaPenulis;
  final String profil;
  final String? createdAt;
  final String? updatedAt;

  Penulis({
    required this.idPenulis,
    required this.namaPenulis,
    required this.profil,
    this.createdAt,
    this.updatedAt,
  });

  factory Penulis.fromJson(Map<String, dynamic> json) {
    return Penulis(
      idPenulis: json['id_penulis'],
      namaPenulis: json['nama_penulis'],
      profil: json['profil'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_penulis': idPenulis,
      'nama_penulis': namaPenulis,
      'profil': profil,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
