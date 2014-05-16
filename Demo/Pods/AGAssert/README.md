AGAssert
========

Similar to NSAssert, but with slightly improved logging and is meant to ship with apps in release.

Benefits of using this over NSAssert:

- It is default **on** in all configurations since it uses `AG_BLOCK_ASSERTIONS` and not `NS_BLOCK_ASSERTIONS`.
- Slightly improved logging.
- Fewer macros and less mess.
- Does not require any description string as second parameter


Recommended reading about asserts http://www.mikeash.com/pyblog/friday-qa-2013-05-03-proper-use-of-asserts.html

[![Agens | Digital craftsmanship](http://static.agens.no/images/agens_logo_w_slogan_avenir_small.png)](http://agens.no/)
