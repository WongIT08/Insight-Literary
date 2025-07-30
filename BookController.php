<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Book;
use Illuminate\Support\Facades\Storage;

class BookController extends Controller
{
    // ✅ List semua buku
    public function getBooks()
    {
        $books = Book::orderBy('created_at', 'desc')->get();
        return response()->json(['success' => true, 'books' => $books]);
    }

    // ✅ Detail buku by id
    public function getBookDetail($id)
    {
        $book = Book::find($id);
        if ($book) {
            return response()->json(['success' => true, 'book' => $book]);
        }
        return response()->json(['success' => false, 'message' => 'Buku tidak ditemukan'], 404);
    }

    // ✅ Filter buku (by genre, tipe, sort, tag)
    public function filterBooks(Request $request)
    {
        $query = Book::query();

        if ($request->filled('genre')) {
            $query->where('genre', $request->genre);
        }
        if ($request->filled('tipe')) {
            $query->where('tipe', $request->tipe);
        }
        if ($request->filled('tag')) {
            $query->where('tags', 'like', '%' . $request->tag . '%');
        }

        if ($request->filled('sort') && $request->sort == 'rating') {
            $query->orderBy('rating', 'desc');
        } elseif ($request->filled('sort') && $request->sort == 'views') {
            $query->orderBy('views', 'desc');
        } else {
            $query->orderBy('created_at', 'desc');
        }

        $books = $query->get();
        return response()->json(['success' => true, 'books' => $books]);
    }

    // Tambah buku ke favorit user
public function addFavorite(Request $request)
{
    $validated = $request->validate([
        'id_user' => 'required|integer',
        'id_buku' => 'required|integer',
    ]);

    $exists = \DB::table('buku_favorit_user')
                ->where('id_user', $validated['id_user'])
                ->where('id_buku', $validated['id_buku'])
                ->first();

    if ($exists) {
        return response()->json(['success' => false, 'message' => 'Sudah jadi favorit']);
    }

    \DB::table('buku_favorit_user')->insert([
        'id_user' => $validated['id_user'],
        'id_buku' => $validated['id_buku'],
        'favorited_at' => now(),
    ]);

    return response()->json(['success' => true, 'message' => 'Berhasil ditambahkan ke favorit']);
}

// Lihat daftar buku favorit user
public function getFavorites($id_user)
{
    $favorites = \DB::table('buku_favorit_user')
        ->join('books', 'books.id_buku', '=', 'buku_favorit_user.id_buku')
        ->where('id_user', $id_user)
        ->select('books.*')
        ->get();

    return response()->json(['success' => true, 'books' => $favorites]);
}


    // ✅ Tambah buku baru
    public function addBook(Request $request)
    {
        $validated = $request->validate([
            'judul'      => 'required|string|max:255',
            'id_penulis' => 'required|integer',
            'deskripsi'  => 'nullable|string',
            'genre'      => 'nullable|string|max:100',
            'tipe'       => 'nullable|string|max:50',
            'rating'     => 'nullable|numeric|min:0|max:5',
            'views'      => 'nullable|integer|min:0',
            'tags'       => 'nullable|string|max:255',
            'image'      => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        try {
            if ($request->hasFile('image')) {
                $file = $request->file('image');
                $filename = time() . '_' . $file->getClientOriginalName();
                $file->storeAs('public/buku_images', $filename);
                $validated['image'] = $filename;
            }

            $book = Book::create($validated);

            return response()->json(['success' => true, 'message' => 'Buku berhasil ditambahkan', 'book' => $book]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => 'Gagal tambah buku: ' . $e->getMessage()]);
        }
    }

    // ✅ Update buku
    public function updateBook(Request $request)
    {
        if (!$request->id_buku) {
            return response()->json(['success' => false, 'message' => 'id_buku wajib diisi']);
        }

        $book = Book::find($request->id_buku);
        if (!$book) {
            return response()->json(['success' => false, 'message' => 'Buku tidak ditemukan']);
        }

        $validated = $request->validate([
            'judul'      => 'required|string|max:255',
            'id_penulis' => 'required|integer',
            'deskripsi'  => 'nullable|string',
            'genre'      => 'nullable|string|max:100',
            'tipe'       => 'nullable|string|max:50',
            'rating'     => 'nullable|numeric|min:0|max:5',
            'views'      => 'nullable|integer|min:0',
            'tags'       => 'nullable|string|max:255',
            'image'      => 'nullable|image|mimes:jpeg,png,jpg|max:2048',
        ]);

        try {
            if ($request->hasFile('image')) {
                if ($book->image) {
                    Storage::delete('public/buku_images/' . $book->image);
                }

                $file = $request->file('image');
                $filename = time() . '_' . $file->getClientOriginalName();
                $file->storeAs('public/buku_images', $filename);
                $validated['image'] = $filename;
            }

            $book->update($validated);

            return response()->json(['success' => true, 'message' => 'Buku berhasil diperbarui', 'book' => $book]);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => 'Gagal update buku: ' . $e->getMessage()]);
        }
    }

    // ✅ Buku by penulis
    public function getBooksByAuthor($id_penulis)
    {
        $books = Book::where('id_penulis', $id_penulis)->get();
        return response()->json(['success' => true, 'books' => $books]);
    }

    // ✅ Hapus buku
    public function deleteBook(Request $request)
    {
        if (!$request->id_buku) {
            return response()->json(['success' => false, 'message' => 'id_buku wajib diisi']);
        }

        $book = Book::find($request->id_buku);
        if (!$book) {
            return response()->json(['success' => false, 'message' => 'Buku tidak ditemukan']);
        }

        try {
            if ($book->image) {
                Storage::delete('public/buku_images/' . $book->image);
            }
            $book->delete();

            return response()->json(['success' => true, 'message' => 'Buku berhasil dihapus']);
        } catch (\Exception $e) {
            return response()->json(['success' => false, 'message' => 'Gagal hapus buku: ' . $e->getMessage()]);
        }
    }
}
