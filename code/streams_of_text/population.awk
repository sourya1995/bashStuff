{
  if ($3 < 3) {
    sum+=int($2)
  }
}

END {
  printf("%'d\n", sum)
}
