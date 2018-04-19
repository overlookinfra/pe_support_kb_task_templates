#!/bin/bash

# NOTE: This a stub for a bash version of template.rb
#
# Since template.rb is cross-platform and has access to puppet libraries,
# this script is left as a template of a template.

# - example_optional_integer: an optional integer parameter.
# - example_optional_string: an optional string parameter.
# - example_optional_boolean: an optional boolean parameter.
# - noop: an optional boolean metaparameter, will set params['_noop'].

# Read parameters, set defaults, and validate values.

read_parameters () {
  echo
}

# Read parameters as JSON from STDIN.

read_stdin () {
  echo
}

# Validate integers.
# While handled by tempate.json, validate in the task for defense in depth.

safe_integer () {
  echo
}

# Validate strings.
# While handled by tempate.json, validate in the task for defense in depth.

safe_string () {
  echo
}

# Validate boolean strings.
# While handled by tempate.json, validate in the task for defense in depth.

safe_boolean () {
  echo
}

# Execute a command with an array of arguments and return the result as a hash.

execute_command () {
  echo
}

# Return an error and exit.

return_error () {
  echo 'error'
  exit 1
}

return_command_error () {
  echo 'failure'
  exit 1
}

return_command_results () {
  echo 'success'
  exit 0
}

return_command_results () {
  echo
}

# Main

# params=read_parameters
# Note: Implement task-specific command(s) here.
# command=echo
# results=execute_command(command, params)
# if test "x0" = "x0"; then
#  return_command_error(params, results)
# else
#  return_command_results(params, results)
# fi
