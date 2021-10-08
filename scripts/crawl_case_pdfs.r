library(rvest)

link_search_rst <- "https://www.search.gov.hk/result?ui_lang=zh-hk&proxystylesheet=ogcio_home_adv_frontend&output=xml_no_dtd&ui_charset=utf-8&a_submit=false&query=%222019%E5%86%A0%E7%8B%80%E7%97%85%E6%AF%92%E7%97%85%E7%A2%BA%E8%A8%BA%E5%80%8B%E6%A1%88%22&ie=UTF-8&oe=UTF-8&site=gia_home&tpl_id=stdsearch&gp=0&gp0=gia_home&gp1=&p_size=30&num=30&doc_type=all&as_filetype=&as_q=&as_epq=2019%E5%86%A0%E7%8B%80%E7%97%85%E6%AF%92%E7%97%85%E7%A2%BA%E8%A8%BA%E5%80%8B%E6%A1%88&is_epq=&as_oq=&is_oq=&as_eq=&is_eq=&r_lang=&lr=&web=this&sw=1&txtonly=0&rwd=0&date_v=%23-1&date_last=%2330&s_date_year=2021&s_date_month=01&s_date_day=01&e_date_year=2021&e_date_month=10&e_date_day=08&last_mod=&sort=date%253AD%253AL%253Ad1&page="

num_pages <- seq(1, 20) # please increase the number if there is more resutls

sapply(num_pages, function(x){
	html_sr <- read_html(paste0(link_search_rst, x))
	newslinks <- html_nodes(html_sr, "div.link p a") %>% html_text()
	newslinks <- gsub("\n", "", newslinks, fixed=T)
	print("########################")
	print(x)
	print("########################")

	sapply(newslinks, function(y){
		html_news <- read_html(paste0("https://", y))
		node_attachment <- html_nodes(html_news, "div.mT10.pad10.resAttach")

		if(length(node_attachment)==0){return(NA)}
		url_pdf <- as.character(node_attachment)
		url_pdf <- strsplit(url_pdf, '\"', fixed=T)[[1]]
		url_pdf <- url_pdf[grepl("pdf", url_pdf)][1]
		system(paste0("wget ", url_pdf, " -nc -P ../results/pdf_case_details/"))
	})
	return(NA)
})

