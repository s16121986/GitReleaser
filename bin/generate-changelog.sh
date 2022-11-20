#!/bin/bash

set -e

#-c ' . escapeshellarg(json_encode($this->getContext()))
gsv-changelog -i CHANGELOG.md -s
