#!/bin/bash

# Explicit call to ml-yacc needed here as there is a bug in CM (Compilation Manager).
ml-yacc tiger.grm &&
  ml-build sources.cm Main.main &&
  head -1 tiger.grm.desc &&

(
  for tigerSource in ../testcases/*.tig; do
    echo -- $tigerSource --
    cat $tigerSource
    echo --
    sml @SMLload=sources.x86-linux $tigerSource
    echo
  done
) > run.actual.out

diff run.expected.out run.actual.out && echo "good!"
echo status=$?
