<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (!Schema::hasTable('penulis')) {
            Schema::create('penulis', function (Blueprint $table) {
                $table->increments('id_penulis'); // int auto_increment PK
                $table->string('nama_penulis', 255);
                $table->text('profil'); // NOT NULL
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('penulis');
    }
};
