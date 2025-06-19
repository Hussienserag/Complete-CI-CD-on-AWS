# AWS CLI Installation Role

This Ansible role installs AWS CLI v2 on Amazon Linux and Red Hat-based systems.

## Features

- Checks if AWS CLI is already installed
- Downloads and installs AWS CLI v2 from official AWS source
- Creates symlinks for system-wide access
- Cleans up installation files
- Idempotent execution (safe to run multiple times)

## Requirements

- Target system: Amazon Linux 2023, RHEL 8+, CentOS 8+
- Ansible 2.9+
- Internet connectivity on target hosts
- sudo/root privileges

## Usage

Include this role in your playbook:

```yaml
- name: Install AWS CLI
  hosts: your_hosts
  become: true
  roles:
    - aws_cli_installation
```

## Verification

After installation, AWS CLI will be available at:
- `/usr/local/bin/aws` (primary installation)
- `/usr/bin/aws` (symlink for compatibility)

You can verify the installation with:
```bash
aws --version
```

## Author

ITI Project DevOps Team
