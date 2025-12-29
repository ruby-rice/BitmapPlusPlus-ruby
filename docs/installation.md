# Installation

## Prerequisites

- Ruby 3.0 or higher
- A C++17 compatible compiler
- Rice gem (automatically installed as a dependency)

## Install from RubyGems

```bash
gem install bitmap-plus-plus -- --preset [linux-release|macos-release|mingw-release|msvc-release]
```

## Install from Source

```bash
git clone https://github.com/cfis/bitmap_plus_plus-ruby.git
cd bitmap-plus-plus-ruby
bundle install
rake compile
rake install
```

## Build with CMake

For development, you will need a C++ compiler installed as well as CMake. Then build BitmapPlusPlus using the appropriate CMake preset for your operating system:

### Linux

```bash
cmake --preset linux-release
cmake --build --preset linux-release
```

### macOS

```bash
cmake --preset macos-release
cmake --build --preset macos-release
```

### Windows (MinGW)

```bash
cmake --preset mingw-release
cmake --build --preset mingw-release
```

### Windows (MSVC)

```bash
cmake --preset msvc-release
cmake --build --preset msvc-release
```

