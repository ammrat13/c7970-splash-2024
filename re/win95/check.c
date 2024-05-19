#include <stdbool.h>
#include <stdint.h>

bool check_prefix(const char *prefix) {

  // The prefix is valid as long as its not in a list of blacklisted numbers.
  // This means, it's valid if it contains any non-numeric characters. While
  // we're doing this loop, accumulate into a number to check later.
  uint64_t num = 0;
  for (const char *c = prefix; *c != '\0'; c++) {
    // Check that it's a number
    if (*c < '0' || *c > '9')
      return true;
    // Accumulate
    num *= 10;
    num += (*c - '0');
  }
  // Check against the blacklist
  return num != 333 && num != 444 && num != 555 && num != 666 && num != 777
    && num != 888 && num != 999;
}

bool check_suffix(const char *suffix) {

  // The suffix is valid if all the characters are digits and the sum of all the
  // digits is divisible by seven.
  uint64_t sum = 0;
  for (const char *c = suffix; *c != '\0'; c++) {
    // Check that it's a number
    if (*c < '0' || *c > '9')
      return false;
    // Accumulate
    sum += (*c - '0');
  }
  // Check the sum
  return sum % 7 == 0;
}
