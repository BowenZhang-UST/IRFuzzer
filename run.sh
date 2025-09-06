# Path to this directory
export FUZZING_HOME=$(pwd)
# The LLVM you want to fuzz
export LLVM=llvm-project/build-release
export AFL=AFLplusplus
export PATH=$PATH:$FUZZING_HOME/clang+llvm/bin
# Tell AFL++ to only use our mutator
export AFL_CUSTOM_MUTATOR_ONLY=1
# Tell AFL++ Where our mutator is
export AFL_CUSTOM_MUTATOR_LIBRARY=$FUZZING_HOME/mutator/build/libAFLCustomIRMutator.so
# AFL instrumentation method
export AFL_LLVM_INSTRUMENT=CLASSIC

export TRIPLE=<Your triple>
export CPU=
export ATTR=
export MATCHER_TABLE_SIZE=13780
./AFLplusplus/afl-fuzz -i $FUZZING_HOME/seeds.ll -o fuzzing llvm-isel-afl/build/isel-fuzzing -V 10