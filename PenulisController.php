<?php

namespace App\Http\Controllers;

use App\Models\Penulis;

class PenulisController extends Controller
{
    public function getPenulis()
    {
        return response()->json([
            'success' => true,
            'data' => Penulis::all()
        ]);
    }
}
