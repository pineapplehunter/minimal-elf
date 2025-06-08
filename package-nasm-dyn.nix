{
  nasm,
  runCommand,
  binutils-unwrapped,
}:

runCommand "minimal-elf"
  {
    nativeBuildInputs = [
      binutils-unwrapped
      nasm
    ];
  }
  ''
    nasm ${./hello-nasm-dyn.S} -f elf64 -o hello.o
    ld hello.o -o hello --pie -nostdlib -s -static --no-dynamic-linker -znoseparate-code -znorelro -s
    install -Dt $out hello
  ''

