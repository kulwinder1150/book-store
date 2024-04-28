<?php

use App\Http\Controllers\BookController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get( '/', [ HomeController::class, 'index' ] )->name( 'home' );

Route::get( '/dashboard', [ DashboardController::class, 'index' ] )
     ->middleware( [ 'auth', 'verified' ] )->name( 'dashboard' );

// Books
Route::get( '/books', [ BookController::class, 'index' ] )->middleware( [ 'auth', 'verified' ] )->name( 'books' );
Route::get( '/books/{id}', [ BookController::class, 'show' ] )->middleware( [ 'auth', 'verified' ] )->name( 'book-show' );
Route::get( '/books-new', [ BookController::class, 'store' ] )->middleware( [ 'auth', 'verified' ] )->name( 'book-new' );
Route::get( '/books/{id}/edit', [ BookController::class, 'update' ] )->middleware( [ 'auth', 'verified' ] )->name( 'book-edit' );

// list-of-buy
Route::get('/list-of-buy', [OrderController::class,'listOfBuy'])->middleware( [ 'auth', 'verified' ] )->name('list-of-buy');

Route::middleware( 'auth' )->group( function () {
    Route::get( '/profile', [ ProfileController::class, 'edit' ] )->name( 'profile.edit' );
    Route::patch( '/profile', [ ProfileController::class, 'update' ] )->name( 'profile.update' );
    Route::delete( '/profile', [ ProfileController::class, 'destroy' ] )->name( 'profile.destroy' );
} );

require __DIR__ . '/auth.php';
