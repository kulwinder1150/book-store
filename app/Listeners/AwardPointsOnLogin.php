<?php

namespace App\Listeners;

use App\Events\PointsAwarded;
use App\Models\Point;
use Illuminate\Auth\Events\Login;

class AwardPointsOnLogin {
    /**
     * Create the event listener.
     */
    public function __construct() {
        //
    }

    /**
     * Handle the event.
     */
    public function handle( Login $event ): void {
        // Check if the user is a new customer
        if ( $event->user->isNewCustomer() ) {
            // Award points
            $points = 100;

            // Save points to the database
            Point::create( [
                'user_id' => $event->user->id,
                'points'  => $points
            ] );

            // Optionally, you can dispatch an event to perform additional actions
            event( new PointsAwarded( $event->user, $points ) );
        }
    }
}
