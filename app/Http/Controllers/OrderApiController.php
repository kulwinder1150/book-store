<?php

namespace App\Http\Controllers;

use App\Models\Books;
use App\Models\Orders;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Throwable;

class OrderApiController extends Controller {
    /**
     * Display a listing of the resource.
     */
    public function index( Request $request ): JsonResponse {

        $builder = Orders::query();

        if ( $request->has( 'sortBy' ) ) {
            $builder = $builder->orderBy(
                $request->get( 'sortBy' ),
                $request->get( 'sortOrder', 'desc' )
            );
        }

        if ( $request->has( 'user_id' ) ) {
            $builder = $builder->where( 'user_id', '=', $request->get( 'user_id' ) );
        }

        if ( $request->has( 'page' ) ) {
            $perPage = $request->get( 'perPage', 10 );
            $orders  = $builder->paginate( $perPage, [ '*' ], 'page', $request->get( 'page' ) );
        } else {
            $orders = $builder->get();
        }

        /** @var Orders $order */
        foreach ( $orders as $order ) {
            $order['date'] = $order->created_at->format( 'Y-m-d H:i:s' );
            $order['book'] = $order?->book?->get();
        }

        return response()->json( $orders );
    }

    /**
     * Store a newly created resource in storage.
     * @throws Throwable
     */
    public function store( Request $request ): JsonResponse {

        $request->validate( [
            'book_id' => 'required',
        ] );

        /** @var User $user */
        $user = $request->user();

        $bookId = (int) $request->get( 'book_id' );

        // Find the book
        $book = Books::findOrFail( $bookId );

        $points     = (float) $user->points->points;
        $bookPoints = (float) $book->point;

        // Check if user has enough points to purchase the book
        if ( $points >= $bookPoints ) {

            // Deduct points from user's wallet
            $points                 -= $bookPoints;
            $user->points->points   = $points;
            $order                  = new Orders();
            $order->user_id         = $user->id;
            $order->total_amount    = $points;
            $order->book_id         = $bookId;
            $order->points_deducted = $points;
            $order->cancelled       = false;
            $order->saveOrFail();
            $user->points->saveOrFail();

            return response()->json( [ 'message' => 'Book purchased successfully' ] );
        } else {
            return response()->json( [ 'error' => 'Insufficient points' ], 403 );
        }
    }

    /**
     * Display the specified resource.
     */
    public function show( string $id ): JsonResponse {
        $order = Orders::find( $id );

        return response()->json( $order );
    }

    /**
     * Update the specified resource in storage.
     * @throws Throwable
     */
    public function update( Request $request, string $id ): JsonResponse {
        if ( Orders::where( 'id', $id )->exists() ) {

            $order = Orders::find( $id );

            if ( $request->has( 'cancelled' ) ) {
                $order->cancelled = $request->get( 'cancelled' );
            }

            $order->saveOrFail();

            return response()->json( [
                'message' => 'Order Updated',
            ], 200 );
        } else {
            return response()->json( [
                'message' => 'Order not found',
            ], 404 );
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy( string $id ): JsonResponse {
        if ( Orders::where( 'id', $id )->exists() ) {
            $order = Orders::find( $id );
            $order->delete();

            return response()->json( [
                'message' => 'Order Deleted',
            ], 202 );
        } else {
            return response()->json( [
                'message' => 'Order not found',
            ], 404 );
        }
    }
}
