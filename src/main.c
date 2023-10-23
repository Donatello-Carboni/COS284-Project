#include <stdio.h>

extern float testDeliverable1();

int main() {
  if (testDeliverable1() < 29) {
    printf(
        "Warning: Previous Deliverables are not fully correct and might affect "
        "Deliverable 3\n");
  }
  return 0;
}