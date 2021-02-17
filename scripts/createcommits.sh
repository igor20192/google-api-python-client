#!/bin/bash
# Copyright 2021 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

git config --global user.name 'Yoshi Automation'
git config --global user.email 'yoshi-automation@google.com'

while read api;
do
    name=`echo $api | cut -d '.' -f 1`
    API_SUMMARY_PATH=temp/$name.verbose

    if [[ ! -f "temp/$name.sha" ]]; then
        git add 'googleapiclient/discovery_cache/documents/'$name'.*.json'
        git add 'docs/dyn/'$name'_*.html'

        if [[ -f "$API_SUMMARY_PATH" ]]; then
            commitmsg=`cat $API_SUMMARY_PATH`
        else
            commitmsg='chore('$name'): update the api'
        fi

        git commit 'googleapiclient/discovery_cache/documents/'$name'.*.json' 'docs/dyn/'$name'_*.html' -m "$commitmsg"
        git rev-parse HEAD>temp/$name'.sha'
    fi
done < changed_files
exit 0
