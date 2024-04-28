<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

/**
 * @mixin IdeHelperBooks
 */
class Books extends Model
{
    use HasFactory;

    protected $fillable = [ 'title', 'writer', 'cover_image', 'point' ];

    public function tags(): BelongsToMany {
        return $this->belongsToMany( Tags::class );
    }
}
