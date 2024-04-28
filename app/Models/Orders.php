<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

/**
 * @mixin IdeHelperOrders
 */
class Orders extends Model {
    use HasFactory;

    protected $fillable = [
        'user_id',
        'total_amount',
        'points_deducted',
        'cancelled',
    ];

    public function user(): BelongsTo {
        return $this->belongsTo( User::class );
    }

    public function book(): BelongsTo {
        return $this->belongsTo( Books::class, 'book_id' );
    }
}
