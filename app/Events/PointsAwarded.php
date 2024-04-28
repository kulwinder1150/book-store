<?php

namespace App\Events;

use App\Models\User;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class PointsAwarded
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public User $user;
    public $points;

    /**
     * Create a new event instance.
     */
    public function __construct(User $user, $points)
    {
        $this->user = $user;
        $this->points = $points;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, Channel>
     */
    public function broadcastOn(): array
    {
        return [
            new PrivateChannel('award-points'),
        ];
    }
}
