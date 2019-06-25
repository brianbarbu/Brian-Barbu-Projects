//Brian Barbu (brb9da)
#include <stdio.h>
#include <stdlib.h>

struct list {
  struct listnode *first;
};

struct listnode {
    struct listnode *prev, *next;
    int num;
  };


int main() {
  int count, input;
  struct list *stack;
  struct listnode *current;

  stack = (struct list*) malloc(sizeof(struct list));
  stack->first = (struct listnode*) malloc(sizeof(struct listnode));
  (stack->first)->num = 0;
  current = stack->first;

  printf("Enter how many values to input: ");
  scanf("%d", &count);

  for(int i = 0; i < count; i++) {
    printf("Enter value %d: ", i+1);
    scanf("%d", &input);
    current->next = (struct listnode*) malloc(sizeof(struct listnode));
    current->num = input;
    current = current->next;
  }

  current = stack->first;
  for(int i = 0; i < count; i++) {
    printf("%d\n", current->num);
    current = current->next;
  }

  free(stack);
  return 0;
}

