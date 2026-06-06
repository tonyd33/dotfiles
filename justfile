# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

set lazy := true

user := `whoami`
host := `cat /proc/sys/kernel/hostname`

# Default command when 'just' is run without arguments
default:
  @just --list

# Update nix flake
[group('Main')]
update:
  nix flake update

# Lint nix files
[group('dev')]
lint:
  nix fmt

# Check nix flake
[group('dev')]
check:
  nix flake check

# Manually enter dev shell
[group('dev')]
dev:
  nix develop

# Activate the configuration
[group('Main')]
run:
  nix run

[group('Main')]
run-home:
  nix run .#activate "{{ user }}@{{ host }}"
