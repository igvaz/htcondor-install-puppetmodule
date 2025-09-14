# HTCondor Puppet Module for Installation and Basic Configuration

A Puppet module for installing and configuring [HTCondor](https://htcondor.org/), a workload management system for compute-intensive jobs.

## Features

- Installs HTCondor and sets up the official YUM repository
- Manages core configuration files and directories
- Supports Central Manager, Scheduler, and Worker node roles
- Handles HTCondor security settings and service management
- Centralizes configuration defaults using `htcondor::params`
- Example role classes for Foreman-based environments

## Requirements

- Puppet 6 or newer
- RHEL/CentOS 9 or compatible OS (default repository URL)
- Root privileges for installation and configuration

## Installation

Clone or download this module into your Puppet modules directory:

```sh
git clone https://github.com/igvaz/htcondor-install-puppetmodule.git /etc/puppetlabs/code/environments/production/modules/htcondor
```

## Setup

To use this module, include the main `htcondor` class in your Puppet manifests. You must change the following accordingly with your environment: 

### Parameters

All parameters are centralized in `htcondor::params` for easy management and override.

| Parameter           | Description                                      | Default Value                      |
|---------------------|--------------------------------------------------|------------------------------------|
| `condor_host`       | Hostname of the HTCondor central manager         | `'condorcm.domain.com'`            |
| `password_directory`| Directory for HTCondor passwords                 | `'/etc/condor/passwords.d'`        |
| `pool_password`     | Password for pool authentication                 | `'lhc6?h1c'`                       |
| `domain`            | Domain used for UID_DOMAIN and related settings  | `'domain.com'`                     |

## Configuration Templates

Edit the EPP templates in the `templates/` directory to match your environment.  
The domain value is now set via the `domain` parameter and used throughout the configuration:

- `condor_config.epp`
- `10_security.config.epp`
- `20_workernode.config.epp`
- `21_schedd.config.epp`
- `22_manager.config.epp`

Example snippet from `condor_config.epp`:

```epp
CONDOR_HOST        = <%= $condor_host %>
COLLECTOR_HOST     = <%= $condor_host %>
SCHEDD_NAME        = condorsched.<%= $domain %>
UID_DOMAIN         = <%= $domain %>
FILESYSTEM_DOMAIN  = <%= $domain %>

ALLOW_CONFIG       = condorcm.<%= $domain %>
ALLOW_ADMINISTRATOR= condorcm.<%= $domain %>
ALLOW_DAEMON       = *.<%= $domain %>, unauthenticated@unmapped
ALLOW_READ         = *.<%= $domain %>
ALLOW_WRITE        = *.<%= $domain %>
```

For more details, see the [HTCondor documentation](https://htcondor.readthedocs.io/en/latest/admin-manual/security.html#authentication).


## Classes Reference

### Public Classes

- `htcondor`: Main entry point for installation and configuration
- `htcondor::central_manager`: Configures a node as Central Manager
- `htcondor::scheduler`: Configures a node as Scheduler
- `htcondor::worker`: Configures a node as Worker

### Private Classes

- `htcondor::install`: Installs HTCondor and sets up repository
- `htcondor::config`: Manages configuration files and directories
- `htcondor::service`: Manages the HTCondor service
- `htcondor::security`: Manages security configuration
- `htcondor::params`: Centralizes default parameters

## Support

For issues and contributions, please open an issue or pull request on [GitHub](https://github.com/igvaz/htcondor-install-puppetmodule).
