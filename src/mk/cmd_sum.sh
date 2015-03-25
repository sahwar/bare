cmd_sum() {
  local pkgarchive=$(fetch)

  progress sum "'$name' with '${pkgarchive##*/}'"

  sha512sum $(relative $pkgarchive) > $_SUM/${name}.sum
}
