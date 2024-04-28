<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class TokenController extends Controller {

    /**
     * @throws ValidationException
     */
    public function create( Request $request ): string {

        $request->validate( [
            'email'    => 'required|email',
            'password' => 'required',
        ] );

        $user = User::where( 'email', $request->email )->first();

        if ( ! $user || ! Hash::check( $request->password, $user->password ) ) {
            throw ValidationException::withMessages( [
                'email' => [ 'The provided credentials are incorrect.' ],
            ] );
        }

        return $user->createToken( 'api' )->plainTextToken;
    }
}
