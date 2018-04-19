# Puppet Enterprise Support Knowledge Base Task Template

#### Table of Contents

1. [Description - What the module does and why it is useful](#description)
1. [Setup - Getting started with this module](#setup)
1. [Usage - Example output from the task](#usage)
1. [Limitations - What you need to do](#limitations)

## Description

This repository contains a Puppet Task template for use by Support Engineers when writing tasks for Knowledge Base articles.

## Setup

1. Install or upgrade PDK, if necessary: https://puppet.com/docs/pdk/latest/pdk_install.html
1. Create a module: https://puppet.com/docs/pdk/latest/pdk_creating_modules.html
1. Copy the tasks directory from this template to your module
1. Rename the copied tasks/* to match the name of your task
1. Write your task: https://puppet.com/docs/puppet/latest/puppet_tasks.html

## Usage

If you were to install this module on a master ...

```bash
[root@pe-master ~]# git clone https://github.com/puppetlabs/pe_support_kb_task.git /etc/puppetlabs/code/environments/production/modules/pe_support_kb_task
puppet agent -t
```

Its task would appear in the list of available tasks ...

```bash
[root@pe-master ~]# puppet task show
pe_support_kb_task::template
```

You could run that task, which simply echoes its defaults ...

```bash
[root@pe-master ~]#  puppet task run pe_support_kb_task::template --nodes pe-master
Starting job ...
New job ID: 1
Nodes: 1

Started on pe-master ...
Finished on node pe-master
  status : success
  results : example_optional_integer 123 example_optional_string ABC

Job completed. 1/1 nodes succeeded.
Duration: 2 sec
```

And you could run that task with parameters, which simply echoes its parameters ...


```bash
[root@pe-master tasks]# puppet task run pe_support_kb_task::template --nodes pe-master example_optional_integer=789 example_optional_string=XYZ example_optional_boolean=true
Starting job ...
New job ID: 2
Nodes: 1

Started on pe-master ...
Finished on node pe-master
  status : success
  results : example_optional_integer 780 example_optional_string XYZ example_optional_boolean true

Job completed. 1/1 nodes succeeded.
Duration: 2 sec
```

## Limitations

This is a template, with a library of useful methods.

You actually have to name and write your own task :)
