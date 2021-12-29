tool
class_name PressAccept_Error_Exception

# |=======================================|
# |                                       |
# |          Press Accept: Error          |
# | Error/Exception Handling For GDScript |
# |                                       |
# |=======================================|
#
# An Exception Specific Class
#
# Sometimes you might have a function that can return a completely variable data
# type, or else you might need some formal way of tracking exceptions that might
# occur in your code.
#
# This class can offer a way to achieve both of these things, prticularly since
# GDScript doesn't offer any language specific exception handling mechanisms.
# If you return this as a value from a function, you can test if there was an
# error rather than legitimate data by testing against the type:
#
#     obj is PressAccept_Error_Exception
#
# |------------------|
# | Meta Information |
# |------------------|
#
# Organization Namespace : PressAccept
# Package Namespace      : Error
# Class                  : Exception
#
# Organization        : Press Accept
# Organization URI    : https://pressaccept.com/
# Organization Social : @pressaccept
#
# Author        : Asher Kadar Wolfstein
# Author URI    : https://wunk.me/ (Personal Blog)
# Author Social : https://incarnate.me/members/asherwolfstein/
#                 @asherwolfstein (Twitter)
#                 https://ko-fi.com/asherwolfstein
#
# Copyright : Press Accept: Conductor © 2021 The Novelty Factor LLC
#                 (Press Accept, Asher Kadar Wolfstein)
# License   : Proprietary. All Rights Reserved.
#
# |-----------|
# | Changelog |
# |-----------|
#

const STR_EXCEPTION_CODE    : String = 'code'
const STR_EXCEPTION_MESSAGE : String = 'message'
const STR_EXCEPTION_TIME    : String = 'time'

# ***************************
# | Public Static Functions |
# ***************************


static func create(
		arguments: Dictionary,
		script: Script = \
			load('res://addons/PressAccept/Error/Exception.gd') as Script
		) -> PressAccept_Error_Exception:

	arguments[STR_EXCEPTION_CODE] = \
		arguments[STR_EXCEPTION_CODE] \
		if arguments.has(STR_EXCEPTION_CODE) and arguments[STR_EXCEPTION_CODE] \
		else null
	arguments[STR_EXCEPTION_MESSAGE] = \
		arguments['message'] \
		if arguments.has(STR_EXCEPTION_MESSAGE) \
			and arguments[STR_EXCEPTION_MESSAGE] \
		else ''
	arguments[STR_EXCEPTION_TIME] = \
		arguments['time'] \
		if arguments.has(STR_EXCEPTION_TIME) and arguments[STR_EXCEPTION_TIME] \
		else OS.get_unix_time()

	var return_value = script.new(
		arguments[STR_EXCEPTION_CODE],
		arguments[STR_EXCEPTION_MESSAGE],
		arguments[STR_EXCEPTION_TIME]
	)

	return_value.stack_trace.pop_front()

	return return_value


static func try_catch(
		try_func   : FuncRef,
		catch_func, # Array | FuncRef
		args       : Array = []): # -> result | PressAccept_Error_Exception

	var Self: Script = load('res://addons/PressAccept/Error/Exception.gd')

	var result

	if try_func.is_valid():
		result = try_func.call_funcv(args)

	if result is Self:
		if catch_func is FuncRef and catch_func.is_valid():
			result = catch_func.call_func(result, result)
		else:
			var _result = []
			for catch in catch_func:
				if catch is FuncRef and catch.is_valid():
					_result += [ catch.call_func(result, _result) ]
			result = _result

	return result


# *********************
# | Public Properties |
# *********************

var code
var message     : String
var stack_trace : Array
var time        : int

# ***************
# | Constructor |
# ***************


func _init(
		init_code             = null,
		init_message : String = '',
		init_time    : int    = OS.get_unix_time()) -> void:

	code = init_code
	message = init_message
	stack_trace = get_stack()
	stack_trace.pop_front() # we don't need this _init

	var revised_stack_trace: Array = []
	for trace in stack_trace:
		if trace['source']:
			revised_stack_trace.push_back(trace)
	
	stack_trace = revised_stack_trace

	time = init_time


# ********************
# | Built-In Methods |
# ********************


func _to_string() -> String:
	return __output('')


func __output(
		prefix   : String,
		tab_char : String = "\t") -> String:

	var ret: String = prefix + __title() + ":\n"
	ret += prefix + tab_char + "Code: " + str(code) + "\n"
	ret += prefix + tab_char + "Message: " + message + "\n"
	ret += prefix + tab_char + "Timestamp: " + str(time) + "\n"
	ret += prefix + tab_char + "Stack Trace:\n"

	for i in range(stack_trace.size() - 1, -1, -1):
		ret += prefix + tab_char + tab_char + stack_trace[i]['source']
		ret += ': ' + str(stack_trace[i]['line']) + ' ' \
			+ stack_trace[i]['function'] + "\n"

	ret += "\n"

	return ret


func __title() -> String:

	return 'Exception'

