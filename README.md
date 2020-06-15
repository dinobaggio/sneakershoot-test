## App sneakershoot untuk test

project ini menggunakan arsitektur stacked, arsitektur tersebut bersumber [dari sini](https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/)  

saya menggunakan arsitektur ini karena struktur folder lebih tertata rapih, dan juga kodingan lebih rapih karena logic dan view terpisah.  

services yang digunakan pada project ini ialah menggunakan RestAPI [JSON placeholder](https://jsonplaceholder.typicode.com) 

project ini terdiri dari :
1. Menampilkan daftar list post `GET: /posts`
2. Menampilkan detail post `GET: /posts/${id}`
3. Mengedit post `PUT: /posts/${id}`

untuk edit post saya buat manipulasi agar data tetap terubah, dikarenakan services JSON placeholder tidak merubah data walaupun sudah menembak endpoint yang tersedia

## Installation
ada penambahan tahapan untuk instalasinya karena saya menggunakan library `build_runner` untuk menggenerate services pada kodingan, seperti generate route agar lebih mudah dalam pengimplementasian.

1. cmd: `flutter pub get`
2. cmd: `flutter pub run build_runner build`
3. done tinggal jalankan emulator atau sejenisnya.  

## Requirement

SDK flutter menggunakan versi: `1.17.3`