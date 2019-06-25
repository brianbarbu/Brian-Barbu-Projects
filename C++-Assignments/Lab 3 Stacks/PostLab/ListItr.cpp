//Brian Barbu (brb9da)

#include "ListItr.h"
using namespace std;

ListItr::ListItr(){
	current = NULL;
}

ListItr::ListItr(ListNode* node){
	current = node;
}
bool ListItr::isPastEnd() const{
	return (current->next == NULL);
}
bool ListItr::isPastBeginning() const{
	return(current->previous==NULL);
}
void ListItr::moveForward(){
	if(this->isPastEnd()!=true){
		current = current->next;
	}
}
void ListItr::moveBackward(){
	if(this->isPastBeginning()!=true){
		current = current->previous;
	}
}
int ListItr::retrieve() const{
	return current->value;
}
