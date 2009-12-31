(* exportBMP image filename
 *
 * where image  gathers  the 3 components in a single  integer  value  such as *
 *       image.(i).(j) = r << 16 + g << 8 + b, is the color of the point (i,j) *
 * where filename is the file name with EXTENTION                              *
 * the resulting file is a 24bits bitmap                                       *)

let int_to_byte fichier nombre bytes =
	let tmp = ref nombre in
	for i=1 to bytes do
		output_byte fichier (!tmp mod 256);
		tmp := !tmp / 256;
	done
;;

let exportBMP grille nom =
	let w = vect_length grille and h = vect_length (grille.(0)) in
	let padding = h mod 4 in
	
	let taille_fichier = 50 + w*h*3 + w*padding in
	let offset_bitmap_data = 54 in
	
	(* Ouvre le fichier, écriture *)
	let fichier = open_out nom in
	
	(* BM *)
	output_string fichier "BM";	
	(* Taille du fichier 4 BYTES *)
	int_to_byte fichier taille_fichier 4;
	(* Application specific: 4 BYTES *)
	output_string fichier "ND69";
	(* Offset Bitmap data *)
	int_to_byte fichier offset_bitmap_data 4;
	(* The number of bytes in the header (from this point) *)
	int_to_byte fichier (offset_bitmap_data-14) 4;
	(* The width of the bitmap in pixels *)
	int_to_byte fichier h 4;
	(* The height of the bitmap in pixels *)
	int_to_byte fichier w 4;
	(* Number of color planes being used *)
	output_byte fichier 1;
	output_byte fichier 0;
	(* The number of bits/pixel *)
	output_byte fichier 24;
	output_byte fichier 0;
	(* No compression used *)
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	(* The size of the raw BMP data (after this header) *)
	int_to_byte fichier (taille_fichier-50) 4;
	(* The horizontal resolution of the image *)
	output_byte fichier 19;
	output_byte fichier 11;
	(* The vertical resolution of the image *)
	output_byte fichier 19;
	output_byte fichier 11;
	(* Number of colors in the palette *)
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	(* Means all colors are important *)
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	output_byte fichier 0;
	
	(* L'image *)
	for i = 0 to w-1 do
		for j = 0 to h-1 do
			int_to_byte fichier (grille.(i).(j)) 3;
		done;
		for j = 1 to padding do
			output_byte fichier 0;
		done;
	done;
	
	(* Ferme le fichier *)
	close_out fichier
;;

