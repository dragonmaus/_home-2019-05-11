#!/bin/sh
acpi_listen | while read E a b c d e f; do
  case $E in
  button/lid)
    case $b in
    close) slock ;;
    esac
    ;;
  esac
done
