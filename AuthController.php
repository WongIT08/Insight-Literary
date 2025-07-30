<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Admin;

class AuthController extends Controller
{
    public function loginUser(Request $request) {
        $user = User::where('username', $request->username)
                    ->where('password', $request->password)
                    ->first();
        if ($user) {
            return response()->json(['success' => true, 'user' => $user]);
        }
        return response()->json(['success' => false, 'message' => 'Username atau password salah']);
    }

   public function register(Request $request) {
    try {
        $user = \App\Models\User::create([
            'username' => $request->username,
            'password' => $request->password, // ⚠️ password *wajib* di-hash!
            'fullname' => $request->fullname,
            'image' => '' // default kosong
        ]);
        return response()->json(['success' => true, 'message' => 'User berhasil didaftarkan', 'user' => $user]);
    } catch (\Exception $e) {
        return response()->json(['success' => false, 'message' => 'Gagal register: '.$e->getMessage()]);
    }
}



    public function loginAdmin(Request $request) {
        $admin = Admin::where('username', $request->username)
                      ->where('password', $request->password)
                      ->first();
        if ($admin) {
            return response()->json(['success' => true, 'admin' => $admin]);
        }
        return response()->json(['success' => false, 'message' => 'Username atau password salah']);
    }

// Get profile by id_user
public function getProfile($id_user)
{
    $user = User::where('id_user', $id_user)->first();

    if ($user) {
        return response()->json([
            'success' => true,
            'data' => $user
        ]);
    } else {
        return response()->json([
            'success' => false,
            'message' => 'User tidak ditemukan'
        ], 404);
    }
}

// Update profile
public function updateProfile(Request $request)
{
    $validated = $request->validate([
        'id_user'    => 'required|integer|exists:users,id_user',
        'fullname'   => 'required|string|max:255',
        'bio'        => 'nullable|string',
        'birth_date' => 'nullable|date',
        'gender'     => 'nullable|in:L,P',
        'location'   => 'nullable|string|max:255',
        'image'      => 'nullable|image|mimes:jpeg,png,jpg|max:2048' // kalau ada upload foto
    ]);

    $user = User::find($validated['id_user']);

    $user->fullname   = $validated['fullname'];
    $user->bio        = $validated['bio'] ?? null;
    $user->birth_date = $validated['birth_date'] ?? null;
    $user->gender     = $validated['gender'] ?? null;
    $user->location   = $validated['location'] ?? null;

    // handle upload image
    if ($request->hasFile('image')) {
        $oldImage = $user->image; // simpan nama lama

        $image = $request->file('image');
        $filename = time().'_'.$image->getClientOriginalName();
        $image->move(public_path('uploads/profile'), $filename);
        $user->image = $filename;
    }
      // Hapus foto lama (jika ada)
        if ($oldImage && file_exists(public_path('uploads/profile/'.$oldImage))) {
        unlink(public_path('uploads/profile/'.$oldImage));
        }

        $user->image = $filename;
        
    $user->save();

    return response()->json([
        'success' => true,
        'message' => 'Profil berhasil diperbarui',
        'data'    => $user
    ]);
}

}