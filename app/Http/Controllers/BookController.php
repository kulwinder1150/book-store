<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class BookController extends Controller
{
    public function index(): Response {
        return Inertia::render( 'Books/Index', [
            ...$this->common_props,
            'points' => $this->getPoints(),
        ] );
    }

    public function show(Request $request, $id): Response {
        return Inertia::render( 'Books/Show', [
            ...$this->common_props,
            'id' => $id,
            'points' => $this->getPoints(),
        ] );
    }

    public function store(): Response {
        return Inertia::render( 'Books/New', [
            ...$this->common_props,
            'points' => $this->getPoints(),
        ] );
    }

    public function update(Request $request, $id): Response {
        return Inertia::render( 'Books/Edit', [
            ...$this->common_props,
            'id' => $id,
            'points' => $this->getPoints(),
        ] );
    }
}
