<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class Admin extends Authenticatable
{
    use HasFactory;

    protected $primaryKey = 'id'; // default pk = id

    protected $fillable = [
        'username',
        'password',
        'fullname',
    ];

    // Kalau kamu nanti pakai auth Laravel, ini default
    public $timestamps = true;
}
