PROG=		mqlua
SRCS=		mqlua.c node.c zmq.c constants.c

OS!=		uname -s

.if ${OS} == "FreeBSD"
CFLAGS+=	-I${PKGDIR}/include/lua51
LDADD+=		-L${PKGDIR}/lib/lua51
.elif ${OS} == "NetBSD"
LDADD+=		-R/usr/lib -R${XDIR}/lib -R${PKGDIR}/lib \
		-R${PKGDIR}/lib/lua/5.2
.else
MANDIR=		${PKGDIR}/man/cat
.endif

CFLAGS+=	-Wall -Werror -I${.CURDIR} -I${XDIR}/include \
		-I${PKGDIR}/include -I${PGDIR} -DHOUSEKEEPING
LDADD+=		-L${XDIR}/lib -L${PKGDIR}/lib \
		-llua -lpthread

MAN=		node.1
NOMAN=		1

BINDIR=		${PKGDIR}/bin

beforeinstall:
	-mkdir -p ${DESTDIR}/${BINDIR}

.include <bsd.prog.mk>
