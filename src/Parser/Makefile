
HaCWB_LIB = ../HaCWB_lib/

parser: TrabLexer.hs TrabParser.hs Main.hs 
	ghc -o parser -i$(HaCWB_LIB) -I$(HaCWB_LIB) --make Main.hs

TrabLexer.hs:  TrabLexer.x 
	alex TrabLexer.x

TrabParser.hs: TrabParser.y 
	happy -g TrabParser.y  # -g e para gerar codigo proprio para o GHC

clean:
	rm -f *.hi *~ *.o parser TrabLexer.hs TrabParser.hs 	
