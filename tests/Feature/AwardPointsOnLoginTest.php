<?php

use App\Models\User;
use App\Events\PointsAwarded;
use Illuminate\Auth\Events\Login;
use Illuminate\Support\Facades\Event;

it('awards points to new customer on login', function () {
    Event::fake();

    // Create a new user
    $user = User::factory()->create();

    // Simulate user login event
    event(new Login('web', $user, false));

    // Assert that points are awarded to the user
    expect($user->points)->toBe(100);

    // Verify that the PointsAwarded event is dispatched
    Event::assertDispatched(PointsAwarded::class, function ($event) use ($user) {
        return $event->user->id === $user->id && $event->points === 100;
    });
});
