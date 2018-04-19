#!/opt/puppetlabs/puppet/bin/ruby

require 'facter'
require 'json'
require 'open3'
require 'puppet'
require 'timeout'

# Require a file in Puppet[:plugindest] which by default is Puppet[:libdir].
# Puppet's libdir is not included in LOAD_PATH within the context of tasks.
# Tasks execute in /opt/puppetlabs/pxp-agent/tasks-cache, ruling out require_relative.

def require_module_file(file)
  require "#{Puppet[:plugindest]}/#{file}"
end

# PARAMETERS: JSON object from STDIN with the following fields:
#
# - example_optional_integer: an optional integer parameter.
# - example_optional_string: an optional string parameter.
# - example_optional_boolean: an optional boolean parameter.
# - noop: an optional boolean metaparameter, will set params['_noop'].

# Read parameters, set defaults, and validate values.

def read_parameters
  params = read_stdin
  # Set defaults for optional parameters
  params['example_optional_integer'] = 123 unless params.key?('example_optional_integer')
  params['example_optional_string'] = 'XYZ' unless params.key?('example_optional_string')
  params['example_optional_boolean'] = false unless params.key?('example_optional_boolean')
  # Validate parameter values or return errors.
  return_error("Parameter 'example_optional_integer' contains illegal characters") unless safe_integer?(params['example_optional_integer'])
  return_error("Parameter 'example_optional_string' contains illegal characters") unless safe_string?(params['example_optional_string'])
  return_error("Parameter 'example_optional_boolean' contains illegal characters") unless safe_boolean?(params['example_optional_boolean'])
  # Note: Implement task-specific parameter validation here.
  params
end

# Read parameters as JSON from STDIN.

def read_stdin
  params = {}
  begin
    Timeout.timeout(3) do
      params = JSON.parse(STDIN.read)
    end
  rescue Timeout::Error
    return_error('Cannot read parameters as JSON from STDIN')
  end
  params
end

# Validate integers.
# While handled by tempate.json, validate in the task for defense in depth.

def safe_integer?(param)
  return true unless param
  (param =~ %r{^[0-9]+$}).nil?
end

# Validate strings.
# While handled by tempate.json, validate in the task for defense in depth.

def safe_string?(param)
  return true unless param
  (param =~ %r{^[A-Za-z0-9._-]+$}) != nil
end

# Validate boolean strings.
# While handled by tempate.json, validate in the task for defense in depth.

def safe_boolean?(param)
  return true unless param
  param == 'true' || param == 'false'
end

# Set on Linux and Windows, but not devices.

def os_family
  os = Facter.value(:os)
  return_error('Cannot determine operating system family') unless os.key?('family')
  os['family']
end

# Linux in this case means not Windows.

def linux?
  os_family != 'windows'
end

# Windows.

def windows?
  os_family == 'windows'
end

# Execute a command with an array of arguments and return the result as a hash.

def execute_command(command, args = [])
  # Convert each element of the array to a string.
  args = args.map(&:to_s)
  # Execute the command with the arguments passed as a variable length argument list using the asterisk operator.
  stdout, stderr, status = Open3.capture3(command, *args)
  { status: status.exitstatus, stdout: stdout.strip, stderr: stderr.strip }
end

# Return an error and exit.

def return_error(message)
  result = {}
  result[:_error] = {
    msg:     message,
    kind:    'pe_support_kb_task/template',
    details: {}
  }
  puts result.to_json
  exit 1
end

# Return the error results of a command and exit.

def return_command_error(params, command_results)
  result = {}
  result[:status]  = 'failure'
  result[:error]   = command_results[:stderr]
  result[:params]  = params
  puts result.to_json
  exit 1
end

# Return the results of a command and exit.

def return_command_results(_params, command_results)
  result = {}
  result[:status]  = 'success'
  result[:results] = command_results[:stdout]
  puts result.to_json
  exit 0
end

# Main

# Note: Allow this task to access settings like: Puppet[:environment].
# Puppet.initialize_settings

params = read_parameters
# Note: Implement task-specific command(s) here.
command = 'echo'
results = execute_command(command, params.flatten)
if results[:status] != 0
  return_command_error(params, results)
else
  return_command_results(params, results)
end
