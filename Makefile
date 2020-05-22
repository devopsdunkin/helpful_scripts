MAKEFLAGS=--silent
.PHONY: bash_profile

bash_profile:
  cp .bash_profile /Users/$(whoami)
