<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Penulis extends Model
{
    protected $table = 'penulis';          // nama tabel
    protected $primaryKey = 'id_penulis';  // primary key
    public $timestamps = true;             // ada created_at & updated_at

    protected $fillable = [
        'nama_penulis',
        'profil',
    ];
}
