# Nexus Provisioning

## Playbooks
This project uses many playbooks to simplify internal dev testing and
user operations:

  * `pb_nexus5548.yml`: Runs the playbook based on a Nexus 5548 platform.
     Equivalent to running `pb_core.yml` with `device_type` set to `5548`.
  * `pb_nexus93128.yml`: Runs the playbook based on a Nexus 93128 platform.
     Equivalent to running `pb_core.yml` with `device_type` set to `93128`.
  * `pb_core.yml`: Core logic playbook that the aforementioned specialty
    playbooks reference. Supports both local configuration generation and
    live device provisioning using SSH.
      * Use `ansible_connection: local` to generate configs locally. This is
        good for dev testing and for offline deliveries.
      * Use `ansible_connection: network_cli` to provision live devices.
        Assuming there is IP connectivity from the control machine to the
        managed devices, this is usually the preferred option.

## Task files
This project uses many task files for modularity:

  * `live_provision.yml`: Included when `ansible_connection` is set to
    `network_cli`. Logs into the devices and applies the templated config.
  * `local_config.yml`: Included when `ansible_connection` is set to
    `local`. Generates configs locally in the `configs/` directory with
     a date/time stamped subdirectory. Example file tree shown below.
     ```
     $ tree configs/ --charset ascii
     configs/
     |-- 20191108T162914
     |   |-- sw1_93128.txt
     |   `-- sw2_93128.txt
     `-- 20191108T163537
         |-- sw1_5548.txt
         `-- sw2_5548.txt
     ```
  * `precheck.yml`: Always included. Performs basic input validation to
    ensure Ansible-related variables are valid.

## Makefile
The `Makefile` simplifies execution even further using these shortcuts:

  * `lint`: Uses `yamllint` to check all YAML files for syntax/styling issues.
  * `cfg`: Generates local configs using `pb_core.yml` with local connection.
  * `test`: Runs a dev test including linting and local config generation.
    This is the default goal and runs when typing `make` by itself.
  * `n5548`: Runs the `pb_nexus5548.yml` playbook.
  * `n93128`: Runs the `pb_nexus93128.yml` playbook.
  * `clean`: Removes playbook artifacts, such as configurations and logs.
