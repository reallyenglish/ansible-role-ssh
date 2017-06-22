# ansible-role-ssh

Configures `/etc/ssh/ssh_known_hosts` and `/etc/ssh/ssh_config`. This role does
not manage users' `known_hosts` or `ssh_config`.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `ssh_conf_dir` | path to directory for system's `ssh` configuration files | `/etc/ssh` |
| `ssh_known_hosts_file` | path to `ssh_known_hosts(5)` | `{{ ssh_conf_dir }}/ssh_known_hosts` |
| `ssh_known_hosts` | list of dict of public key (see below) | `[]` |
| `ssh_config_file` | path to `ssh_config(5)` | `{{ ssh_conf_dir }}/ssh_config` |
| `ssh_config` | content of `ssh_config` | `""` |

## `ssh_known_hosts`

This variable is a list of dict. See [`known_hosts`
module](http://docs.ansible.com/ansible/known_hosts_module.html) for details.

| Key | Value | Description |
|-----|-------|-------------|
| `name` | String | host or IP address of the key |
| `state` | `present` or `absent` | Remove all keys that belong to `name` if `absent`. Add the key to `ssh_known_hosts` if `present` |
| `key` | String | the key |

# Dependencies

None

# Example Playbook

```yaml
- hosts: localhost
  roles:
    - ansible-role-ssh
  vars:
    ssh_config: |
      Port 22
      Protocol 2
    ssh_known_hosts:
      - name: anoncvs.ca.openbsd.org
        key: "anoncvs.ca.openbsd.org ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCz6RLtgGksBp/0dH7M5vGCUxgD31+wX28tnLlij90+cYhjELDV3HX95DypEA7xfIN6W8Vg/GOJkX4Oot+zpQXNQx3VeOyMgcn4KXO83XYGsPVfJQijjzyI0r0/ztEsxYAE6JHEiEvY9floDnNRyoFLVETNE5oB9yBcDIt6W6BYjlpXqJNsEPy7ij+kBbEk7QT0FcyFidp7FmExsOQy23nhQ55A/6fB7ATsDQtz+snniF9ZJg5+b71SYzxfhUPkxJhmhBkx7NmPnRjy7eE0I7qrHODrHONIi1LWCo0joTIAfVgxhEn5SDbviTAINAecGgis5LQqXp0xSupfWuozZeXV"
        state: present
      - name: anoncvs.au.openbsd.org
        # or lookup()
        key: "{{ lookup('file', 'files/anoncvs.au.openbsd.org.pub') }}"
        state: present
      - name: github.com
        key: "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="
        state: present
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

This README was created by [qansible](https://github.com/trombik/qansible)
