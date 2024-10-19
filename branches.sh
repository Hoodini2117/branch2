#!/bin/bash

BRANCH_NAME="$1"
BRANCH_TO_MERGE_FROM="$2"
BRANCH_TO_MERGE_INTO="$3"
BRANCH_TO_REBASE_ONTO="$4"
BRANCH_TO_REBASE="$5"
BRANCH_TO_DELETE="$6"
create_branch() {
    echo "Creating branch: $BRANCH_NAME"
    git checkout -b "$BRANCH_NAME"


}

list_branches() {
    echo "Listing all branches"
    git branch -a
 
}

merge_branches() {
    echo "Merging branch $BRANCH_TO_MERGE_FROM into $BRANCH_TO_MERGE_INTO"
    git checkout "$BRANCH_TO_MERGE_INTO"
  

    git merge "$BRANCH_TO_MERGE_FROM"
 
}

rebase_branches() {
    echo "Rebasing branch $BRANCH_TO_REBASE onto $BRANCH_TO_REBASE_ONTO"
    git checkout "$BRANCH_TO_REBASE"


    git rebase "$BRANCH_TO_REBASE_ONTO"
  
}

delete_branch() {
    echo "Deleting branch: $BRANCH_TO_DELETE"
    git branch -d "$BRANCH_TO_DELETE"
   
}

create_branch
list_branches
merge_branches
rebase_branches
delete_branch

send_notification "All Git operations completed successfully."
