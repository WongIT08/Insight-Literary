<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class User extends Model
{
    protected $table = 'users';
    protected $primaryKey = 'id_user';
    public $timestamps = true; // aktifkan jika tabel punya created_at dan updated_at

    protected $fillable = [
        'username',
        'password',
        'fullname',
        'bio',
        'birth_date',
        'gender',
        'location',
        'image'
    ];

    public function favorites()
{
    return $this->hasMany(Favorite::class, 'user_id', 'id_user');
}

}
