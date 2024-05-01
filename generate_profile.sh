#!/bin/bash

REPOSITORY_LIST=$1

if [ -z $REPOSITORY_LIST ]; then
    echo "ERROR: epository list is empty!"
    echo "Usage: $0 <repository_list_path>"
    exit 1
fi

# Function to generate table rows
generate_repo_list() {
    local index="$1"
    local repo_name="$2"
    local description="$3"

    # Only get base repo name, execlude the username
    repo_base_name=$(basename $repo_name)

    local stars="<a href=\"https://github.com/$repo_name/stargazers\"><img alt=\"GitHub Repo stars\" src=\"https://img.shields.io/github/stars/$repo_name?style=for-the-badge&color=1fb2a6\"/></a>"

    echo "### $index. [**$repo_base_name**](https://github.com/$repo_name)" >>profile/README.md
    echo "" >>profile/README.md
    echo "$description" >>profile/README.md
    echo "" >>profile/README.md
    echo "$stars" >>profile/README.md
    echo "" >>profile/README.md
    echo "" >>profile/README.md
}

# Start README file with header
echo "<div align=\"center\"><img src=\"https://pub-761b436209f44a4d886487c917806c08.r2.dev/storm-banner.gif\" alt=\"Storm Software\" width=\"100%\"/></div>" >profile/README.md
echo "" >>profile/README.md
echo "<br /><div align=\"center\"><b><a href=\"https://stormsoftware.com\" target=\"_blank\">Website</a><span>&nbsp;&nbsp;•&nbsp;&nbsp;</span><a href=\"https://stormsoftware.com/contact\" target=\"_blank\">Contact</a><span>&nbsp;&nbsp;•&nbsp;&nbsp;</span><a href=\"https://discord.gg/MQ6YVzakM5\" target=\"_blank\">Discord</a><span>&nbsp;&nbsp;•&nbsp;&nbsp;</span><a href=\"https://www.linkedin.com/in/pat-sullivan-dev/\" target=\"_blank\">LinkedIn</a><span>&nbsp;&nbsp;•&nbsp;&nbsp;</span><a href=\"https://medium.com/storm-software\" target=\"_blank\">Medium</a><span>&nbsp;&nbsp;•&nbsp;&nbsp;</span><a href=\"https://www.patreon.com/StormSoftware\" target=\"_blank\">Sponsorship</a><span>&nbsp;&nbsp;•&nbsp;&nbsp;</span><a href=\"https://keybase.io/sullivanp\" target=\"_blank\">OpenPGP Key</a></b></div><br /><div align="center"><b>Fingerprint:</b> 1BD2 7192 7770 2549 F4C9 F238 E6AD C420 DA5C 4C2D</div><hr />" >>profile/README.md
echo "" >>profile/README.md
echo "Storm Software is an open-source software development organization and the creator of Acidic, Storm Stack, and Storm Cloud." >>profile/README.md
echo "" >>profile/README.md
echo "Our mission is to make software development more accessible. Our ideal future is one where anyone can create software without years of prior development experience serving as a barrier to entry. We hope to achieve this via LLMs, generative AI, and intuitive, high-level data modeling and programming languages." >>profile/README.md
echo "<br />"
echo "" >>profile/README.md
echo "<br />" >>profile/README.md
echo "" >>profile/README.md
echo "## <img src=\"https://pub-761b436209f44a4d886487c917806c08.r2.dev/repositories-text.svg\" alt=\"Repositories\" height=\"40px\"/>" >>profile/README.md
echo "This GitHub organization contains repos that are officially maintained by [**Storm Software**](https://stormsoftware.com):" >>profile/README.md
echo "" >>profile/README.md


# Start with index 1 for first repo
index=1

while IFS= read -r repo_name; do
    echo "Working on repo: $repo_name, with index: $index"

    # Make the API request to get repository information
    response=$(curl -s "https://api.github.com/repos/$repo_name")
    echo "Response:"
    echo "$response"

    # Extract the description from the response using jq (ensure jq is installed)
    description=$(echo "$response" | jq -r '.description')

    # Generate table row with incremental index
    generate_repo_list "$index" "$repo_name" "$description"

    # Increment index
    ((index++))
done <"$REPOSITORY_LIST"

echo "" >>profile/README.md
echo "For the full list of repositories, please [**click here**](https://github.com/storm-software?tab=repositories&q=&type=&language=&sort=stargazers)." >>profile/README.md

echo "" >>profile/README.md
echo "<br />" >>profile/README.md
echo "" >>profile/README.md
echo "## <img src=\"https://pub-761b436209f44a4d886487c917806c08.r2.dev/join-us-text.svg\" alt=\"Join us\" height=\"40px\"/>" >>profile/README.md
echo "Join us on [**Discord**](https://discord.gg/MQ6YVzakM5) to chat with the team, receive release notifications, ask questions, and get involved." >>profile/README.md
echo "" >>profile/README.md
echo "If this sounds interesting, and you would like to help us in creating the next generation of development tools, please reach out on our [**website**](https://stormsoftware.com/contact) or join our [**Slack**](https://join.slack.com/t/storm-software/shared_invite/zt-2gsmk04hs-i6yhK_r6urq0dkZYAwq2pA) channel!" >>profile/README.md
echo "" >>profile/README.md
echo "<div align=\"center\"><a href=\"https://stormsoftware.com\" target=\"_blank\"><img src=\"https://pub-761b436209f44a4d886487c917806c08.r2.dev/icon-fill.png\" alt=\"Storm Software\" width=\"200px\"/></a></div>" >>profile/README.md
echo "" >>profile/README.md
echo "<div align=\"center\"><a href=\"https://stormsoftware.com\" target=\"_blank\"><img src=\"https://pub-761b436209f44a4d886487c917806c08.r2.dev/visit-us-text.svg\" alt=\"Visit us at stormsoftware.com\" height=\"90px\"/></a></div>" >>profile/README.md
echo "" >>profile/README.md
echo "" >>profile/README.md


