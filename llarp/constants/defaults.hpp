#ifndef LLARP_DEFAULTS_HPP
#define LLARP_DEFAULTS_HPP

#ifndef DEFAULT_RESOLVER_US
#define DEFAULT_RESOLVER_US "1.1.1.1"
#endif
#ifndef DEFAULT_RESOLVER_EU
#define DEFAULT_RESOLVER_EU "1.1.1.1"
#endif
#ifndef DEFAULT_RESOLVER_AU
#define DEFAULT_RESOLVER_AU "1.1.1.1"
#endif

#ifdef DEBIAN
#ifndef DEFAULT_SISPOPNET_USER
#define DEFAULT_SISPOPNET_USER "debian-sispopnet"
#endif
#ifndef DEFAULT_SISPOPNET_GROUP
#define DEFAULT_SISPOPNET_GROUP "debian-sispopnet"
#endif
#else
#ifndef DEFAULT_SISPOPNET_USER
#define DEFAULT_SISPOPNET_USER "sispopnet"
#endif
#ifndef DEFAULT_SISPOPNET_GROUP
#define DEFAULT_SISPOPNET_GROUP "sispopnet"
#endif
#endif

#endif
