#!/bin/bash

BRANCH_NAME="$1"
BRANCH_TO_MERGE_FROM="$2"
BRANCH_TO_MERGE_INTO="$3"
BRANCH_TO_REBASE_ONTO="$4"
BRANCH_TO_REBASE="$5"
BRANCH_TO_DELETE="$6"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/your/webhook/url"  # Replace with your Slack webhook URL
EMAIL_RECIPIENTS="team@example.com"  # Replace with your email recipients

send_notification() {
    local message=$1
    # Slack notification
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$message\"}" $SLACK_WEBHOOK_URL

    # Email notification
    echo "$message" | mail -s "Jenkins Git Operation Notification" $EMAIL_RECIPIENTS
}

create_branch() {
    echo "Creating branch: $BRANCH_NAME"
    git checkout -b "$BRANCH_NAME"
    if [ $? -ne 0 ]; then
        send_notification "Failed to create branch: $BRANCH_NAME"
        exit 1
    fi
}

list_branches() {
    echo "Listing all branches"
    git branch -a
    if [ $? -ne 0 ]; then
        send_notification "Failed to list branches"
        exit 1
    fi
}

merge_branches() {
    echo "Merging branch $BRANCH_TO_MERGE_FROM into $BRANCH_TO_MERGE_INTO"
    git checkout "$BRANCH_TO_MERGE_INTO"
    if [ $? -ne 0 ]; then
        send_notification "Failed to checkout branch: $BRANCH_TO_MERGE_INTO"
        exit 1
    fi

    git merge "$BRANCH_TO_MERGE_FROM"
    if [ $? -ne 0 ]; then
        send_notification "Merge failed between $BRANCH_TO_MERGE_FROM and $BRANCH_TO_MERGE_INTO"
        exit 1
    fi
}

rebase_branches() {
    echo "Rebasing branch $BRANCH_TO_REBASE onto $BRANCH_TO_REBASE_ONTO"
    git checkout "$BRANCH_TO_REBASE"
    if [ $? -ne 0 ]; then
        send_notification "Failed to checkout branch: $BRANCH_TO_REBASE"
        exit 1
    fi

    git rebase "$BRANCH_TO_REBASE_ONTO"
    if [ $? -ne 0 ]; then
        send_notification "Rebase failed for $BRANCH_TO_REBASE onto $BRANCH_TO_REBASE_ONTO"
        exit 1
    fi
}

delete_branch() {
    echo "Deleting branch: $BRANCH_TO_DELETE"
    git branch -d "$BRANCH_TO_DELETE"
    if [ $? -ne 0 ]; then
        send_notification "Failed to delete branch: $BRANCH_TO_DELETE"
        exit 1
    fi
}

create_branch
list_branches
merge_branches
rebase_branches
delete_branch

send_notification "All Git operations completed successfully."
