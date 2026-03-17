# Shared build defaults for the Nicetext tree.
#
# The code still targets the legacy C++98 implementation, but centralizing
# tool and flag selection makes it easier to build with current compilers and
# package managers.

CXX ?= c++
CC ?= cc
AR ?= ar
RANLIB ?= ranlib
LEX ?= flex -f
YACC ?= yacc -d

CPPFLAGS ?=
CXXFLAGS ?= -std=gnu++98
CFLAGS ?=
LDFLAGS ?=
LDLIBS ?=
