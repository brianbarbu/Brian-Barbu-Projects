//Brian Barbu (brb9da)
/* do not remove these definitions or replace them #includes */
#define NULL 0
typedef long size_t;
void *malloc(size_t size);
void *realloc(void *ptr, size_t size);
void *calloc(size_t nitems, size_t size);
void free(void* ptr);
int printf(const char *format, ...);

/* The following #ifdef and its contents need to remain as-is. */
#ifndef TYPE
#define TYPE short
TYPE sentinel = -1234;
#else
extern TYPE sentinel;
#endif

/* typedefs needed for this task: */
typedef struct node_t { TYPE payload; struct node_t *next; } node;
typedef struct range_t { unsigned int length; TYPE *ptr; } range;

//helper functions
int lengthOf(node *list){
  int i = 0;
  while(list){
    list = (*list).next; i+=1;
  }
  return i;
}

int lengthOfRange(range list){
  return list.length;
}


range convert(node *list) {
  range thislist;
  thislist.ptr = malloc(sizeof(short)* lengthOf(list));
  thislist.length = lengthOf(list);
  int count = 0;
  node *other;
  for(other = list; other ; other = (*other).next){
    thislist.ptr[count] = (*other).payload;
    count++;
  }
  return thislist;
}
void append(range *dest, range source) {
 int x = (*dest).length + lengthOfRange(source);
 int y = (*dest).length;
  
 int i;
 int count = 0;
 if(y == 0){
   if (x != 0){
     (*dest).length = x;
     (*dest).ptr= realloc((*dest).ptr,sizeof(short)*x);
  	 for(i = 0; i < lengthOfRange(source); i += 1){
   		(*dest).ptr[i] = source.ptr[i];
     }
   }
   else{
  		//nothing
   }
 }
 else{
    (*dest).length = x;
 	(*dest).ptr = realloc((*dest).ptr, sizeof(short)*x);
 	for(i = y; i < x; i += 1){
   		(*dest).ptr[i] = source.ptr[count];
   		count +=1;
    }
  }
}
void remove_if_equal(range *dest, TYPE value) {
  range thislist;
  int x;
  int y;
  int count = 0;
  for(x= 0; x < (*dest).length; x++){
    if((*dest).ptr[x] != value){
      count++;
    }
  }
  thislist.ptr = (*dest).ptr;
  int spot = 0;
  for(y=0; y<(*dest).length; y++){
    if((*dest).ptr[y] != value){
      thislist.ptr[spot] = (*dest).ptr[y];
      spot++;
    }
  }
  (*dest).ptr = realloc(thislist.ptr, sizeof(short)*count);
  (*dest).length = count;
}
