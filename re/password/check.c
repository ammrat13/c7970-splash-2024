#include <stdbool.h>
#include <stddef.h>

// The password to check against
const char* PASSWORD = "95MzH2F0dxYh";

bool check_password(const char* password) {

  // Pointers to where we are in both passwords.
  const char* p_expected = PASSWORD;
  const char* p_actual = password;

  // Keep going until we break out
  while (true) {

    // Get the current characters
    char cur_expected = *p_expected;
    char cur_actual = *p_actual;

    // If the current actual character is a letter, swap the case
    if ((cur_actual >= 'a' && cur_actual <= 'z')
    || (cur_actual >= 'A' && cur_actual <= 'Z')) {
      cur_actual ^= 0x20;
    }

    // Check that they match
    if (cur_expected != cur_actual)
      return false;

    // Check if we're at the end
    if (cur_expected == '\0')
      return true;

    // Otherwise, move on to the next character
    p_expected++;
    p_actual++;
  }
}
