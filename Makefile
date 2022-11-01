# Copyright (c) 2021 Anton Zhiyanov, MIT License
# https://github.com/nalgeon/sqlean

.PHONY: test

prepare-dist:
	mkdir -p dist
	rm -rf dist/*

download-sqlite:
	curl -L http://sqlite.org/$(SQLITE_RELEASE_YEAR)/sqlite-amalgamation-$(SQLITE_VERSION).zip --output src.zip
	unzip src.zip
	mv sqlite-amalgamation-$(SQLITE_VERSION)/* src

download-external:
	curl -L https://github.com/sqlite/sqlite/raw/branch-$(SQLITE_BRANCH)/ext/misc/json1.c --output src/sqlite3-json1.c
	curl -L https://github.com/mackyle/sqlite/raw/branch-$(SQLITE_BRANCH)/src/test_windirent.h --output src/test_windirent.h
	# --------------------------------------------------
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/btreeinfo.c --output src/btreeinfo.c
	# curl -L https://github.com/davegamble/cjson/raw/master/cJSON.c --output src/cJSON.c
	# curl -L https://github.com/davegamble/cjson/raw/master/cJSON.h --output src/cJSON.h
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/closure.c --output src/closure.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/compress.c --output src/compress.c
	curl -L https://github.com/daschr/sqlite3_extensions/raw/master/cron.c --output src/cron.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/decimal.c --output src/decimal.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/eval.c --output src/eval.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/ieee754.c --output src/ieee754.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/memstat.c --output src/memstat.c
	curl -L https://github.com/jakethaw/pivot_vtab/raw/main/pivot_vtab.c --output src/pivotvtab.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/prefixes.c --output src/prefixes.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/spellfix.c --output src/spellfix.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/sqlar.c --output src/sqlar.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/stmt.c --output src/stmt.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/uint.c --output src/uint.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/unionvtab.c --output src/unionvtab.c
	curl -L https://github.com/jakethaw/xml_to_json/raw/master/xml_to_json.c --output src/xmltojson.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/zipfile.c --output src/zipfile.c
	curl -L https://github.com/sqlite/sqlite/raw/master/ext/misc/zorder.c --output src/zorder.c

compile-linux:
	gcc -fPIC -shared src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto.so
	gcc -fPIC -shared src/sqlite3-define.c -o dist/define.so
	gcc -fPIC -shared src/sqlite3-fileio.c -o dist/fileio.so
	gcc -fPIC -shared src/sqlite3-fuzzy.c src/fuzzy/*.c -o dist/fuzzy.so
	gcc -fPIC -shared src/sqlite3-ipaddr.c -o dist/ipaddr.so
	gcc -fPIC -shared src/sqlite3-json1.c -o dist/json1.so
	gcc -fPIC -shared src/sqlite3-math.c -o dist/math.so -lm
	gcc -fPIC -shared src/sqlite3-re.c src/re.c -o dist/re.so
	gcc -fPIC -shared src/sqlite3-stats.c -o dist/stats.so -lm
	gcc -fPIC -shared src/sqlite3-text.c -o dist/text.so
	gcc -fPIC -shared src/sqlite3-unicode.c -o dist/unicode.so
	gcc -fPIC -shared src/sqlite3-uuid.c -o dist/uuid.so
	gcc -fPIC -shared src/sqlite3-vsv.c -o dist/vsv.so -lm
	# --------------------------------------------------
	gcc -fPIC -shared src/array.c src/array/*.c -o dist/array.so
	gcc -fPIC -shared src/besttype.c -o dist/besttype.so
	gcc -fPIC -shared src/bloom.c -o dist/bloom.so
	gcc -fPIC -shared src/btreeinfo.c -o dist/btreeinfo.so
	gcc -fPIC -shared src/cbrt.c -o dist/cbrt.so -lm
	gcc -fPIC -shared src/classifier.c -o dist/classifier.so
	gcc -fPIC -shared src/closure.c -o dist/closure.so
	gcc -fPIC -shared src/compress.c -o dist/compress.so -lz
	gcc -fPIC -shared src/cron.c -o dist/cron.so
	gcc -fPIC -shared src/dbdump.c -o dist/dbdump.so
	gcc -fPIC -shared src/decimal.c -o dist/decimal.so
	gcc -fPIC -shared src/define.c -o dist/define.so
	gcc -fPIC -shared src/envfuncs.c -o dist/envfuncs.so
	gcc -fPIC -shared src/eval.c -o dist/eval.so
	gcc -fPIC -shared src/fcmp.c -o dist/fcmp.so
	gcc -fPIC -shared src/ieee754.c -o dist/ieee754.so
	gcc -fPIC -shared src/interpolate.c -o dist/interpolate.so
	gcc -fPIC -shared src/isodate.c -o dist/isodate.so
	# gcc -fPIC -shared src/json2.c src/cJSON.c -o dist/json2.so
	gcc -fPIC -shared src/math2.c -o dist/math2.so
	gcc -fPIC -shared src/memstat.c -o dist/memstat.so
	gcc -fPIC -shared src/pearson.c -o dist/pearson.so
	gcc -fPIC -shared src/pivotvtab.c -o dist/pivotvtab.so
	gcc -fPIC -shared src/prefixes.c -o dist/prefixes.so
	gcc -fPIC -shared src/recsize.c -o dist/recsize.so
	gcc -fPIC -shared src/rotate.c -o dist/rotate.so
	gcc -fPIC -shared src/spellfix.c -o dist/spellfix.so
	gcc -fPIC -shared src/sqlar.c -o dist/sqlar.so -lz
	gcc -fPIC -shared src/stats2.c -o dist/stats2.so
	gcc -fPIC -shared src/stats3.c -o dist/stats3.so
	gcc -fPIC -shared src/stmt.c -o dist/stmt.so
	gcc -fPIC -shared src/text2.c -o dist/text2.so
	gcc -fPIC -shared src/uint.c -o dist/uint.so
	gcc -fPIC -shared src/unhex.c -o dist/unhex.so
	gcc -fPIC -shared src/unionvtab.c -o dist/unionvtab.so
	gcc -fPIC -shared src/xmltojson.c -o dist/xmltojson.so -DSQLITE
	gcc -fPIC -shared src/zipfile.c -o dist/zipfile.so -lz
	gcc -fPIC -shared src/zorder.c -o dist/zorder.so

pack-linux:
	zip -j dist/sqlean-linux-x86.zip dist/*.so

compile-windows:
	gcc -shared -I. src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto.dll
	gcc -shared -I. src/sqlite3-define.c -o dist/define.dll
	gcc -shared -I. src/sqlite3-fileio.c -o dist/fileio.dll
	gcc -shared -I. src/sqlite3-fuzzy.c src/fuzzy/*.c -o dist/fuzzy.dll
	gcc -shared -I. src/sqlite3-json1.c -o dist/json1.dll
	gcc -shared -I. src/sqlite3-math.c -o dist/math.dll -lm
	gcc -shared -I. src/sqlite3-re.c src/re.c -o dist/re.dll
	gcc -shared -I. src/sqlite3-stats.c -o dist/stats.dll -lm
	gcc -shared -I. src/sqlite3-text.c -o dist/text.dll
	gcc -shared -I. src/sqlite3-unicode.c -o dist/unicode.dll
	gcc -shared -I. src/sqlite3-uuid.c -o dist/uuid.dll
	gcc -shared -I. src/sqlite3-vsv.c -o dist/vsv.dll -lm
	# --------------------------------------------------
	gcc -shared -I. src/array.c src/array/*.c -o dist/array.dll
	gcc -shared -I. src/besttype.c -o dist/besttype.dll
	gcc -shared -I. src/bloom.c -o dist/bloom.dll
	gcc -shared -I. src/btreeinfo.c -o dist/btreeinfo.dll
	gcc -shared -I. src/cbrt.c -o dist/cbrt.dll -lm
	gcc -shared -I. src/classifier.c -o dist/classifier.dll
	gcc -shared -I. src/closure.c -o dist/closure.dll
	# gcc -shared -I. src/compress.c -o dist/compress.dll -lz
	gcc -shared -I. src/cron.c -o dist/cron.dll
	gcc -shared -I. src/dbdump.c -o dist/dbdump.dll
	gcc -shared -I. src/decimal.c -o dist/decimal.dll
	gcc -shared -I. src/define.c -o dist/define.dll
	gcc -shared -I. src/envfuncs.c -o dist/envfuncs.dll
	gcc -shared -I. src/eval.c -o dist/eval.dll
	gcc -shared -I. src/fcmp.c -o dist/fcmp.dll
	gcc -shared -I. src/ieee754.c -o dist/ieee754.dll
	gcc -shared -I. src/interpolate.c -o dist/interpolate.dll
	gcc -shared -I. src/isodate.c -o dist/isodate.dll
	# gcc -shared -I. src/json2.c src/cJSON.c -o dist/json2.dll
	gcc -shared -I. src/math2.c -o dist/math2.dll
	gcc -shared -I. src/memstat.c -o dist/memstat.dll
	gcc -shared -I. src/pearson.c -o dist/pearson.dll
	gcc -shared -I. src/pivotvtab.c -o dist/pivotvtab.dll
	gcc -shared -I. src/prefixes.c -o dist/prefixes.dll
	gcc -shared -I. src/recsize.c -o dist/recsize.dll
	gcc -shared -I. src/rotate.c -o dist/rotate.dll
	gcc -shared -I. src/spellfix.c -o dist/spellfix.dll
	# gcc -shared -I. src/sqlar.c -o dist/sqlar.dll -lz
	gcc -shared -I. src/stats2.c -o dist/stats2.dll
	gcc -shared -I. src/stats3.c -o dist/stats3.dll
	gcc -shared -I. src/stmt.c -o dist/stmt.dll
	gcc -shared -I. src/text2.c -o dist/text2.dll
	gcc -shared -I. src/uint.c -o dist/uint.dll
	gcc -shared -I. src/unhex.c -o dist/unhex.dll
	gcc -shared -I. src/unionvtab.c -o dist/unionvtab.dll
	gcc -shared -I. src/xmltojson.c -o dist/xmltojson.dll -DSQLITE
	# gcc -shared -I. src/zipfile.c -o dist/zipfile.dll -lz
	gcc -shared -I. src/zorder.c -o dist/zorder.dll

pack-windows:
	7z a -tzip dist/sqlean-win-x64.zip ./dist/*.dll

compile-macos:
	gcc -fPIC -dynamiclib -I src src/sqlite3-crypto.c src/crypto/*.c -o dist/crypto.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-define.c -o dist/define.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-fileio.c -o dist/fileio.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-fuzzy.c src/fuzzy/*.c -o dist/fuzzy.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-ipaddr.c -o dist/ipaddr.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-json1.c -o dist/json1.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-math.c -o dist/math.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-re.c src/re.c -o dist/re.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-stats.c -o dist/stats.dylib -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-text.c -o dist/text.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-unicode.c -o dist/unicode.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-uuid.c -o dist/uuid.dylib
	gcc -fPIC -dynamiclib -I src src/sqlite3-vsv.c -o dist/vsv.dylib -lm
	# --------------------------------------------------
	gcc -fPIC -dynamiclib -I src src/array.c src/array/*.c -o dist/array.dylib
	gcc -fPIC -dynamiclib -I src src/besttype.c -o dist/besttype.dylib
	gcc -fPIC -dynamiclib -I src src/bloom.c -o dist/bloom.dylib
	gcc -fPIC -dynamiclib -I src src/btreeinfo.c -o dist/btreeinfo.dylib
	gcc -fPIC -dynamiclib -I src src/cbrt.c -o dist/cbrt.dylib -lm
	gcc -fPIC -dynamiclib -I src src/classifier.c -o dist/classifier.dylib
	gcc -fPIC -dynamiclib -I src src/closure.c -o dist/closure.dylib
	gcc -fPIC -dynamiclib -I src src/compress.c -o dist/compress.dylib -lz
	gcc -fPIC -dynamiclib -I src src/cron.c -o dist/cron.dylib
	gcc -fPIC -dynamiclib -I src src/dbdump.c -o dist/dbdump.dylib
	gcc -fPIC -dynamiclib -I src src/decimal.c -o dist/decimal.dylib
	gcc -fPIC -dynamiclib -I src src/define.c -o dist/define.dylib
	gcc -fPIC -dynamiclib -I src src/envfuncs.c -o dist/envfuncs.dylib
	gcc -fPIC -dynamiclib -I src src/eval.c -o dist/eval.dylib
	gcc -fPIC -dynamiclib -I src src/fcmp.c -o dist/fcmp.dylib
	gcc -fPIC -dynamiclib -I src src/ieee754.c -o dist/ieee754.dylib
	gcc -fPIC -dynamiclib -I src src/interpolate.c -o dist/interpolate.dylib
	gcc -fPIC -dynamiclib -I src src/isodate.c -o dist/isodate.dylib
	# gcc -fPIC -dynamiclib -I src src/json2.c src/cJSON.c -o dist/json2.dylib
	gcc -fPIC -dynamiclib -I src src/math2.c -o dist/math2.dylib
	gcc -fPIC -dynamiclib -I src src/memstat.c -o dist/memstat.dylib
	gcc -fPIC -dynamiclib -I src src/pearson.c -o dist/pearson.dylib
	gcc -fPIC -dynamiclib -I src src/pivotvtab.c -o dist/pivotvtab.dylib
	gcc -fPIC -dynamiclib -I src src/prefixes.c -o dist/prefixes.dylib
	gcc -fPIC -dynamiclib -I src src/recsize.c -o dist/recsize.dylib
	gcc -fPIC -dynamiclib -I src src/rotate.c -o dist/rotate.dylib
	gcc -fPIC -dynamiclib -I src src/spellfix.c -o dist/spellfix.dylib
	gcc -fPIC -dynamiclib -I src src/sqlar.c -o dist/sqlar.dylib -lz
	gcc -fPIC -dynamiclib -I src src/stats2.c -o dist/stats2.dylib
	gcc -fPIC -dynamiclib -I src src/stats3.c -o dist/stats3.dylib
	gcc -fPIC -dynamiclib -I src src/stmt.c -o dist/stmt.dylib
	gcc -fPIC -dynamiclib -I src src/text2.c -o dist/text2.dylib
	gcc -fPIC -dynamiclib -I src src/uint.c -o dist/uint.dylib
	gcc -fPIC -dynamiclib -I src src/unhex.c -o dist/unhex.dylib
	gcc -fPIC -dynamiclib -I src src/unionvtab.c -o dist/unionvtab.dylib
	gcc -fPIC -dynamiclib -I src src/xmltojson.c -o dist/xmltojson.dylib -DSQLITE
	gcc -fPIC -dynamiclib -I src src/zipfile.c -o dist/zipfile.dylib -lz
	gcc -fPIC -dynamiclib -I src src/zorder.c -o dist/zorder.dylib

compile-macos-x86:
	mkdir -p dist/x86
	gcc -fPIC -dynamiclib -I src src/sqlite3-crypto.c src/crypto/*.c -o dist/x86/crypto.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-define.c -o dist/x86/define.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-fileio.c -o dist/x86/fileio.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-fuzzy.c src/fuzzy/*.c -o dist/x86/fuzzy.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-ipaddr.c -o dist/x86/ipaddr.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-json1.c -o dist/x86/json1.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-math.c -o dist/x86/math.dylib -target x86_64-apple-macos10.12 -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-re.c src/re.c -o dist/x86/re.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-stats.c -o dist/x86/stats.dylib -target x86_64-apple-macos10.12 -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-text.c -o dist/x86/text.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-unicode.c -o dist/x86/unicode.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-uuid.c -o dist/x86/uuid.dylib -target x86_64-apple-macos10.12
	gcc -fPIC -dynamiclib -I src src/sqlite3-vsv.c -o dist/x86/vsv.dylib -target x86_64-apple-macos10.12 -lm

compile-macos-arm64:
	mkdir -p dist/arm64
	gcc -fPIC -dynamiclib -I src src/sqlite3-crypto.c src/crypto/*.c -o dist/arm64/crypto.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-define.c -o dist/arm64/define.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-fileio.c -o dist/arm64/fileio.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-fuzzy.c src/fuzzy/*.c -o dist/arm64/fuzzy.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-ipaddr.c -o dist/arm64/ipaddr.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-json1.c -o dist/arm64/json1.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-math.c -o dist/arm64/math.dylib -target arm64-apple-macos11 -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-re.c src/re.c -o dist/arm64/re.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-stats.c -o dist/arm64/stats.dylib -target arm64-apple-macos11 -lm
	gcc -fPIC -dynamiclib -I src src/sqlite3-text.c -o dist/arm64/text.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-unicode.c -o dist/arm64/unicode.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-uuid.c -o dist/arm64/uuid.dylib -target arm64-apple-macos11
	gcc -fPIC -dynamiclib -I src src/sqlite3-vsv.c -o dist/arm64/vsv.dylib -target arm64-apple-macos11 -lm

pack-macos:
	zip -j dist/sqlean-macos-x86.zip dist/x86/*.dylib
	zip -j dist/sqlean-macos-arm64.zip dist/arm64/*.dylib

test-all:
	make test suite=crypto
	make test suite=define
	make test suite=fileio
	make test suite=fuzzy
	make test suite=ipaddr
	make test suite=json1
	make test suite=math
	make test suite=re
	make test suite=stats
	make test suite=text
	make test suite=unicode
	make test suite=uuid
	make test suite=vsv
	# --------------------------------------------------
	sqlite3 --version
	echo 'PRAGMA compile_options;' | sqlite3
	make test suite=array
	make test suite=besttype
	# requires sqlite_dbpage, which is missing on github actions servers
	# make test suite=btreeinfo
	make test suite=bloom
	make test suite=cbrt
	make test suite=classifier
	make test suite=closure
	make test suite=compress
	make test suite=cron
	make test suite=define
	make test suite=decimal
	make test suite=dbdump
	make test suite=envfuncs
	make test suite=eval
	make test suite=fcmp
	make test suite=ieee754
	make test suite=interpolate
	make test suite=isodate
	# tests fail on ubuntu with segmentation fault
	# make test suite=json2
	make test suite=math2
	make test suite=memstat
	make test suite=pearson
	make test suite=pivotvtab
	make test suite=prefixes
	make test suite=recsize
	make test suite=rotate
	make test suite=spellfix
	make test suite=sqlar
	make test suite=stats2
	make test suite=stats3
	make test suite=stmt
	make test suite=text2
	make test suite=uint
	make test suite=unhex
	make test suite=unionvtab
	make test suite=xmltojson
	make test suite=zipfile
	make test suite=zorder

# fails if grep does find a failed test case
# https://stackoverflow.com/questions/15367674/bash-one-liner-to-exit-with-the-opposite-status-of-a-grep-command/21788642
test:
	@sqlite3 < test/$(suite).sql > test.log
	@cat test.log | (! grep -Ex "[0-9]+.[^1]")
