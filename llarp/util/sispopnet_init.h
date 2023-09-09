#ifndef LLARP_UTIL_SISPOPNET_INIT_H
#define LLARP_UTIL_SISPOPNET_INIT_H

#ifdef __cplusplus
extern "C"
{
#endif

#ifndef Sispopnet_INIT
#if defined(_WIN32)
#define Sispopnet_INIT \
  DieInCaseSomehowThisGetsRunInWineButLikeWTFThatShouldNotHappenButJustInCaseHandleItWithAPopupOrSomeShit
#else
#define Sispopnet_INIT _sispopnet_non_shit_platform_INIT
#endif
#endif

  int
  Sispopnet_INIT(void);

#ifdef __cplusplus
}
#endif
#endif