<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class UserController extends Controller
{
    public function updateProfile(Request $request)
    {
        // Validasi
        $validated = $request->validate([
            'id_user'    => 'required|integer|exists:users,id_user',
            'fullname'   => 'required|string|max:255',
            'bio'        => 'nullable|string',
            'birth_date' => 'nullable|date',
            'gender'     => 'nullable|in:L,P',
            'location'   => 'nullable|string|max:255',
            // 'image'   => 'nullable|image|mimes:jpeg,png,jpg|max:2048' // opsional
        ]);

        // Cari user
        $user = User::find($validated['id_user']);

        // Update field
        $user->fullname   = $validated['fullname'];
        $user->bio        = $validated['bio'] ?? null;
        $user->birth_date = $validated['birth_date'] ?? null;
        $user->gender     = $validated['gender'] ?? null;
        $user->location   = $validated['location'] ?? null;

        // Simpan perubahan
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Profil berhasil diperbarui!',
            'data'    => $user
        ]);
    }
}
