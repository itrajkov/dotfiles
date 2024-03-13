#!/bin/bash


LOCAL_DIRECTORY="/home/ivche/dev/personal/trajkov.mk/"
REMOTE_USER="ivche"
REMOTE_HOST="192.168.100.206"
REMOTE_DIRECTORY="~/services/trajkov.mk/"
REMOTE_SSH_PORT="22"

RSYNC_FLAGS="-avz --delete"

SSH_KEY="/home/ivche/.ssh/id_rsa"

echo "Building site.."
pushd $LOCAL_DIRECTORY/
nvm use --lts
npm run build

echo "Deploying site to $REMOTE_HOST..."

rsync $RSYNC_FLAGS -e "ssh -p $REMOTE_SSH_PORT" "$LOCAL_DIRECTORY/_site"/ "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIRECTORY"

if [ $? -ne 0 ]; then
    echo "Deployment failed."
    exit 1
else
    echo "Files transferred, performing post-deployment steps..."
fi

popd

echo "Deployment completed successfully."
