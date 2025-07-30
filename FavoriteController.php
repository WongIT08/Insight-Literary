<?php

namespace App\Http\Controllers;

use App\Models\Favorite;
use App\Models\Book;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    // Tambahkan ke favorit
    public function addFavorite(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id_user',
            'book_id' => 'required|exists:books,id_buku',
        ]);

        // Cek kalau sudah ada
        $existing = Favorite::where('user_id', $validated['user_id'])
                            ->where('book_id', $validated['book_id'])
                            ->first();
        if ($existing) {
            return response()->json(['success' => false, 'message' => 'Buku sudah ada di favorit']);
        }

        $favorite = Favorite::create($validated);

        return response()->json(['success' => true, 'message' => 'Buku ditambahkan ke favorit', 'favorite' => $favorite]);
    }

    // Hapus dari favorit
    public function removeFavorite(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id_user',
            'book_id' => 'required|exists:books,id_buku',
        ]);

        $favorite = Favorite::where('user_id', $validated['user_id'])
                            ->where('book_id', $validated['book_id'])
                            ->first();

        if (!$favorite) {
            return response()->json(['success' => false, 'message' => 'Buku tidak ada di favorit']);
        }

        $favorite->delete();

        return response()->json(['success' => true, 'message' => 'Buku dihapus dari favorit']);
    }

    // List favorit user
    public function listFavoritesByUser($user_id)
    {
        $favorites = Favorite::where('user_id', $user_id)
                    ->with('book')
                    ->get()
                    ->map(function($fav) {
                        return $fav->book; // ambil detail buku saja
                    });

        return response()->json(['success' => true, 'favorites' => $favorites]);
    }
}
