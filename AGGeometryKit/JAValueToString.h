/*
	JAValueToString.h
	
	Debugging utility to print the value of (almost) any variable.
	Limitations:
	  * PPC64 is currently not supported (I don’t have the necessary alignment
		information).
	  * Only lvalues can be printed, since it is necessary to take the address
	    of the target.
	  * Function pointers are described as “&<unknown>”, because @encode()
	    describes them as a pointer to “undef”.
	  * Bitfields are not supported, because I’m lazy.
	  * Altivec and SSE vector types are not supported.
	  * Aggregates whose alignment is modified using #pragma pack or similar
	    will not be displayed properly.
	
	These last two are due to compiler limitations - vector types and custom
	aligment aren’t noted in @encode() strings. In these cases, an error string
	is returned (unless you’re calling JAValueToString() directly with 0 as
	expectedSize, in which case a crash is likely).
	
	This utility is not especially robust and should be used for debugging
	only.
	
	
	Copyright © 2010–2013 Jens Ayton
	
	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the “Software”),
	to deal in the Software without restriction, including without limitation
	the rights to use, copy, modify, merge, publish, distribute, sublicense,
	and/or sell copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
	THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
	DEALINGS IN THE SOFTWARE.
*/

#import <Foundation/Foundation.h>


/*	JA_ENCODE(val)
	
	Return a string describing the contents of <val>.
	
	val: any lvalue.
*/
#define JA_ENCODE(val)  JAValueToString(@encode(typeof(val)), (typeof(val) *){ &(val) }, sizeof val)


/*	JA_DUMP(val)
	
	Log the contents of <val>.
	
	val: any lvalue.
*/
#define JA_DUMP(val)  JA_DUMP_LOG(@"%s = %@", #val, JA_ENCODE(val))


/*	JAValueToString(encoding, value, expectedSize)
	
	Interpret the bytes pointed at by <value> as data of the type described
	by <encoding>, in @encode() format.
	
	If the type is one that cannot be parsed correctly, an error string is
	returned. There is no way to distinguish this from a non-error result --
	this is considered acceptable because the only legitimate use of this
	function is to get a display string for debugging purposes.
	
	encoding: a type encoding as produced by the @encode() directive or any
	of various Objective-C runtime methods that return type encodings (such as
	ivar_getTypeEncoding()).
	
	value: a pointer to bytes assumed to match the specified <encoding>.
	
	expectedSize: the byte size of *<value>. This is used to detect certain
	parsing errors. If it is 0, these checks are skipped and a crash may
	result.
*/
FOUNDATION_EXTERN NSString *JAValueToString(const char *encoding, const void *value, size_t expectedSize);


/*	JA_DUMP_LOG(format, ...)
	
	Logging primitive for JA_DUMP(). By default, this is NSLog(), but it can
	be defined as a custom function before JAValueToString.h is included.
*/
#ifndef JA_DUMP_LOG
#define JA_DUMP_LOG(...) NSLog(__VA_ARGS__)
#endif
