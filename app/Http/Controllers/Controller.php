<?php

namespace App\Http\Controllers;

use Auth;
use Illuminate\Foundation\Application;

abstract class Controller {

    protected function getPoints(): string {
        return number_format( Auth::user()->points->points ?? 0, 2 );
    }

    protected array $common_props = [
        'laravelVersion' => Application::VERSION,
        'phpVersion'     => PHP_VERSION,
    ];
}
