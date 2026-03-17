#
# Makefile
# Mark T. Chapman
# 

include ../../config.mk

LIBTARGET=../lib/libgndct.a
LIBOBJS= rawdict.o lexword.o dictrec.o typerec.o sentmdl.o sentnode.o 
LIBDEPEND=$(LIBTARGET) ../../mtc++/lib/libmtc++.a

CPPFLAGS+=-I../include -I../../mtc++/include
CXXFLAGS+=$(CDEBUG)
LDLIBS+=-L../../mtc++/lib -L../lib -lmtc++ -lgndct   

SRCS=dct2mstr.cc rawdict.cc genmodel.cc lexword.cc dictrec.cc typerec.cc sentmdl.cc sentnode.cc txt2dct.cc listword.cc sortdct.cc

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<


all: $(LIBTARGET) dct2mstr genmodel txt2dct listword sortdct 

install: all
	@$(MKDIR_P) ../../bin
	$(INSTALL_PROGRAM) dct2mstr ../../bin/dct2mstr
	$(INSTALL_PROGRAM) genmodel ../../bin/genmodel
	$(INSTALL_PROGRAM) listword ../../bin/listword
	$(INSTALL_PROGRAM) sortdct ../../bin/sortdct
	$(INSTALL_PROGRAM) txt2dct ../../bin/txt2dct
	-$(STRIP) ../../bin/dct2mstr ../../bin/genmodel ../../bin/listword ../../bin/sortdct ../../bin/txt2dct


depend:
	$(MAKEDEPEND) -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f *.o $(LIBTARGET) dct2mstr genmodel txt2dct listword sortdct txt2dct *.core 
	rm -f ../bin/dct2mstr ../bin/genmodel ../bin/listword ../bin/sortdct ../../bin/dct2mstr ../../bin/genmodel ../../bin/listword ../../bin/sortdct ../bin/txt2dct ../../bin/txt2dct

master: dct2mstr
	./dct2mstr

$(LIBTARGET): ../lib $(LIBOBJS)
	$(AR) -rc $(LIBTARGET) $(LIBOBJS)
	$(RANLIB) $(LIBTARGET)

../lib:
	$(MKDIR_P) $@

dct2mstr: dct2mstr.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o dct2mstr dct2mstr.o $(LDLIBS) 

listword: listword.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o listword listword.o $(LDLIBS)

sortdct: sortdct.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o sortdct sortdct.o $(LDLIBS)

txt2dct: txt2dct.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o txt2dct txt2dct.o $(LDLIBS)

genmodel: genmodel.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o genmodel genmodel.o $(LDLIBS)

lexword.cc: lexword.l
	rm -f lex.yy.c
	$(LEX) lexword.l 
	sed s/yy/zz/g < lex.yy.c | sed s/YY/ZZ/g > lexword.cc
	rm -f lex.yy.c
