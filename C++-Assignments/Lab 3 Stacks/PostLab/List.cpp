// Brian Barbu (brb9da)

#include "List.h"
using namespace std;

List::List(){
	head = new ListNode();
	tail = new ListNode();
	head->previous = NULL;
	tail->next = NULL;
	head->next = tail;
	tail->previous = head;
	count = 0;
}

List::List(const List& source){
	head = new ListNode;
	tail=new ListNode;
    	head->next=tail;
	head->previous = NULL;
    	tail->previous=head;
	tail->next=NULL;
    	count=0;
    	ListItr iter(source.head->next);
    	while (!iter.isPastEnd()) {
        	insertAtTail(iter.retrieve());
        	iter.moveForward();
	}
}
List& List::operator=(const List& source)	{ 
    if (this == &source)
        return *this;
    else {
        makeEmpty();
        ListItr iter(source.head->next);
        while (!iter.isPastEnd()) {
            insertAtTail(iter.retrieve());
            iter.moveForward();
        }
    }
    return *this;
}
List::~List(){
  makeEmpty();
  delete head;
  delete tail;
}

bool List::isEmpty() const{
  return(count==0);
}

void List::makeEmpty(){
   while(!isEmpty()){
	remove(first().retrieve());
   }
}

ListItr List::first(){
  ListItr itrN;
  itrN.current=head->next;
  return itrN;
}

ListItr List::last(){
  ListItr itrN;
  itrN.current=tail->previous;
  return itrN;
}

void List::insertAfter(int x, ListItr position){
  ListNode *pos =position.current;
  ListNode *newNode=new ListNode;
  ListNode *nextNode=pos->next;
  newNode->next=nextNode;
  newNode->previous=pos;
  newNode->value=x;
  pos->next=newNode;
  nextNode->previous=newNode;
  count++;
}

void List::insertBefore(int x, ListItr position){
  ListNode *pos=position.current;
  ListNode *newNode=new ListNode;
  ListNode *prevNode=pos->previous;
  newNode->next=pos;
  newNode->previous=prevNode;
  newNode->value=x;
  prevNode->next=newNode;
  pos->previous=newNode;
  count++;
}

void List::insertAtTail(int x){
  ListNode *newNode=new ListNode;
  ListNode *prevNode=tail->previous;
  newNode->next=tail;
  newNode->value=x;
  prevNode->next=newNode;
  tail->previous=newNode;
  newNode->previous = prevNode;
  count++;
}


void List::remove(int x){
	ListItr itrN=find(x);
	ListNode *pos = itrN.current;
	ListNode *prev = pos -> previous;
	ListNode *nextN = pos -> next;
	prev -> next = nextN;
	nextN -> previous = prev;
	count--;
}


ListItr List::find(int x){
  ListItr itrN=first();
  while(!itrN.isPastEnd()){
	if(itrN.current->value==x){
      		return itrN;
	}
    	else{
      		itrN.moveForward();
    	}
  }
  return itrN;
}

int List::size() const{
  return count;
}

void printList(List& theList, bool forward){
  ListItr itrF = theList.first();
  ListItr itrL = theList.last();
  if(forward){
	while(!itrF.isPastEnd()){
		cout << itrF.retrieve();
		itrF.moveForward();
	}
  }
  else{
	while(!itrL.isPastBeginning()){
		cout << itrL.retrieve();
		itrL.moveBackward();
	}
  }
}
