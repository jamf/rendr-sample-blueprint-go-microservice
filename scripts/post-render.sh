#!/usr/bin/env bash

echo 'Creating Helm chart'

helm create $name
rm -rf $name/templates/tests
mv $name helm-chart
mkdir -p helm-chart/env
mv helm-values/* helm-chart/env/
rm -rf helm-values
sed -i '' 's/appVersion: .*/appVersion: latest/' helm-chart/Chart.yaml
sed -i '' "s/containerPort: .*/containerPort: $port/" helm-chart/templates/deployment.yaml

echo 'Initializing Git repository'

git init
git add .
git commit -m 'Initial project generated from Go microservice blueprint'

if [ "$github_create_repo" != "true" ]; then
    echo "Skipping remote repository creation: 'github_create_repo' = '$github_create_repo'. To enable, please provide the '-v github_create_repo:true' flag when generating the project."
    exit 0
fi


if [ -z "$github_id" ]; then
    echo "Skipping remote repository creation: no GitHub ID provided. To enable, please provide the '-v github_id:<your id>' flag when generating the project."
    exit 1
fi

if ! command -v hub &> /dev/null; then
    echo 'Skipping remote repository creation: GitHub CLI `hub` is not installed.'
    echo 'To automatically create a GitHub repository as part of project generation, install and configure the `hub` CLI. See hub.github.com for details.'
    exit 1
fi

echo "Creating GitHub repository $github_id/$name"

if [ "$github_repo_visibility" == "public" ]; then
    flags=''
else
    flags='-p'
fi

hub create $flags $github_id/$name
git push --set-upstream origin master

echo "Done: https://github.com/$github_id/$name"
