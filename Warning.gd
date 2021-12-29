tool
class_name PressAccept_Error_Warning

extends PressAccept_Error_Exception

# |=======================================|
# |                                       |
# |          Press Accept: Error          |
# | Error/Exception Handling For GDScript |
# |                                       |
# |=======================================|
#
# If you return this as a value from a function, you can test if there was an
# error rather than legitimate data by testing against the type:
#
#     obj is PressAccept_Error_Warning
#
# |------------------|
# | Meta Information |
# |------------------|
#
# Organization Namespace : PressAccept
# Package Namespace      : Error
# Class                  : Warning
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

# ***************
# | Constructor |
# ***************


func _init(
		init_code             = null,
		init_message : String = '',
		init_time    : int    = OS.get_unix_time()
		).(init_code, init_message, init_time) -> void:

	pass


# ********************
# | Built-In Methods |
# ********************


func __title() -> String:

	return 'Warning'

