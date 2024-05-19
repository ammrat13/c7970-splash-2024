#include <stdbool.h>
#include <stdio.h>
#include <string.h>

// Externally-defined functions
bool check_prefix(const char *prefix);
bool check_suffix(const char *suffix);

int main(int argc, char** argv) {

  // The key to check should be argv[1]
  if (argc != 2) {
    printf("Usage: %s KEY\n", argv[0]);
    return 2;
  }

  // The key must be exactly 11 characters long
  if (strlen(argv[1]) != 11) {
    printf("Key must be 11 characters\n");
    return 2;
  }

  // Extract the prefix and suffix. Remember to null-terminate them.
  char prefix_buf[4];
  char suffix_buf[8];
  memcpy(prefix_buf, argv[1], 3);
  memcpy(suffix_buf, argv[1] + 4, 7);
  prefix_buf[3] = '\0';
  suffix_buf[7] = '\0';

  // Check both the prefix and the suffix
  bool ret = check_prefix(prefix_buf) && check_suffix(suffix_buf);
  if (ret) {
    printf("Key is valid\n");
    return 0;
  } else {
    printf("Key is invalid\n");
    return 1;
  }
}
