<?php

namespace App\Console\Commands;

use Carbon\Carbon;
use File;
use Illuminate\Console\Command;
use Symfony\Component\Process\Process;

class DatabaseBackup extends Command {
    protected Process $process;

    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'database:backup';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Database backup';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct() {
        parent::__construct();

        $path = storage_path( '/' );
        $Ymd  = Carbon::now()->format( 'Y-m-d' );

        File::ensureDirectoryExists( $path );

        $this->process = Process::fromShellCommandline( sprintf(
            "pg_dump \"host=%s port=%s dbname=%s user=%s password=%s\" > %s",
            env( 'DB_HOST' ),
            env( 'DB_PORT' ),
            env( 'DB_DATABASE' ),
            env( 'DB_USERNAME' ),
            env( 'DB_PASSWORD' ),
            "$path/$Ymd.sql"
        ) );
    }

    /**
     * Execute the console command.
     */
    public function handle(): void {

        $this->info( 'The backup has been started' );
        $this->process->mustRun();
        $this->info( 'The backup has been proceed successfully.' );
    }
}
