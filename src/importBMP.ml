(* importBMP filename
 *
 * where filename represents the path towards a 24bits bitmap image *
 *       with or without specifying the extension                   *)

let nom_sans_extension nom ext =
  let n = string_length nom
  and n' = string_length ext in
  if n > n' && eq_string ("." ^ ext) (sub_string nom (n-n'-1) (n'+1)) then
    sub_string nom 0 (n-n'-1)
  else
    nom
;;

let int4bytes fichier debut =
	seek_in fichier debut;
	let a = input_byte fichier in
	let b = input_byte fichier in
	let c = input_byte fichier in
	let d = input_byte fichier in
	a + 256 * b + 256 * 256 * c + 256 * 256 * 256 * d
;;

let int3bytes fichier =
	let a = input_byte fichier in
	let b = input_byte fichier in
	let c = input_byte fichier in
	a + 256 * b + 256 * 256 * c
;;

let sauteBytes fichier nb =
	for i = 1 to nb do
		let a = input_byte fichier in ();
	done
;;

let importBMP fichier_bmp =
	let nom = nom_sans_extension fichier_bmp "bmp" in
	let fichier = open_in  (nom ^ ".bmp") in
	
	(* 1er caractère : seek_in canal_in 0; *)
	let taille_fichier = int4bytes fichier 2 in
	
	let position_image = int4bytes fichier 10 in
	let w = int4bytes fichier 18 in
	let h = int4bytes fichier 22 in
	let padding = w mod 4 in
	
	print_string "w = ";
	print_int w;
	print_string " , h = ";
	print_int h;
	print_string " , padding = ";
	print_int padding;
	
	seek_in fichier position_image;
	let image = make_matrix h w 0 in
    	for i = 0 to h-1 do
        	for j = 0 to w-1 do
            		image.(i).(j) <- int3bytes fichier;
        	done;
		sauteBytes fichier padding;
    	done;
	image
;;



