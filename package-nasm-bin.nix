{
  nasm,
  runCommand,
  stdenv,
}:

runCommand "minimal-elf-nasm-bin"
  {
    nativeBuildInputs = [
      stdenv.cc
      nasm
    ];
  }
  ''
    nasm ${./hello-nasm-bin.S} -f bin -o hello
    install -m 755 -Dt $out hello
  ''
