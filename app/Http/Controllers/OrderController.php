<?php

namespace App\Http\Controllers;

use Inertia\Inertia;
use Inertia\Response;

class OrderController extends Controller {

    public function listOfBuy(): Response {
        return Inertia::render( 'Orders/List', [
            ...$this->common_props,
            'points' => $this->getPoints(),
        ] );
    }
}
