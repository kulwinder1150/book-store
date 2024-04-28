<?php

use App\Http\Controllers\BookApiController;
use App\Http\Controllers\OrderApiController;
use App\Http\Controllers\TagApiController;
use App\Http\Controllers\TokenController;
use Illuminate\Support\Facades\Route;

// Books
Route::get( '/books', [ BookApiController::class, 'index' ] );
Route::get( '/books/{id}', [ BookApiController::class, 'show' ] );
Route::post( '/books', [ BookApiController::class, 'store' ] )->middleware( 'auth:sanctum' );
Route::put( '/books/{id}', [ BookApiController::class, 'update' ] )->middleware( 'auth:sanctum' );
Route::delete( '/books/{id}', [ BookApiController::class, 'destroy' ] )->middleware( 'auth:sanctum' );

// Orders
Route::get( '/orders', [ OrderApiController::class, 'index' ] )->middleware( 'auth:sanctum' );;
Route::get( '/orders/{id}', [ OrderApiController::class, 'show' ] )->middleware( 'auth:sanctum' );;
Route::post( '/orders', [ OrderApiController::class, 'store' ] )->middleware( 'auth:sanctum' );;
Route::put( '/orders/{id}', [ OrderApiController::class, 'update' ] )->middleware( 'auth:sanctum' );
Route::delete( '/orders/{id}', [ OrderApiController::class, 'destroy' ] )->middleware( 'auth:sanctum' );

// Tags
Route::get( '/tags', [ TagApiController::class, 'index' ] );

// Create token
Route::post( '/tokens/create', [ TokenController::class, 'create' ] );
