# Since template.rb is cross-platform and has access to puppet libraries,
# this script is left as a template of a template.

# - example_optional_integer: an optional integer parameter.
# - example_optional_string: an optional string parameter.
# - example_optional_boolean: an optional boolean parameter.
# - noop: an optional boolean metaparameter, will set params['_noop'].

[CmdletBinding()]
Param(
  [Parameter(Mandatory = $False)]
  [String]
  $ExampleOptionalInteger,

  [Parameter(Mandatory = $False)]
  [String]
  $ExampleOptionalString,

  [Parameter(Mandatory = $False)]
  [String]
  $ExampleOptionalBoolean,
)

# Validate integers.
# While handled by tempate.json, validate in the task for defense in depth.

function Safe-integer () {
  Write-Host
}

# Validate strings.
# While handled by tempate.json, validate in the task for defense in depth.

function Safe-string () {
  Write-Host
}

# Validate boolean strings.
# While handled by tempate.json, validate in the task for defense in depth.

function Safe-boolean () {
  Write-Host
}

# Execute a command with an array of arguments and return the result as a hash.

function Execute_command () {
  Write-Host
}

# Return an error and exit.

function Return-Error () {
  Write-Host 'error'
  exit 1
}

function Return-Command-Error () {
  Write-Host 'failure'
  exit 1
}

function Return-Command-Results () {
  Write-Host 'success'
  exit 0
}

function Return-Command-Results () {
  Write-Host
}

# Main

# Note: Implement task-specific command(s) here.
# command = 'Write-Host'
# results = Execute-Command(command, params)
# if ($True == $True) {
#   Return-Command-Error(params, results)
# } else {
#   Return-Command-Results(params, results)
# }
