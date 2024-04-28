<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Str;

/**
 * @mixin IdeHelperTags
 */
class Tags extends Model {
    use HasFactory;

    protected $fillable = [ 'slug', 'name' ];

    protected static function boot(): void {
        parent::boot();
        static::saving( function ( $tag ) {
            $tag->slug = Str::slug( $tag->name );
        } );
    }

    public function books(): BelongsToMany {
        return $this->belongsToMany( Books::class );
    }
}
