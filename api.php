<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\BookController;
use App\Http\Controllers\PenulisController;
use App\Http\Controllers\FavoriteController;
use App\Http\Controllers\AuthorController;

Route::post('/login/user', [AuthController::class, 'loginUser']);
Route::post('/login/admin', [AuthController::class, 'loginAdmin']);
Route::post('/register', [AuthController::class, 'register']);

Route::get('/books', [BookController::class, 'getBooks']);
Route::get('/book/{id}', [BookController::class, 'getBookDetail']);
Route::get('/books/filter', [BookController::class, 'filterBooks']);
Route::get('/books/author/{id_penulis}', [BookController::class, 'getBooksByAuthor']);
Route::post('/books/add', [BookController::class, 'addBook']);
Route::post('/books/update', [BookController::class, 'updateBook']);
Route::post('/books/delete', [BookController::class, 'deleteBook']);
Route::post('/books/upload-image', [BookController::class, 'uploadImage']);

Route::get('/penulis', [PenulisController::class, 'getPenulis']);
Route::get('/profile/{id_user}', [AuthController::class, 'getProfile']);
Route::post('/profile/update', [AuthController::class, 'updateProfile']);

Route::get('/authors', [AuthorController::class, 'getAllAuthors']);
Route::get('/author/{id}', [AuthorController::class, 'getAuthorDetail']);

// Favorite routes
Route::prefix('favorite')->group(function() {
    Route::post('/add', [FavoriteController::class, 'addFavorite']);
    Route::post('/remove', [FavoriteController::class, 'removeFavorite']);
    Route::get('/list/{user_id}', [FavoriteController::class, 'listFavoritesByUser']);
});
