<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Book extends Model
{
    use HasFactory;

    protected $primaryKey = 'id_buku'; // karena nama PK-nya bukan "id"

    protected $fillable = [
        'judul',
        'id_penulis',
        'deskripsi',
        'genre',
        'tipe',
        'rating',
        'views',
        'image',
    ];

    // Relasi: satu buku punya satu penulis
    public function penulis()
    {
        return $this->belongsTo(Penulis::class, 'id_penulis', 'id_penulis');
    }

    public function favorites()
{
    return $this->hasMany(Favorite::class, 'book_id', 'id_buku');
}

}
