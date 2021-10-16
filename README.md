# LiteDB: all the missing SQLite functions (friendly fork from nalgeon/sqlean)

SQLite has very few functions compared to other DBMS. SQLite authors see this as a feature rather than a bug, because SQLite has extension mechanism in place.

There are a lot of SQLite extensions out there, but they are incomplete, inconsistent and scattered across the internet.

`sqlean` brings them all together, neatly packaged by domain modules and built for Linux, Windows and macOS.

Here is what we've got right now:

- [crypto](docs/crypto.md): secure hashes
- [ipaddr](docs/ipaddr.md): IP address manipulation
- [json1](docs/json1.md): JSON functions
- [math](docs/math.md): math functions
- [re](docs/re.md): regular expressions
- [stats](docs/stats.md): math statistics
- [text](docs/text.md): string functions
- [unicode](docs/unicode.md): Unicode support
- [vsv](docs/vsv.md): CSV files as virtual tables

## Download

There are [precompiled binaries](https://github.com/litedb/litedb/releases/latest) for every OS:

- `*.dll` - for Windows (64-bit)
- `*-win32.dll` - for Windows (32-bit)
- `*.so` - for Linux (64-bit)
- `*.dylib` - for macOS (Intel based)

Binaries are 64-bit and require a 64-bit SQLite version. If you are using SQLite shell on Windows (`sqlite.exe`), its 64-bit version is available at https://github.com/nalgeon/sqlite.

## Usage

CLI usage:

```
sqlite> .load ./stats
sqlite> select median(value) from generate_series(1, 100);
```

IDE usage:

```
select load_extension('/path/to/extension/stats');
select median(value) from generate_series(1, 100);
```

In-app usage:

```python
import sqlite3

connection = sqlite3.connect(":memory:")
connection.enable_load_extension(True)
connection.load_extension("./stats.so")
connection.execute("select median(value) from generate_series(1, 100)")
connection.close()
```

You can specify any other supported extension instead of `stats`.
