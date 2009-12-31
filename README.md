camllight-read-save-bitmap
==========================

Project
-------

This project is divided into two Caml-Light files:
1. importBMP.ml
2. exportBMP.ml

The data-structure used is a rectangular matrix containing intergers. Each element in the matrix represents a pixel which color is 0xRRGGBB (in hexadecimal notation).

Sample code for opening 24-bit images:
```
include "../src/importBMP.ml";;
let image_in = importBMP "in.bmp" in
(* ...your code... *)
```

Sample code for saving 24-bit images:
```
include "../src/exportBMP.ml";;
let image_out = make_matrix x y 0 in
(* ...your code... *)
exportBMP image_out "out.bmp";;
```

Possible Modifications
----------------------

Support of other kind of bitmaps:
- 32-bit images
- indexed images


Other projects
--------------
[My Portfolio](http://portfolio.dubien.me/)
