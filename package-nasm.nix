{
  nasm,
  runCommand,
  stdenv,
}:

runCommand "minimal-elf"
  {
    nativeBuildInputs = [
      stdenv.cc
      nasm
    ];
  }
  ''
    nasm ${./hello-nasm.S} -f elf64 -o hello.o
    ld hello.o -o hello --entry entry -z noseparate-code -s
    install -Dt $out hello
  ''
