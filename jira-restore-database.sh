#!/bin/bash

JIRA_BACKUPS_CONTAINER=$(docker ps -aqf "name=jira_backups")

echo "--> All available database backups:"

for entry in $(docker container exec -it $JIRA_BACKUPS_CONTAINER sh -c "ls /srv/jira-postgres/backups/")
do
  echo "$entry"
done

echo "--> Copy and paste the backup name from the list above to restore database and press [ENTER]
--> Example: jira-postgres-backup-YYYY-MM-DD_hh-mm.gz"
echo -n "--> "

read SELECTED_DATABASE_BACKUP

echo "--> $SELECTED_DATABASE_BACKUP was selected"

echo "--> Scaling service down..."
docker service scale jira_jira=0

echo "--> Restoring database..."
docker exec -it $JIRA_BACKUPS_CONTAINER sh -c 'PGPASSWORD="$(cat $POSTGRES_PASSWORD_FILE)" dropdb -h postgres -p 5432 jiradb -U jiradbuser \
&& PGPASSWORD="$(cat $POSTGRES_PASSWORD_FILE)" createdb -h postgres -p 5432 jiradb -U jiradbuser \
&& PGPASSWORD="$(cat $POSTGRES_PASSWORD_FILE)" gunzip -c /srv/jira-postgres/backups/'$SELECTED_DATABASE_BACKUP' | PGPASSWORD=$(cat $POSTGRES_PASSWORD_FILE) psql -h postgres -p 5432 jiradb -U jiradbuser'
echo "--> Database recovery completed..."

echo "--> Scaling service up..."
docker service scale jira_jira=1
