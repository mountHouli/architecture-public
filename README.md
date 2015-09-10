# architecture-public
Server architecture

To pull down build.sh and its dependencies

```
read -p "Enter GitHub account name: " githubname; curl -u $githubname -o setup-users-private.sh -H "Accept: application/vnd.github.raw" https://api.github.com/repos/mounthouli/architecture-private/contents/setup-users-private.sh; curl -u $githubname -o build.sh -H "Accept: application/vnd.github.raw" https://api.github.com/repos/mounthouli/architecture-public/contents/build.sh;
```