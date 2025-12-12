#include <rice/rice.hpp>
#include <rice/stl.hpp>
#include <rice/api.hpp>

extern "C"
#if defined(_WIN32)
__declspec(dllexport)
#else
__attribute__((visibility("default")))
#endif
void Init_bitmap_plus_plus_ruby();