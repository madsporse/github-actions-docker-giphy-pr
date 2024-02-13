#!/bin/sh

# Get tokens/keys
GITHUB_TOKEN=$1
GIPHY_API_KEY=$2

# Get PR number
pull_request_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
echo PR Number - $pull_request_number

# Use Giphy API to fetch a random Thank You GIF
giphy_response=$(curl -s "https://api.giphy.com/v1/gifs/random?api_key=$GIPHY_API_KEY&tag=thank%20you&rating=g")
echo Giphy Reponse - $giphy_response

# Extract the GIF URL from the Giphy response
gif_url=$(echo "$giphy_response" | jq --raw-output .data.images.download_url)
echo GIPHY_URL - $gif_url

# Create comment with GIF on pull request
comment_response=$(curl -sX POST -H "Authorization: token $GITHUN_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"body\": \"### PR - #$pull_request_number. \n ### 🎉 Thank you for this contribution! \n  ![GIF]($gif_url) \"}" \
    "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$pull_request_number/comments")

# Extract and print URL from response
comment_url=$(echo "$comment_respone" | jq --raw-output .html_url)
