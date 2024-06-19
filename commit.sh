#!/bin/bash

cd ~/Desktop/docker/test-leafy

# 설정 변수
TARGET_DIR=""
ENV_FILE=".env"    # 수정할 파일 경로
SERVICE_TAG=""

if [ $1 -eq 'backend' ]; then 
    TARGET_DIR='./leafy-backend/'
    SERVICE_TAG=''
elif [ $1 -eq 'front' ]; then
    TARGET_DIR='./leafy-front/'
    SERVICE_TAG='LEAFY_FRONTEND_TAG'
elif [ $1 -eq 'postgresql' ]; then
    TARGET_DIR='./leafy-postgresql/'
    SERVICE_TAG='LEAFY_POSTGRES_TAG'
fi

# 특정 폴더 내용 커밋 및 푸쉬
cd $TARGET_DIR
git add .
git commit -m "$COMMIT_MSG1"
git push
COMMITHASH=$(git rev-parse --verify HEAD)

# 다른 파일 수정
# if grep -q "^LEAFY_POSTGRES_TAG=" .env; then sed -i'' -e "s/^LEAFY_POSTGRES_TAG=.*/LEAFY_POSTGRES_TAG=${TEST}/" .env;  else echo "LEAFY_POSTGRES_TAG=${TEST}" >> .env; fi;
if [ ! $SERVICE_TAG -z ] && [ $(grep -c "^${SERVICE_TAG}=" .env) -eq 1 ]
then 
    sed -i '' -e "s/^${SERVICE_TAG}=.*/${SERVICE_TAG}=${COMMITHASH}/" .env
else 
    echo "${SERVICE_TAG}=${COMMITHASH}" >> .env
fi


# 다른 파일 변경 사항 커밋 및 푸쉬
cd ..
git add $(basename $ENV_FILE)
git commit -m "SH ENV FILE UPDATED"
git push