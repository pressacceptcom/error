extends 'res://addons/gut/test.gd'

# |---------|
# | Imports |
# |---------|

# see test/Utilities.gd
var TestUtilities : Script = PressAccept_Comparator_Test_Utilities
# shorthand for our library class
var Exception     : Script = PressAccept_Error_Exception

# |-------|
# | Tests |
# |-------|

func test_create() -> void:

	var exception: PressAccept_Error_Exception = Exception.create(
		{
			Exception.STR_EXCEPTION_CODE    : 'code',
			Exception.STR_EXCEPTION_MESSAGE : 'message'
		}
	)

	var error: PressAccept_Error_Error = Exception.create(
		{},
		PressAccept_Error_Error
	)

	var warning: PressAccept_Error_Warning = Exception.create(
		{
			Exception.STR_EXCEPTION_CODE    : 100,
			Exception.STR_EXCEPTION_MESSAGE : 'warning message',
			Exception.STR_EXCEPTION_TIME    : 123456789
		},
		PressAccept_Error_Warning
	)

	assert_is(exception, PressAccept_Error_Exception, "Wrong Class")
	assert_is(error, PressAccept_Error_Error, "Wrong Class")
	assert_is(warning, PressAccept_Error_Warning, "Wrong Class")

	assert_eq(exception.code, 'code')
	assert_eq(exception.message, 'message')
	
	assert_eq(error.code, null)
	assert_eq(error.message, '')

	assert_eq(warning.code, 100)
	assert_eq(warning.message, 'warning message')
	assert_eq(warning.time, 123456789)

	print(exception)
	print(error)
	print(warning)


func try_func(arg):

	if arg == 5:
		return Exception.create(
			{
				Exception.STR_EXCEPTION_CODE    : 'exception',
				Exception.STR_EXCEPTION_MESSAGE : 'message'
			}
		)

	return arg


func catch_func(exception, result):

	assert_is(exception, PressAccept_Error_Exception)

	return true


func catch_func2(exception, result):

	assert_is(exception, PressAccept_Error_Exception)

	return 7


func test_try_catch() -> void:

	assert_eq(
		Exception.try_catch(
			funcref(self, 'try_func'),
			funcref(self, 'catch_func'),
			[ 1 ]
		),
		1
	)

	assert_true(
			Exception.try_catch(
			funcref(self, 'try_func'),
			funcref(self, 'catch_func'),
			[ 5 ]
		)
	)

	assert_eq(
		Exception.try_catch(
			funcref(self, 'try_func'),
			[
				funcref(self, 'catch_func'),
				funcref(self, 'catch_func2')
			],
			[ 5 ]
		),
		[ true, 7 ]
	)



