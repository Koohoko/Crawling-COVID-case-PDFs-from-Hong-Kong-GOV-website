# Crawling COVID case PDFs from Hong Kong GOV website

---

# Collecting PDFs
`./scripts/crawl_case_pdfs.r`:
The Hong Kong government routinely release COVID-19 confirmed case details in PDF format on their websites (e.g. the [attachment](https://gia.info.gov.hk/general/202004/06/P2020040600581_339292_1_1586174015449.pdf) from [this link](https://www.info.gov.hk/gia/general/202004/06/P2020040600581.htm)).
Some of the information were provided exclusively in these PDFs. Hereby I provide a tiny R script for downloading all these PDF attachments from different news reports over the two past years.

# Coverting PDF to Excel tables using paddleOCR
`./scripts/extract_tables_from_PDF.r`:
To facilitate downstream data wrangling with colleagues, we converted the PDF tables into Excel xlsx files using [an open-source OCR software](https://github.com/PaddlePaddle/PaddleOCR/). Specifically, we tried to use the trained model with traditional Chinese (`--lang=chinese_cht`).

