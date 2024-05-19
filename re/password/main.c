#include <stdbool.h>
#include <stdio.h>

// Externally-defined function
bool check_password(const char* password);

int main(int argc, char** argv) {

  // The password to check should be agrv[1]
  if (argc != 2) {
    printf("Usage: %s PASSWORD\n", argv[0]);
    return 2;
  }

  // Check the password
  bool ret = check_password(argv[1]);
  if (ret) {
    printf("Password is correct\n");
    return 0;
  } else {
    printf("Password is incorrect\n");
    return 1;
  }
}
