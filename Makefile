
HaCWB_SOURCE = ./src/HaCWB_tool/
HaCWB_LIB = ./src/HaCWB_lib/
HaCWB_TARGET = ./src/bin/hacwb
PARSER_SOURCE = ./src/Parser/

hacwb: 
	ghc --make                               \
            -I$(HaCWB_LIB) -i$(HaCWB_LIB)        \
            -I$(PARSER_SOURCE) -i$(PARSER_SOURCE)        \
            -package util                        \
            -package lang                        \
            -O2                                  \
            -fglasgow-exts                       \
            $(HaCWB_SOURCE)hacwb.hs                \
            -o $(HaCWB_TARGET)

parser:
	cd src/Parser/	&& make	&&  cd ../../

all:
	make hacwb && make parser

clean:
	rm $(HaCWB_SOURCE)*.o                    \
           $(HaCWB_SOURCE)*.hi                   \
           $(HaCWB_LIB)*.hi                      \
           $(HaCWB_LIB)*.o                       \
           $(HaCWB_TARGET)                       \
           $(PARSER_SOURCE)*.o                   \
           $(PARSER_SOURCE)*.hi                  \
           

