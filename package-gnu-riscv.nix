{
  runCommand,
  pkgsCross,
}:

let
riscv = pkgsCross.riscv64;
in

runCommand "minimal-elf" { nativeBuildInputs = [ riscv.buildPackages.gcc ]; } ''
  ${riscv.stdenv.cc.targetPrefix}as ${./hello-gnu-riscv.S} -o hello.o -march=rv64gc
  ${riscv.stdenv.cc.targetPrefix}ld hello.o -o hello --entry entry -z noseparate-code -s
  install -Dt $out hello hello.o
''
