#!/bin/bash
# Copyright (c) 2020 Xilinx, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
# * Neither the name of Xilinx nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'  # No Color

# Green echo
gecho () {
  echo -e "${GREEN}$1${NC}"
}

# Red echo
recho () {
  echo -e "${RED}$1${NC}"
}

gecho "Installing finn-base in develop mode"
pip install --user --no-dependencies -e /workspace/finn-base

gecho "Setting up known-good commit versions for FINN-base testing dependencies"
# checkout the correct dependency repo commits
# the repos themselves are cloned in the Dockerfile
BREVITAS_COMMIT=d7ded80fa9557da2998ea310669edee7fb2d9526
# Brevitas
gecho "brevitas @ $BREVITAS_COMMIT"
git -C /workspace/brevitas pull --quiet
git -C /workspace/brevitas checkout $BREVITAS_COMMIT --quiet
pip install --user -e /workspace/brevitas

exec $@
