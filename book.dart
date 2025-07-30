class Book {
  final int idBuku;
  final String judul;
  final int idPenulis;
  final String deskripsi;
  final String genre;
  final String tipe;
  final double rating;
  final int views;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  Book({
    required this.idBuku,
    required this.judul,
    required this.idPenulis,
    required this.deskripsi,
    required this.genre,
    required this.tipe,
    required this.rating,
    required this.views,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      idBuku: json['id_buku'],
      judul: json['judul'],
      idPenulis: json['id_penulis'],
      deskripsi: json['deskripsi'],
      genre: json['genre'],
      tipe: json['tipe'],
      rating: (json['rating'] as num).toDouble(),
      views: json['views'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_buku': idBuku,
      'judul': judul,
      'id_penulis': idPenulis,
      'deskripsi': deskripsi,
      'genre': genre,
      'tipe': tipe,
      'rating': rating,
      'views': views,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
