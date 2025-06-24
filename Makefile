#
# Makefile for the Offline NT Password Editor
#
#
# Change here to point to the needed OpenSSL libraries & .h files
# See INSTALL for more info.
#

#SSLPATH=/usr/local/ssl
OSSLPATH=/opt/homebrew/opt/openssl@3
OSSLINC=$(OSSLPATH)/include

CC=gcc

# 64 bit if default for compiler setup
# Added -Wno-deprecated-declarations to suppress OpenSSL 3.x deprecation warnings
CFLAGS= -DUSEOPENSSL -g -I. -I$(OSSLINC) -Wno-deprecated-declarations -DOPENSSL_SUPPRESS_DEPRECATED
OSSLLIB=$(OSSLPATH)/lib


# This is to link with whatever we have, SSL crypto lib we put in static
#LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a
LIBS=-L$(OSSLLIB) -lcrypto
all: chntpw cpnt reged

chntpw: chntpw.o ntreg.o edlib.o
	$(CC) $(CFLAGS) -o chntpw chntpw.o ntreg.o edlib.o $(LIBS)

cpnt: cpnt.o
	$(CC) $(CFLAGS) -o cpnt cpnt.o $(LIBS)

reged: reged.o ntreg.o edlib.o
	$(CC) $(CFLAGS) -o reged reged.o ntreg.o edlib.o


#ts: ts.o ntreg.o
#	$(CC) $(CFLAGS) -nostdlib -o ts ts.o ntreg.o $(LIBS)

# -Wl,-t

.c.o:
	$(CC) -c $(CFLAGS) $<

clean:
	rm -f *.o chntpw chntpw.static cpnt reged reged.static *~

