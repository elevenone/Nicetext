#
# Makefile
# Mark T. Chapman
# 

include ../../config.mk

LIBTARGET=
LIBOBJS=
LIBDEPEND=$(LIBTARGET) ../../mtc++/lib/libmtc++.a

CPPFLAGS+=-I../include -I../../mtc++/include 
CXXFLAGS+=$(DEBUG)
LDLIBS+=-L../../mtc++/lib $(LEX_LIBS)

SRCS=impkimmo.cc impwbstr.cc impmsc.cc printint.cc

.cc.o:
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c -o $@ $<

impkimmo.o: CXXFLAGS += $(GENERATED_CXXFLAGS)
impmsc.o: CXXFLAGS += $(GENERATED_CXXFLAGS)
impwbstr.o: CXXFLAGS += $(GENERATED_CXXFLAGS)

all: $(LIBTARGET) impkimmo impwbstr impmsc printint  

install: all
	@$(MKDIR_P) $(TOP_BINDIR)
	$(INSTALL_PROGRAM) impkimmo $(TOP_BINDIR)/impkimmo
	$(INSTALL_PROGRAM) impwbstr $(TOP_BINDIR)/impwbstr
	$(INSTALL_PROGRAM) impmsc $(TOP_BINDIR)/impmsc
	$(INSTALL_PROGRAM) printint $(TOP_BINDIR)/printint
	-$(STRIP) $(TOP_BINDIR)/impkimmo $(TOP_BINDIR)/impwbstr $(TOP_BINDIR)/impmsc $(TOP_BINDIR)/printint

depend:
	$(MAKEDEPEND) -- $(CPPFLAGS) $(CXXFLAGS) -- $(SRCS)

clean:
	rm -f *.o impkimmo impwbstr impmsc printint $(LIBTARGET) 
	rm -f ../bin/impkimmo ../../bin/impkimmo
	rm -f ../bin/impwbstr ../../bin/impwbstr
	rm -f ../bin/impmsc ../../bin/impmsc
	rm -f ../bin/printint ../../bin/printint

impkimmo: impkimmo.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impkimmo impkimmo.o -lmtc++ $(LDLIBS)

impkimmo.cc: impkimmo.l impmsc.cc  
	rm -f lex.yy.c
	$(LEX) impkimmo.l 
	mv lex.yy.c impkimmo.cc

impmsc: impmsc.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impmsc impmsc.o $(LDLIBS)

impmsc.cc: impmsc.l impwbstr.cc  
	rm -f lex.yy.c
	$(LEX) impmsc.l 
	mv lex.yy.c impmsc.cc
	
impwbstr: impwbstr.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o impwbstr impwbstr.o $(LDLIBS)

impwbstr.cc: impwbstr.l 
	rm -f lex.yy.c
	$(LEX) impwbstr.l 
	mv lex.yy.c impwbstr.cc

printint: printint.o $(LIBDEPEND)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(LDFLAGS) -o printint printint.o $(LDLIBS)

# DO NOT DELETE
