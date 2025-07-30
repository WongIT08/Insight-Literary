<?php
namespace App\Http\Controllers;

use App\Models\Penulis; // pastikan model Penulis sudah ada
use Illuminate\Http\Request;

class AuthorController extends Controller
{
    public function getAuthorDetail($id) {
        $author = Penulis::with('books')->find($id);
        if ($author) {
            return response()->json(['success' => true, 'author' => $author]);
        }
        return response()->json(['success' => false, 'message' => 'Penulis tidak ditemukan'], 404);
    }

    public function getAllAuthors() {
        $authors = Penulis::all();
        return response()->json(['success' => true, 'authors' => $authors]);
    }
}
