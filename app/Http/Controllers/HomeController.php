<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use Inertia\Response;

class HomeController extends Controller {
    public function index(): Response {
        return Inertia::render( 'Welcome', [
            'canLogin'    => Route::has( 'login' ),
            'canRegister' => Route::has( 'register' ),
            'points' => $this->getPoints(),
            ...$this->common_props,
        ] );
    }
}
