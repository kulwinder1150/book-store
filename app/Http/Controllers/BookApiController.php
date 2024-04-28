<?php

namespace App\Http\Controllers;

use App\Models\Books;
use App\Models\Tags;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Storage;
use Str;
use Throwable;

class BookApiController extends Controller {

    /**
     * Display a listing of the resource.
     */
    public function index( Request $request ): JsonResponse {

        $builder = Books::query();

        if ( $request->has( 'sortBy' ) ) {
            $builder = $builder->orderBy(
                $request->get( 'sortBy' ),
                $request->get( 'sortOrder', 'desc' )
            );
        }

        if ( $request->has( 'search' ) ) {
            $search  = Str::lower( $request->get( 'search' ) );
            $builder = $builder->where( function ( $query ) use ( $search ) {
                $query->whereRaw( 'LOWER(title) LIKE ?', [ "%$search%" ] )
                      ->orWhereRaw( 'LOWER(writer) LIKE ?', [ "%$search%" ] );
            } );
        }

        if ( $request->has( 'tags' ) ) {
            $tags_string = (string) $request->get( 'tags' );
            $tags_string = Str::trim( $tags_string );
            if ( ! empty( $tags_string ) ) {
                $tags    = explode( ',', $tags_string );
                $builder = $builder->whereHas( 'tags', function ( $query ) use ( $tags ) {
                    $query->whereIn( 'slug', $tags );
                } );
            }
        }

        if ( $request->has( 'page' ) ) {
            $perPage = $request->get( 'perPage', 10 );
            $books   = $builder->paginate( $perPage, [ '*' ], 'page', $request->get( 'page' ) );
        } else {
            $books = $builder->get();
        }

        /** @var Books $book */
        foreach ( $books as $book ) {
            if ( file_exists( Storage::disk( 'public' )->path( $book->cover_image ) ) ) {
                $book['cover_image'] = Storage::disk( 'public' )->url( $book->cover_image );
            } else {
                $book['cover_image'] = 'https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg';
            }
            $book['tags'] = $book->tags()->implode( 'name', ', ' );
        }

        return response()->json( $books );
    }

    /**
     * Store a newly created resource in storage.
     * @throws Throwable
     */
    public function store( Request $request ): JsonResponse {

        $request->validate( [
            'title'       => 'required|string|max:255|unique:books',
            'writer'      => 'required|string|max:255',
            'cover_image' => 'required|file|image|mimes:jpeg,png,jpg|max:1024',
            'point'       => 'required|decimal:0,2',
            'tags'        => 'required|string|max:255',
        ] );

        $title       = $request->get( 'title' );
        $writer      = $request->get( 'writer' );
        $cover_image = $request->file( 'cover_image' );
        $point       = $request->get( 'point' );
        $tags        = $request->get( 'tags' );

        $tagsArray = explode( ',', $tags );

        $book              = new Books();
        $book->title       = $title;
        $book->writer      = $writer;
        $book->cover_image = $cover_image->storeAs(
            'images',
            time() . '-' . $cover_image->getClientOriginalName(),
            'public'
        );
        $book->point       = number_format( $point, 2, '.', '' );
        $book->saveOrFail();

        foreach ( $tagsArray as $tagName ) {
            $tag = Tags::firstOrCreate( [ 'name' => Str::trim( $tagName ) ] );
            $book->tags()->attach( $tag->id );
        }

        return response()->json( [
            'message' => 'Book Added',
        ], 201 );
    }

    /**
     * Display the specified resource.
     */
    public function show( string $id ): JsonResponse {

        $book = Books::find( $id );

        if ( file_exists( Storage::disk( 'public' )->path( $book->cover_image ) ) ) {
            $book['cover_image'] = Storage::disk( 'public' )->url( $book->cover_image );
        } else {
            $book['cover_image'] = 'https://images-na.ssl-images-amazon.com/images/I/51Ga5GuElyL._AC_SX184_.jpg';
        }

        $book['tags'] = $book->tags()->implode( 'name', ', ' );

        return response()->json( $book );
    }

    /**
     * Update the specified resource in storage.
     * @throws Throwable
     */
    public function update( Request $request, string $id ): JsonResponse {
        if ( Books::where( 'id', $id )->exists() ) {

            $request->validate( [
                'title'  => 'required|string|max:255|unique:books,title,' . $id,
                'writer' => 'required|string|max:255',
                'point'  => 'required|decimal:0,2',
                'tags'   => 'required|string|max:255',
            ] );

            $title  = $request->get( 'title' );
            $writer = $request->get( 'writer' );
            $point  = $request->get( 'point' );
            $tags   = $request->get( 'tags' );

            $tagsArray = explode( ',', $tags );

            $book         = Books::find( $id );
            $book->title  = $title;
            $book->writer = $writer;

            if ( $request->hasFile( 'cover_image' ) ) {
                $request->validate( [
                    'cover_image' => 'required|file|image|mimes:jpeg,png,jpg|max:1024',
                ] );
                $cover_image = $request->file( 'cover_image' );
                Storage::disk( 'public' )->delete( $book->cover_image );
                $book->cover_image = $cover_image->storeAs(
                    'images',
                    time() . '-' . $cover_image->getClientOriginalName(),
                    'public'
                );
            }

            $book->point = number_format( $point, 2, '.', '' );
            $book->saveOrFail();

            $book->tags()->detach();

            foreach ( $tagsArray as $tagName ) {
                $tag = Tags::firstOrCreate( [ 'name' => Str::trim( $tagName ) ] );
                $book->tags()->attach( $tag->id );
            }

            return response()->json( [
                'message' => 'Book Updated',
            ], 200 );
        } else {
            return response()->json( [
                'message' => 'Book not found',
            ], 404 );
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy( string $id ): JsonResponse {
        if ( Books::where( 'id', $id )->exists() ) {
            $book = Books::find( $id );
            $book->delete();

            Storage::disk( 'public' )->delete( $book->cover_image );

            return response()->json( [
                'message' => 'Book Deleted',
            ], 202 );
        } else {
            return response()->json( [
                'message' => 'Book not found',
            ], 404 );
        }
    }
}
