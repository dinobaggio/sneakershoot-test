## App sneakershoot untuk test

project ini menggunakan arsitektur stacked, arsitektur tersebut bersumber [dari sini](https://www.filledstacks.com/post/flutter-and-provider-architecture-using-stacked/)  

saya menggunakan arsitektur tersebut dikarenakan struktur folder lebih tertata rapih, dan juga kodingan lebih rapih karena logic dan view terpisah.  

services yang digunakan pada project ini ialah menggunakan RestAPI [JSON placeholder](https://jsonplaceholder.typicode.com) 

project ini terdiri dari :
1. Menampilkan daftar list post `GET: /posts`
2. Menampilkan detail post `GET: /posts/${id}`
3. Mengedit post `PUT: /posts/${id}`
4. Infinity scroll untuk list post, panjang list tergantung dari panjang post pada services api

untuk edit post saya buat manipulasi agar data tetap terubah, dikarenakan services JSON placeholder tidak merubah data walaupun sudah menembak endpoint yang tersedia, akan tetapi tetap menembak endpoint edit post walaupun tidak berefek sama sekali.  

## Requirement

SDK flutter menggunakan versi: `1.17.3`