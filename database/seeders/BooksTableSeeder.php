<?php

namespace Database\Seeders;

use App\Models\Books;
use App\Models\Tags;
use Faker\Factory as Faker;
use Illuminate\Database\Seeder;
use Str;

class BooksTableSeeder extends Seeder {

    public function getRandomArray($sourceArray, $length = 3): array {
        $randomArray = array();
        $sourceArrayCount = count($sourceArray);
        if ($length > $sourceArrayCount) {
            $length = $sourceArrayCount;
        }
        $keys = array_rand($sourceArray, $length);
        if (!is_array($keys)) {
            $keys = array($keys);
        }
        foreach ($keys as $key) {
            $randomArray[] = $sourceArray[$key];
        }
        return $randomArray;
    }

    /**
     * Run the database seeds.
     */
    public function run(): void {

        $faker = Faker::create();

        $array = [
            'fiction',
            'non-fiction',
            'science',
            'essay',
            'medical',
            'travel',
            'sports',
            'history',
            'comics'
        ];

        for ( $i = 0; $i < 100; $i ++ ) {
            $book = Books::create( [
                'title'       => $faker->sentence( 3 ),
                'writer'      => $faker->name,
                'cover_image' => 'https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg',
                'point'       => $faker->numberBetween( 1, 100 )
            ] );

            foreach ( $this->getRandomArray($array) as $tagName ) {
                $tag = Tags::firstOrCreate( [ 'name' => Str::trim( $tagName ) ] );
                $book->tags()->attach( $tag->id );
            }
        }
    }
}
