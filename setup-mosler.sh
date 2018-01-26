#!/bin/bash

# System specific setup...

# Mount point for project storage.
# Must exist or proj storage cannot be mounted and symlinks into it will break.
# Prefer not to refer to this explicity in scripts.
mkdir /proj

# Scratch disk
mkdir /scratch