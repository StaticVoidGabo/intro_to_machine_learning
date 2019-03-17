.PHONY: delete_markdowns delete_all_images move_images clean 

images: markdowns_and_images delete_markdowns move_images

clean: delete_markdowns delete_all_images

markdowns_and_images: jupyter2markdown

FILES = 2.1.regresion-lineal\
	2.2.regresion_lineal_multiple\
	2.3.efecto-underfitting-overfitting\
	3.1-2-regresion-logistica\
	4.2-3-tratamiento-de-valores-desconocidos-y-categoricas

MD_FILES = $(addsuffix .md, $(FILES))
MD_IMAGES_DIRS = $(addsuffix _files, $(FILES))
BOOK_BASE_DIR = notes_images/
BOOK_IMAGES_DIRS = $(addprefix $(BOOK_BASE_DIR), $(MD_IMAGES_DIRS))

jupyter2markdown: $(MD_FILES)

move_images: $(BOOK_IMAGES_DIRS)

$(BOOK_IMAGES_DIRS):
	mv $(@:notes_images/%=%) $(BOOK_BASE_DIR)

$(MD_FILES):
	jupyter nbconvert --to markdown $(@:.md=.ipynb)

delete_markdowns:
	rm -rf $(MD_FILES)

delete_all_images:
	echo 1
	rm -rf $(MD_IMAGES_DIRS)
	rm -rf $(BOOK_IMAGES_DIRS)
