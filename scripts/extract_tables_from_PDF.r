
dir.create("../results/png_case_details/")
files_pdf <- list.files("../results/pdf_case_details/", full.names = T)

# convert pdf to png
## brew install imagemagick
idx <- which(grepl("20210729", files_pdf)) # offcial vaccination records after 20210729
id_pdf <- seq(idx, length(files_pdf))

sapply(id_pdf, function(x){
	print(x)
	out_path <- gsub("pdf_case_details", "png_case_details", files_pdf[x])
	system(paste0("convert -strip -density 600 ", files_pdf[x], " -quality 70 ", out_path, ".jpg"))
})

# OCR of pngs to excel tables
## using paddleOCR: https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.2/ppstructure/README_ch.md
dir.create("../results/xlsx_case_details/")
files_png <- list.files("../results/png_case_details/", full.names = T)

sapply(files_png, function(x){
	print(x)
	system(paste0("paddleocr --image_dir=", x, " --type=structure --use_gpu=False --lang=chinese_cht --output ../results/xlsx_case_details/"))
})

dir.create("../results/xlsx_case_details/rename/")
files_xlsx <- list.files("../results/xlsx_case_details/", "xlsx", full.names = T, recursive = T)
sapply(files_xlsx, function(x){
	name_new <- gsub("\\[.+\\]", "", x)
	name_new <- gsub("/.", ".", name_new, fixed = T)
	name_new <- strsplit(name_new, "/", fixed = T)[[1]]
	name_new[4] <- "rename"
	name_new <- paste(name_new, collapse = "/")
	file.copy(x, name_new)
	file.remove(x)
})
