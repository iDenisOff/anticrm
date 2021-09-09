#!/bin/bash
#  Copyright © 2020, 2021 Anticrm Platform Contributors.
#  Copyright © 2021 Hardcore Engineering Inc.
#  
#  Licensed under the Eclipse Public License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License. You may
#  obtain a copy of the License at https://www.eclipse.org/legal/epl-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

export MONGODB_ROOT_PASSWORD=$(kubectl get secret --namespace default mng-mongodb -o jsonpath="{.data.mongodb-root-password}" | base64 --decode)
export MINIO_ACCESS_KEY=$(kubectl get secret --namespace default minio -o jsonpath="{.data.access-key}" | base64 --decode)
export MINIO_SECRET_KEY=$(kubectl get secret --namespace default minio -o jsonpath="{.data.secret-key}" | base64 --decode)

kubectl run anticrm-tool --rm --tty -i --restart='Never' \
  --env="MONGO_URL=mongodb://root:$MONGODB_ROOT_PASSWORD@mng-mongodb:27017/" \
  --env="MINIO_ACCESS_KEY=$MINIO_ACCESS_KEY" \
  --env="MINIO_SECRET_KEY=$MINIO_SECRET_KEY" --image anticrm/tool --command -- bash
