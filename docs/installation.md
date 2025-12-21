# Installation

## Prerequisites

- Ruby 3.0 or higher
- A C++17 compatible compiler
- Rice gem (automatically installed as a dependency)

## Install from RubyGems

```bash
gem install bitmap_plus_plus
```

## Install from Source

```bash
git clone https://github.com/cfis/bitmap_plus_plus-ruby.git
cd bitmap_plus_plus-ruby
bundle install
rake compile
rake install
```

## Build with CMake

For development, you can also build using CMake with presets:

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

### Windows (MSVC)

```bash
cmake --preset msvc-release
cmake --build --preset msvc-release
```

### Windows (MinGW)

```bash
cmake --preset mingw-release
cmake --build --preset mingw-release
```
