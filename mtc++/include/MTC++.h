/*
 *
 * MTC++ Library Header File
 * Copyright (c) Mark T. Chapman 1995
 *
 * $Id: MTC++.h,v 1.4 1997/03/05 15:58:28 markc Exp $
 * 
 * $Log: MTC++.h,v $
 * Revision 1.4  1997/03/05 15:58:28  markc
 * Added static char rcsid []  = "@(#)$Id$";
 *
 * Revision 1.3  1995/11/08 17:09:56  chapman
 * Added #include's for stat call
 *
 * Revision 1.2  1995/06/30  20:20:55  markc
 * removed #includes for library headers
 *
 * Revision 1.1  1995/06/07  01:51:00  markc
 * Initial revision
 *
 *
 */

#ifndef __MTCPP_H_
#define __MTCPP_H_

static char rcsid__MTCPP_H_ []  = "@(#)$Id: MTC++.h,v 1.4 1997/03/05 15:58:28 markc Exp $";

#include <cctype>
#include <cstdio>
#include <cstring>
#include <fstream>
#include <iostream>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

using std::cerr;
using std::cin;
using std::cout;
using std::endl;
using std::fstream;
using std::ifstream;
using std::ios;
using std::istream;
using std::ofstream;
using std::ostream;
using std::streamoff;
using std::streampos;

#ifndef BOOL
#define BOOL short
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef MAXPATH
#define MAXPATH 80
#endif

/*
 * #include "../include/mstring.h"
 * #include "../include/errormsg.h"
 * #include "../include/initfile.h"
 */

#endif
