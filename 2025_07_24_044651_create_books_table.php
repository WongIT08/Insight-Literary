<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        if (!Schema::hasTable('books')) {
            Schema::create('books', function (Blueprint $table) {
                $table->increments('id_buku'); // int auto_increment PK
                $table->string('judul', 255);
                $table->unsignedInteger('id_penulis'); // FK (int)
                $table->text('deskripsi');
                $table->enum('genre', [
                    'Fiksi','Non-Fiksi','Fantasi','Sains','Pendidikan',
                    'Sejarah','Biografi','Sci-Fi','Teka-Teki','Misteri',
                    'Filsafat','Religi'
                ]);
                $table->enum('tipe', ['Premium', 'BIasa']);
                $table->float('rating')->default(0);
                $table->integer('views')->default(0);
                $table->string('image')->nullable();
                $table->timestamps();

                // Optional: tambahkan FK constraint (jika ingin)
                // $table->foreign('id_penulis')->references('id_penulis')->on('penulis')->onDelete('cascade');
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('books');
    }
};
