(* Sample example *)
include "../src/importBMP.ml";;
include "../src/exportBMP.ml";;

(* Import BMP file *)
let image_in = importBMP "in.bmp" in
(* Retrive dimensions *)
let x = vect_length image_in and y = vect_length image_in.(0) in

(* Create empty in-memory BMP file *)
let image_out = make_matrix x y 0 in
(* Initialise pixels of image_out *)
for i=0 to x-1 do
        for j=0 to y-1 do
                let cPx = image_in.(i).(j) in
                let r = cPx / 65536 and g = (cPx mod 65536)/256 and b = cPx mod 256 in
                image_out.(i).(j) <- (255-r) * 65536 + (255-g)*256 + (255-b);
        done;
done;
(* Export image_out to 24-bit BMP file *)
exportBMP image_out "out.bmp";;

