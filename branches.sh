#!/bin/bash

BRANCH_NAME="$1"
BRANCH1="$2"
BRANCH2="$3"


create_branch() {
    echo "Creating branch: $BRANCH_NAME"
    git checkout -b "$BRANCH_NAME"


}

list_branches() {
    echo "Listing all branches"
    git branch -a
 
}

merge_branches() {
    echo "Merging branch $BRANCH1 into $BRANCH2"
    git checkout "$BRANCH1"
  

    git merge "$BRANCH1"
 
}

rebase_branches() {
    echo "Rebasing branch $BRANCH1 onto $BRANCH2"
    git checkout "$BRANCH1"


    git rebase "$BRANCH2"
  
}

delete_branch() {
    echo "Deleting branch: $BRANCH1"
    git branch -d "$BRANCH1"
   
}

create_branch
list_branches
merge_branches
rebase_branches
delete_branch
