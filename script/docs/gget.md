# gget command
Download Code directly from a GitHub Repository.  
Private repositories included (as soon as you have a proper API token)

## Usage:
```
    gget [OPTIONS] <github-user>/<repository> | <full-github-repository-url>

```
You can use the GitHub-like "shorthand": <username/repository>
or the full URL of the repository: https://github.com/<username>/<repository>

#### OPTIONS:

    [-b|--branch]       Branch to pull the code from.
                        If ommitted, the default repository's branch name
                        (usually "main" or "master") will be used insted
    [-t|--tag]          Use it to download files from a given tag instead of a
                        branch (useful to match a particular release version)
    [-o|--output]       Directory to save the code files to. By default the code
                        will be directly downloaded to the current directory
                        (where this script is being run from)
    [-p|--prefix]       Some known prefix for the shorthand. If included it will
                        be prepended to the <repository> part of the shorthand.
                        e.g.: `gget --prefix test- SalDevOps/sample`
                        will make gget to look for either `test-sample` (first)
                        or just `sample` (in case `test-sample` were not found)
    [-u|--user]         The user that tries to download the files.
                        For **public** repositories it's not even required.
                        For **private** repositories, it will be sent to the API
                        for auth purposes (with the API token)
                        By default: the username in the github (url|shorthand)
                        will be sent as the user (-u) in the request to GitHub
    [-s|--secret]       Filename (or full path) to the "secret" file containing
                        the user's GitHub API token. Required to access private
                        repositories
                        

More details at https://github.com/SalDevOps/gget#readme
