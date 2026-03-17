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
MKDIR_P ?= mkdir -p
INSTALL ?= install
INSTALL_PROGRAM ?= $(INSTALL) -m 755
INSTALL_DATA ?= $(INSTALL) -m 644
STRIP ?= strip
MAKEDEPEND ?= makedepend
CURDIR_ABS ?= $(shell pwd)
ROOT_DIR ?= $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

ifeq ($(strip $(INSTALL_SUBDIR)),)
INSTALL_ROOT ?= $(ROOT_DIR)
else
INSTALL_ROOT ?= $(ROOT_DIR)/$(INSTALL_SUBDIR)
endif

TOP_BINDIR ?= $(INSTALL_ROOT)/bin
MTC_BINDIR ?= $(INSTALL_ROOT)/mtc++/bin

UNAME_S := $(shell uname -s 2>/dev/null || echo Unknown)
CXX_VERSION_LINE := $(shell $(CXX) --version 2>/dev/null | head -n 1)

ifeq ($(origin LEX_LIBS), undefined)
ifeq ($(UNAME_S),Linux)
LEX_LIBS ?= -lfl
endif
ifeq ($(UNAME_S),Darwin)
LEX_LIBS ?= -ll
endif
endif

GENERATED_CXXFLAGS ?=
ifneq ($(findstring clang,$(CXX_VERSION_LINE)),)
GENERATED_CXXFLAGS += -Wno-deprecated-register
endif

CPPFLAGS ?=
CXXFLAGS ?= -std=gnu++11
CFLAGS ?=
LDFLAGS ?=
LDLIBS ?=
