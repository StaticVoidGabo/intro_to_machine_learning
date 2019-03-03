.PHONY: delete_markdowns delete_all_images move_images

images: markdowns_and_images delete_markdowns move_images

markdowns_and_images: jupyter2markdown

FILES = 2.1.regresion-lineal\
	2.2.regresion_lineal_multiple

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
	rm $(MD_FILES)

delete_all_images:
	rm -rf $(MD_IMAGES_DIRS)
	rm -rf $(BOOK_IMAGES_DIRS)
