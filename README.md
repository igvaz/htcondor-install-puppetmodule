# HTCondor Puppet Module for Installation and Basic Configuration

This Puppet module installs HTCondor, a workload management system for compute-intensive jobs.

## Description

This module handles the installation of HTCondor, the management of its configuration files, and the basic setup of different HTCondor node roles, such as Central Manager, Scheduler, and Worker nodes.

## Setup

To use this module, include the main `htcondor` class in your Puppet manifests. You must change the following parameters accordingly with your environment: 

#### config.pp file: 

String $condor_host = 'condorcm.domain.com',

#### condor_config.epp file: 

CONDOR_HOST = <%= $condor_host %>
COLLECTOR_HOST = <%= $condor_host %>
SCHEDD_NAME = condorsched.domain.com
UID_DOMAIN = domain.com
FILESYSTEM_DOMAIN = domain.com

ALLOW_CONFIG = condorcm.domain.com
ALLOW_ADMINISTRATOR = condorcm.domain.com
ALLOW_DAEMON = *.domain.com, unauthenticated@unmapped
ALLOW_READ = *.domain.com
ALLOW_WRITE = *.domain.com

* For more details regarding it please read HTCondor Documentation: https://htcondor.readthedocs.io/en/latest/admin-manual/security.html#authentication

## Usage

This module can be used to configure different types of HTCondor nodes.

To configure a node as a Central Manager, include the `htcondor::central_manager` class.

To configure a node as a scheduler, include the `htcondor::scheduler` class.

To configure a node as a worker, include the `htcondor::worker` class.

## Reference

### Classes

#### Public Classes

*   `htcondor`: The main class for installing and configuring HTCondor.
*   `htcondor::central_manager`: Configures a node as an HTCondor Central Manager.
*   `htcondor::scheduler`: Configures a node as an HTCondor Scheduler.
*   `htcondor::worker`: Configures a node as an HTCondor Worker.

#### Private Classes

*   `htcondor::install`: Handles the installation of HTCondor.
*   `htcondor::config`: Manages HTCondor configuration files.
*   `htcondor::service`: Manages the HTCondor service.
*   `htcondor::security`: Manages HTCondor security settings.